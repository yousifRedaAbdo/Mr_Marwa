import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../home_work_videos_report/view/home_work_videos_report_detail_view.dart';
import '../view_model/lessons_report_view_model.dart';
import 'lessons_reports_deatils_view.dart';

// ignore: must_be_immutable
class LessonsReportsView extends StatelessWidget {
  String courseId;

  LessonsReportsView(this.courseId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LessonsReportsViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getLessons(courseId: courseId, token: viewModel.token);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradColor1, gradColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                title: appBarTitle(
                  tr('lessons'),
                ),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.lessonsList.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.lessonsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [gradColor1, gradColor2],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/icons_question.png',
                                      height: 35,
                                    ),
                                    widthSpace(20),
                                    Flexible(
                                      child: mediumText(
                                        viewModel.lessonsList[index].name!,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ).onTap(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SeenAndUnseenView(
                                        viewModel.lessonsList[index].name!,
                                        courseId,
                                        viewModel.lessonsList[index].instance!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }
}
