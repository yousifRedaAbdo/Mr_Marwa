import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/utils/strings.dart';

import '../../../../services/shared_pref_services.dart';
import '../../../course_details/model/course_details_model.dart';
import '../../revision_reports/model/revision_report_model.dart';

class SummaryReportsViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();

  var apiServices = locator<ApiService>();
  String token = '';
  bool dataState = false;
  List<Modules> lessonsList = [];
  List<Seen> seenList = [];
  String previousSelected = 'asc'; //ascending
  List<String> orderByList = [
    tr("name"),
    tr("views"),
    tr("date"),
    tr("center"),
  ];
  String? selectionOrder;

  getToken() async {
    token = await pref.getString(userToken);
  }

  sortData(
    context, {
    required String newValue,
    required String courseId,
    required String objectId,
  }) {
    setState(ViewState.Busy);

    if (newValue == tr("name")) {
      seenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'ztoa',
        );
      } else {
        previousSelected = 'asc';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'atoz',
        );
      }
    }
    if (newValue == tr("views")) {
      seenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'viewsDesc',
        );
      } else {
        previousSelected = 'asc';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'viewsAsc',
        );
      }
    }
    if (newValue == tr("date")) {
      seenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'lastseenDesc',
        );
      } else {
        previousSelected = 'asc';
        getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'lastseenAsc',
        );
      }
    }
    if (newValue == tr("center")) {
      previousSelected = 'des';
      setState(ViewState.Idle);
      getLessonsDetails(
        context,
        courseId: courseId,
        objectId: objectId,
        sortType: 'centername',
      );
    }
  }

  void getLessons({required String courseId, required String token}) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.modname == 'resource' &&
              element.resourceType == 'lesson') {
            lessonsList.add(element);
          }
        }
      }
    }
    dataState = true;
    setState(ViewState.Idle);
  }

  void getSummary({required String courseId, required String token}) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.resourceType == 'summary') {
            lessonsList.add(element);
          }
        }
      }
    }
    dataState = true;
    setState(ViewState.Idle);
  }

  void getLessonsDetails(
    context, {
    required String courseId,
    required String objectId,
    required String sortType,
  }) async {
    setState(ViewState.Busy);
    try {
      var data = await apiServices.getCourseVideosReport(
        courseId: courseId,
        objectId: objectId,
        sortType: sortType,
      );
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
        QuizVideosReportModel quizVideosReportModel =
            QuizVideosReportModel.fromJson(data);
        for (var i in quizVideosReportModel.seen) {
          seenList.add(i);
        }
        dataState = true;
        setState(ViewState.Idle);
      }
    } catch (e) {}
  }
}
