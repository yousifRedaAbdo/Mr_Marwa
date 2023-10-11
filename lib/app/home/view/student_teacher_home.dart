import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/home/widgets/no_content.dart';

import 'package:mrs_marwa/app/home_drawer/view/home_drawer.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../../routs/routs_names.dart';
import '../../course_content/view/tree_course_content.dart';
import '../../parent_home/widgets/exit_app_dialog.dart';
import '../view_model/student_teacher_view_model.dart';
import '../widgets/course_card.dart';
import '../widgets/hidden_course_card.dart';

class StudentTeacherHomeView extends StatefulWidget {
  StudentTeacherHomeView({Key? key}) : super(key: key);

  @override
  State<StudentTeacherHomeView> createState() => _StudentTeacherHomeViewState();
}

class _StudentTeacherHomeViewState extends State<StudentTeacherHomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StudentTeacherHomeViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getUserToken();
        if (!mounted) return;
        viewModel.getCourse(context);
      },
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            bool exit = await showDialog(
              context: context,
              builder: (context) {
                return const ExitAPPDialog();
              },
            );
            return Future.value(exit);
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            drawer: const HomeDrawerView(),
            appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradColor1, gradColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: appBarTitle(tr('mr_name')),
              centerTitle: false,
            ),
            body: viewModel.state == ViewState.Busy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : viewModel.reservation == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: viewModel.coursesList.isEmpty
                            ? noCoursesAvail()
                            : ListView.builder(
                                itemCount: viewModel.coursesList.length,
                                itemBuilder: (context, index) {
                                  return courseCard(
                                    context: context,
                                    model: viewModel.coursesList[index],
                                    viewModel: viewModel,
                                  ).onTap(
                                    () async {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            color: mainColor,
                                          ),
                                        ),
                                      );
                                      await viewModel.incCourseView(
                                        courseId: viewModel
                                            .coursesList[index].courseId!,
                                      );
                                      if (!mounted) return;
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              TreeCourseContentView(
                                            courseId: viewModel
                                                .coursesList[index].courseId!,
                                            courseTitle: viewModel
                                                .coursesList[index].courseName!,
                                          ),
                                        ),
                                        ModalRoute.withName(
                                          RouteName.treeCourseContentView,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: viewModel.hiddenCoursesList.isEmpty
                            ? noCoursesAvail()
                            : ListView.builder(
                                itemCount: viewModel.hiddenCoursesList.length,
                                itemBuilder: (context, index) {
                                  return hiddenCourseCard(
                                    viewModel,
                                    index,
                                  ).onTap(
                                    () async {
                                      await viewModel.enrollStudentToCourse(
                                        token: viewModel.token!,
                                        courseId: viewModel
                                            .hiddenCoursesList[index].courseId!,
                                      );
                                      if (viewModel
                                          .enrollStudentToCourseState) {
                                        if (!mounted) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TreeCourseContentView(
                                              courseId: viewModel
                                                  .hiddenCoursesList[index]
                                                  .courseId!,
                                              courseTitle: viewModel
                                                  .hiddenCoursesList[index]
                                                  .courseName!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                      ),
          ),
        );
      },
    );
  }
}
