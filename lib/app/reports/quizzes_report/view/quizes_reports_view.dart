import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/extensions.dart';


import '../../../../base_screen.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/spaces.dart';
import '../../../../utils/texts.dart';
import '../view_model/quizes_reports_view_model.dart';
import 'attendance_view.dart';

class QuizesReportView extends StatelessWidget {
  String courseId;

  QuizesReportView(this.courseId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BaseView<QuizesReportsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getAllQuizesReport(id: courseId);
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
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
                centerTitle: true,
                title: appBarTitle(tr('quizzes_reports')),
              ),
              body: viewModel.quizzesReportList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.quizzesReportList.length,
                      itemBuilder: (context, index) {
                        return reportCard(
                          context: context,
                          image: 'assets/icons/icons_reports.png',
                          text: viewModel.quizzesReportList[index].name,
                          quizId: viewModel.quizzesReportList[index].id,
                          courseId: courseId,
                        );
                      },
                    ),
            ),
        );
      },
    );
  }
}

//
Widget reportCard({
  context,
  required String image,
  required String text,
  required String quizId,
  required String courseId,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: mainColor,
    ),
    child: Row(
      children: [
        Image.asset(
          image,
          height: 35,
        ),
        widthSpace(20),
        Flexible(child: mediumText(text, color: whiteColor)),
      ],
    ),
  ).onTap(() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceView(
          quizId,
          courseId,
        ),
      ),
    );
  });
}
