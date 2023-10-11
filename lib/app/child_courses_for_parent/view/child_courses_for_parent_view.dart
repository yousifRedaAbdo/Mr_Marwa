import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/strings.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../../base_screen.dart';
import '../../single_student_report/view/single_student_report_view.dart';
import '../../../utils/colors.dart';
import '../view_model/child_courses_for_parent_view_model.dart';

class ChildCoursesForParentView extends StatelessWidget {
  String firstName, lastName, childId, childName;

  ChildCoursesForParentView({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.childId,
    required this.childName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChildCoursesForParentViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getChildCourseToParent(childId: childId);
      },
      builder: (context, viewModel, child) {
        return SafeArea(
          bottom: false,
          right: false,
          left: false,
          top: false,
          child: Scaffold(
            backgroundColor: backgroundColor,
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
              title: appBarTitle('$firstName $lastName'),
            ),
            body: viewModel.dataState == false
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : viewModel.coursesList.isEmpty
                    ? Center(
                        child: mediumText(
                          tr('no_data'),
                          color: mainColor,
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.coursesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  Image.network(
                                    viewModel.coursesList[index]
                                            .overviewfiles[0].fileurl.isEmpty
                                        ? defaultCourseImage
                                        : '${viewModel.coursesList[index].overviewfiles[0].fileurl}?token=${viewModel.token}',
                                  ),
                                  heightSpace(10),
                                  mediumText(
                                      viewModel.coursesList[index].fullname),
                                  heightSpace(10),
                                  mediumText(
                                      viewModel.coursesList[index].contacts[0]
                                          .fullname,
                                      color: mainColor),
                                  heightSpace(5),
                                ],
                              ),
                            ).onTap(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SingleStudentReportView(
                                      childName,
                                      childId,
                                      viewModel.coursesList[index].id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
