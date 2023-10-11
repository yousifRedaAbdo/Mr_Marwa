import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/reports/quiz_report/view/quiz_with_feedback_report_detail_view.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../view_model/quiz_without_feedback_report_view_model.dart';

class QuizWithFeedbackReportView extends StatelessWidget {
  String courseId;

  QuizWithFeedbackReportView(this.courseId);

  @override
  Widget build(BuildContext context) {
    return BaseView<QuizWithoutFeedbackReportViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getQuizWithFeedbackReport(
            courseId: courseId, token: viewModel.token);
      },
      builder: (context, viewModel, child) {
        return  Scaffold(
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
                  tr('quiz_with_feedback'),
                ),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.quizWithFeedbackList.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.quizWithFeedbackList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [gradColor1, gradColor2],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
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
                                        viewModel
                                            .quizWithFeedbackList[index].name!,
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
                                          QuizWithFeedbackReportDetailView(
                                        viewModel
                                            .quizWithFeedbackList[index].name!,
                                        courseId,
                                        viewModel.quizWithFeedbackList[index]
                                            .instance!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
        );
        ;
      },
    );
  }
}
