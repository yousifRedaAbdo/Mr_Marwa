import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_content/view_model/tree_course_content_view_model.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/texts.dart';
import '../../course_content_drawer/view/course_content_drawer.dart';
import '../../course_details/widgets/hidden_content.dart';
import '../../parent_home/widgets/exit_app_dialog.dart';
import '../widgets/available_content.dart';

class TreeCourseContentView extends StatefulWidget {
  String courseTitle;
  String courseId;

  TreeCourseContentView({
    Key? key,
    required this.courseTitle,
    required this.courseId,
  }) : super(key: key);

  @override
  State<TreeCourseContentView> createState() => _TreeCourseContentViewState();
}

class _TreeCourseContentViewState extends State<TreeCourseContentView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TreeCourseContentViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getCourseContentLists(
          token: viewModel.token,
          courseId: widget.courseId,
        );
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
            appBar: AppBar(
              title: appBarTitle(widget.courseTitle),
              elevation: 0,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradColor1, gradColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            drawer: CourseContentDrawerView(
              forumUrl: viewModel.forumUrl,
              id: widget.courseId,
              isForumListEmpty: viewModel.isForumListEmpty,
            ),
            body: viewModel.isCourseLoaded
                ? SingleChildScrollView(
                    child: ExpansionPanelList.radio(
                      animationDuration: const Duration(milliseconds: 700),
                      children: viewModel.contentsList.map((e) {
                        return ExpansionPanelRadio(
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              iconColor: blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: title(e.name!),
                            );
                          },
                          body: Column(
                            children: e.modules!
                                .map(
                                  (element) => element.uservisible == true
                                      ? availableContent(element).onTap(
                                          () async {
                                            viewModel.checkContent(
                                              context: context,
                                              element: element,
                                              viewModel: viewModel,
                                              courseId: widget.courseId,
                                            );
                                          },
                                        )
                                      : hiddenContent(
                                          context: context,
                                          image: 'assets/icons/icons_video.png',
                                          text: element.name!,
                                          activityId: element.id!,
                                          courseId: widget.courseId,
                                          availMessages: element.availMessage!,
                                          viewModel: viewModel,
                                          element: element,
                                        ),
                                )
                                .toList(),
                          ),
                          value: e.id!,
                        );
                      }).toList(),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
