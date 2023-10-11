import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../view_model/quiz_without_feedback_detail_report_view_model.dart';
import 'quiz_without_feedback_report_deatils.dart';

class QuizWithFeedbackReportDetailView extends StatelessWidget {
  String title;
  String courseId;
  String objectId;

  QuizWithFeedbackReportDetailView(this.title, this.courseId, this.objectId,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<QuizReportViewModel>(
      onModelReady: (viewModel) {
        viewModel.getHomeWorkReport(
          id: objectId,
          sortType: 'atoz',
          context: context,
        );
      },
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
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
              title: appBarTitle(tr('quiz_with_feedback')),
              centerTitle: true,
              bottom: TabBar(
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                automaticIndicatorColorAdjustment: true,
                labelColor: mainColor,
                unselectedLabelColor: backgroundColor,
                indicator: const BoxDecoration(
                  color: backgroundColor,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      tr('submitted'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('in_progress'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('not_submitted'),
                    ),
                  ),
                ],
              ),
              actions: [
                DropdownButton(
                  hint: Text(
                    'order_by'.tr(),
                    style: const TextStyle(color: whiteColor, fontSize: 18),
                  ),
                  underline: heightSpace(0),
                  value: viewModel.selectionOrder,
                  alignment: AlignmentDirectional.center,
                  dropdownColor: mainColor,
                  iconSize: 0,
                  items: viewModel.orderByList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value,
                          style:
                              const TextStyle(color: whiteColor, fontSize: 18)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    viewModel.sortData(
                      context,
                      newValue!,
                      objectId,
                    );
                  },
                )
              ],
            ),
            body: viewModel.state == ViewState.Busy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : TabBarView(
                    children: [
                      submittedView(
                        viewModel.submittedList,
                        courseId,
                      ),
                      inProgressView(
                        viewModel.inProgressList,
                        courseId,
                      ),
                      notSubmittedView(
                        viewModel.notSubmittedList,
                        courseId,
                      )
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: backgroundColor,
              elevation: 10,
              child: const Icon(
                Icons.download,
                color: mainColor,
              ),
              onPressed: () async {
                viewModel.generateHomeWorkReportPDF.generateReport(
                  'Quiz With Feedback',
                  viewModel.submittedList,
                  viewModel.inProgressList,
                  viewModel.notSubmittedList,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
