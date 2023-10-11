import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../base_view_model.dart';
import '../../../../enums/screen_state.dart';
import '../../../../locator.dart';
import '../../../../services/api_service.dart';
import '../../../../services/shared_pref_services.dart';
import '../../../../utils/strings.dart';
import '../../../course_details/model/course_details_model.dart';
import '../generate_quiz_videos_pdf/generate_quiz_pdf.dart';
import '../model/revision_report_model.dart';

class RevisionReportViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  GenerateQuizVideosReportPDF generateQuizVideosReportPDF =
      GenerateQuizVideosReportPDF();
  var apiServices = locator<ApiService>();
  String status = 'loading';
  String token = '';
  String previousSelected = 'asc'; //ascending
  List<Modules> quizVideos = [];
  List<Seen> seenList = [];
  List<Notseen> unSeenList = [];
  List<String> orderByList = [
    tr("name"),
    tr("views"),
    tr("date"),
    tr("center"),
  ];
  String? selectionOrder;

  bool dataState = false;

  getToken() async {
    token = await pref.getString(userToken);
  }

  sortData(
    context, {
    required String newValue,
    required String courseId,
    required String objectId,
  }) {
    if (newValue == tr("name")) {
      seenList = [];
      unSeenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getQuizVideosReportDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'atoz',
        );
      } else {
        previousSelected = 'asc';
        getQuizVideosReportDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'ztoa',
        );
      }
    }
    if (newValue == tr("views")) {
      seenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getQuizVideosReportDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'viewsDesc',
        );
      } else {
        previousSelected = 'asc';
        getQuizVideosReportDetails(
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
        getQuizVideosReportDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'lastseenDesc',
        );
      } else {
        previousSelected = 'asc';
        getQuizVideosReportDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'lastseenAsc',
        );
      }
    }
    if (newValue == tr("center")) {
      seenList = [];
      unSeenList = [];
      previousSelected = 'des';
      setState(ViewState.Idle);
      getQuizVideosReportDetails(
        context,
        courseId: courseId,
        objectId: objectId,
        sortType: 'centername',
      );
    }
  }

  void getRevisionsReports({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
      print('error');
    } else {
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;

        for (var element in x!) {
          if (element.resourceType == 'revision') {
            quizVideos.add(element);
          }
        }
      }
    }
    dataState = true;
    setState(ViewState.Idle);
  }

  void getQuizVideosReportDetails(
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
        for (var i in quizVideosReportModel.notseen) {
          unSeenList.add(i);
        }
        status = '';
        setState(ViewState.Idle);
      }
    } catch (e) {}
  }
}
