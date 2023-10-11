import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';

import '../model/single_student_report_model.dart';

class SingleStudentReportViewModel extends BaseViewModel {
  var apiServices = locator<ApiService>();
  List<Exam> allQuizzesList = [];
  List<Quiz> quizList = [];
  List<Homework> allHomeWorkVideosList = [];
  List<File> allQuizVideosList = [];
  List<Lesson> allLessonList = [];
  List<Summary> summaryList = [];
  List<Pdf> pdfList = [];
  List<Assign> assignList = [];
  List<Revision> revisionList = [];

  getStudentReport({
    required String courseId,
    required String userId,
  }) async {
    var data =
        await apiServices.getStudentReport(courseId: courseId, userId: userId);
    if (data == 'fail') {
    } else {
      StudentReportModel model = StudentReportModel.fromJson(data);
      // quiz
      for (var i in model.quiz) {
        quizList.add(i);
      }
      for (var i in model.exam) {
        allQuizzesList.add(i);
      }
      for (var i in model.homework) {
        allHomeWorkVideosList.add(i);
      }

      for (var i in model.file) {
        allQuizVideosList.add(i);
      }
      for (var i in model.lesson) {
        allLessonList.add(i);
      }

      for (var i in model.summary) {
        summaryList.add(i);
      }

      for (var i in model.pdf) {
        pdfList.add(i);
      }
      for (var i in model.assign) {
        assignList.add(i);
      }
      for (var i in model.revision) {
        revisionList.add(i);
      }

      setState(ViewState.Idle);
    }
  }
}
