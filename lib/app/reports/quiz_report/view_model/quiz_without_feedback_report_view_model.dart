import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/utils/strings.dart';

import '../../../../enums/screen_state.dart';
import '../../../../services/shared_pref_services.dart';
import '../../../course_details/model/course_details_model.dart';

class QuizWithoutFeedbackReportViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  String token = '';
  bool dataState = false;

  List<Modules> quizWithOutFeedbackList = [];
  List<Modules> quizWithFeedbackList = [];

  getToken() async {
    token = await pref.getString(userToken);
  }

  void getQuizWithOutFeedbackReport({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.quizType == 'exam') {
            quizWithOutFeedbackList.add(element);
          }
        }
      }
      dataState = true;
    }
    setState(ViewState.Idle);
  }

  void getQuizWithFeedbackReport({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;

        for (var element in x!) {
          if (element.quizType == 'quiz') {
            quizWithFeedbackList.add(element);
          }
        }
      }
    }
    dataState = true;

    setState(ViewState.Idle);
  }
}
