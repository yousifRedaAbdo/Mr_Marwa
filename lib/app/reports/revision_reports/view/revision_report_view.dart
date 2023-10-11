import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/reports/revision_reports/view/revision_report_details_view.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../../base_screen.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/spaces.dart';
import '../../../../utils/texts.dart';
import '../view_model/revision_report_view_model.dart';

class RevisionReportView extends StatelessWidget {
  String courseId;

  RevisionReportView(this.courseId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RevisionReportViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getRevisionsReports(
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
                  tr('revisions'),
                ),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.quizVideos.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.quizVideos.length,
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
                                        viewModel.quizVideos[index].name!,
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
                                          RevisionReportDetailsView(
                                        viewModel.quizVideos[index].name!,
                                        courseId,
                                        viewModel.quizVideos[index].instance!,
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
