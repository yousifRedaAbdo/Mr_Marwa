import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/navigation_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

import '../../../base_view_model.dart';
import '../../../comman_widgets/snak_bars.dart';
import '../../course_details/model/course_details_model.dart';
import '../model/course_model.dart';
import '../model/hidden_courses_model.dart' as hidden;

class StudentTeacherHomeViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var api = locator<ApiService>();
  var navigation = locator<NavigationService>();
  bool reservation = true;
  bool enrollStudentToCourseState = false;


  String? token;

  List<Course> coursesList = [];
  List<hidden.Data> hiddenCoursesList = [];
  List<Contents> contentsList = [];
  List<List<Modules>> modulesList = [];
  List<String> moduleIds = [];
  String courseForumUrl = '';

  getUserToken() async {
    setState(ViewState.Busy);
    token = await pref.getString(userToken);
  }

  /// get course data hidden
  getCourseDataHidden(context) async {
    var data =
        await api.getCourseHidden(token: token!, teacherId: teacherUniqueId);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else {
      var x = hidden.HiddenCoursesModel.fromJson(data, token: token!);
      for (var i in x.data!) {
        hiddenCoursesList.add(i);
      }
      setState(ViewState.Idle);
    }
  }

  getCourse(
    context,
  ) async {
    var data = await api.getCourse(token: token!);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else {
      if (data['status'] == 'fail') {
        reservation = false;
        await getCourseDataHidden(context);
        setState(ViewState.Idle);
      } else {
        for (var i in data['data']) {
          coursesList.add(Course.fromJson(i, token: token!));
        }
        setState(ViewState.Idle);
      }
      setState(ViewState.Idle);
    }
  }

  enrollStudentToCourse({
    required String token,
    required String courseId,
  }) async {
    enrollStudentToCourseState =
        await api.enrollStudentToCourse(token: token, courseId: courseId);
    setState(ViewState.Idle);
  }

  incCourseView({
    required String courseId,
  }) async {
    var data = await api.incCourseView(courseId: courseId);
    if (data == 'fail') {
      print('can not inc course view');
    }
    print(data);
  }

  addCourseRating({
    required BuildContext context,
    required String courseId,
    required String rate,
  }) async {
    var token = await pref.getString(userToken);
    var data = await api.addCourseRate(
      courseId: courseId,
      token: token,
      rate: rate,
    );
    if (data == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(unKnownErrorSnackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(rateSnackBar);
    }
  }
}
