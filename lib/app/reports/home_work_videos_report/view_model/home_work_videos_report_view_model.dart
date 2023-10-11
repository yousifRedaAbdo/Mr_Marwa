import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mrs_marwa/app/course_details/model/course_details_model.dart';
import 'package:mrs_marwa/app/reports/home_work_videos_report/generate_home_work_videos_pdf/generate_home_work_video_pdf.dart';
import 'package:mrs_marwa/app/reports/home_work_videos_report/model/home_work_videos_report_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

class HomeWorkVideoReportDetailsViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();

  GenerateHomeWorkVideosReportPDF generateHomeWorkVideosReportPDF =
      GenerateHomeWorkVideosReportPDF();
  var apiServices = locator<ApiService>();
  String status = 'loading';
  String token = '';
  String previousSelected = 'asc'; //ascending
  List<Modules> homeWorkVideoList = [];
  bool dataState = false;

  List<Seen> seenList = [];
  List<Notseen> unSeenList = [];
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

  void getHomeWorkVideosReport({
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
          if (element.resourceType == 'homework') {
            homeWorkVideoList.add(element);
          }
        }
      }
    }
    dataState = true;
    setState(ViewState.Idle);
  }


  void getSeenAndUnseenReportsDetails(
    context, {
    required String courseId,
    required String objectId,
    required String sortType,
  }) async {
    setState(ViewState.Busy);
    try {
      var data = await apiServices.getSeenAndUnseenReportsDetail(
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
        HomeWorkVideosReportModel homeWorkVideosReportModel =
            HomeWorkVideosReportModel.fromJson(data);
        for (var i in homeWorkVideosReportModel.seen) {
          seenList.add(i);
        }
        for (var i in homeWorkVideosReportModel.notseen) {
          unSeenList.add(i);
        }
        status = '';
        setState(ViewState.Idle);
      }
    } catch (e) {}
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
        getSeenAndUnseenReportsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'atoz',
        );
      } else {
        previousSelected = 'asc';
        getSeenAndUnseenReportsDetails(
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
        getSeenAndUnseenReportsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'viewsDesc',
        );
      } else {
        previousSelected = 'asc';
        getSeenAndUnseenReportsDetails(
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
        getSeenAndUnseenReportsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'lastseenDesc',
        );
      } else {
        previousSelected = 'asc';
        getSeenAndUnseenReportsDetails(
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
      getSeenAndUnseenReportsDetails(
        context,
        courseId: courseId,
        objectId: objectId,
        sortType: 'centername',
      );
    }
  }
}
