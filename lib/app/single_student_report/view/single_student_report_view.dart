import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../model/single_student_report_model.dart';
import '../view_model/single_student_report_view_model.dart';

class SingleStudentReportView extends StatelessWidget {
  String userName;
  String userId;
  String courseID;

  SingleStudentReportView(this.userName, this.userId, this.courseID, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SingleStudentReportViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getStudentReport(courseId: courseID, userId: userId);
      },
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 8,
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
              title: appBarTitle(userName),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
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
                      tr('lecture_videos'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('summary_videos'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('quiz_videos'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('homework_videos'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('quizzes'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('revisions'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr('assignments'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Pdf',
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: backgroundColor,
              child: TabBarView(
                children: [
                  //lecture
                  ViewOrNotView(viewModel.allLessonList),
                  //summary
                  ViewOrNotView(viewModel.summaryList),
                  //quiz video
                  ViewOrNotView(viewModel.allQuizVideosList),
                  // allHomeWorkVideosList
                  ViewOrNotView(viewModel.allHomeWorkVideosList),
                  //quiz
                  NormalQuiz(viewModel.quizList),
                  //revision
                  ViewOrNotView(viewModel.revisionList),
                  //Assignment
                  Assignment(viewModel.assignList),
                  //pdf
                  ViewOrNotView(viewModel.pdfList),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AllQuizzes extends StatelessWidget {
  List<Exam> allQuizzesList;

  AllQuizzes(this.allQuizzesList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allQuizzesList.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven ? mainColor : whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allQuizzesList[index].quizname,
                      style: TextStyle(
                        color: index.isEven ? whiteColor : blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              allQuizzesList[index].grade == ''
                  ? Flexible(
                      flex: 1,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                        ),
                      ),
                    )
                  : Flexible(
                      flex: 1,
                      child: Text(
                        '${tr('grade')} ${allQuizzesList[index].grade}',
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}

class NormalQuiz extends StatelessWidget {
  List<Quiz> allQuizList;

  NormalQuiz(this.allQuizList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allQuizList.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven ? mainColor : whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  allQuizList[index].quizname,
                  style: TextStyle(
                    color: index.isEven ? whiteColor : blackColor,
                  ),
                ),
              ),
              const Spacer(),
              allQuizList[index].status == 'notsubmitted'
                  ? Flexible(
                      child: Text(
                        tr('not_submitted'),
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                        ),
                      ),
                    )
                  : Flexible(
                      flex: 1,
                      child: Text(
                        '${tr('grade')}: ${allQuizList[index].grade}',
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class Assignment extends StatelessWidget {
  List<Assign> assignmentList;

  Assignment(this.assignmentList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assignmentList.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven ? mainColor : whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  assignmentList[index].assignName,
                  style: TextStyle(
                    color: index.isEven ? whiteColor : blackColor,
                  ),
                ),
              ),
              const Spacer(),
              assignmentList[index].submissionState == 'notsubmited'
                  ? Flexible(
                      child: Text(
                        tr('not_submitted'),
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                        ),
                      ),
                    )
                  : assignmentList[index].grade == "-1.00000"
                      ? Flexible(
                          flex: 1,
                          child: Text(
                            tr('not_graded_yet'),
                            style: TextStyle(
                              color: index.isEven ? whiteColor : blackColor,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Flexible(
                          flex: 1,
                          child: Text(
                            '${tr('grade')}: ${assignmentList[index].grade}',
                            style: TextStyle(
                              color: index.isEven ? whiteColor : blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ViewOrNotView extends StatelessWidget {
  List dataList;

  ViewOrNotView(this.dataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven ? mainColor : whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataList[index].fileName,
                      style: TextStyle(
                        color: index.isEven ? whiteColor : blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              widthSpace(40),
              dataList[index].views == '0'
                  ? Expanded(
                      flex: 1,
                      child: Text(
                        tr('not_viewed'),
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Text(
                        '${tr('number_of_view')}: ${dataList[index].views!} ',
                        style: TextStyle(
                          color: index.isEven ? whiteColor : blackColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
