import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/reports/assignment_report/view_model/assignment_report_view_model.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../../utils/spaces.dart';
import '../../../../utils/texts.dart';
import 'adsignment_report_details_view.dart';

class AssignmentReportView extends StatelessWidget {
  String courseId;

  AssignmentReportView(this.courseId);

  // AssignmentReportView({required String courseId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AssignmentReportViewModel>(
      onModelReady: (viewModel) {
        viewModel.getAssignment(courseId: courseId);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
              appBar: AppBar(
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
                title: appBarTitle('Assignment reports'),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.assignmentList.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.assignmentList.length,
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
                                        viewModel.assignmentList[index].name,
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
                                          AssignmentReportDetailsView(
                                        title: viewModel
                                            .assignmentList[index].name,
                                        courseId: courseId,
                                        objectId: viewModel
                                            .assignmentList[index].id
                                            .toString(),
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
