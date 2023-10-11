import 'package:easy_localization/easy_localization.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';

import '../../../../locator.dart';
import '../../../../utils/strings.dart';
import '../generate_pdf/generate_assignment_pdf.dart';
import '../model/assignment_model.dart';
import '../model/assignment_report_details_model.dart';

class AssignmentReportViewModel extends BaseViewModel {
  ApiService apiService = locator<ApiService>();
  SharedPrefServices sharedPrefServices = locator<SharedPrefServices>();
  GenerateAssignmentReportPDF generateAssignmentReportPDF =
      GenerateAssignmentReportPDF();
  String token = '';
  bool dataState = false;
  bool AssignmentInDetailDataState = false;
  List<Assignments> assignmentList = [];
  List<Submitted> submittedList = [];
  List<NotSubmitted> notSubmittedList = [];
  String previousSelected = 'asc'; //ascending
  String? selectionOrder;
  List<String> orderByList = [
    tr("name"),
    tr("grade"),
  ];

  getAssignment({
    required String courseId,
  }) async {
    token = await sharedPrefServices.getString(userToken);
    var data = await apiService.getAssignment(token: token, courseId: courseId);
    if (data == 'fail') {
    } else {
      AssignmentModel model = AssignmentModel.fromJson(data);
      for (var i in model.courses[0].assignments) {
        assignmentList.add(i);
      }
      dataState = true;
      setState(ViewState.Idle);
    }
  }

  getAssignmentInDetailReports({
    required String sortType,
    required String objectId,
  }) async {
    token = await sharedPrefServices.getString(userToken);
    var data = await apiService.getAssignmentInDetailReports(
        token: token, sortType: sortType, objectId: objectId);
    if (data == 'fail') {
    } else {
      AssignmentReportDetailsModel assignmentReportDetailsModel =
          AssignmentReportDetailsModel.fromJson(data);
      for (var i in assignmentReportDetailsModel.notSubmitted) {
        notSubmittedList.add(i);
      }
      for (var i in assignmentReportDetailsModel.submitted) {
        submittedList.add(i);
      }
      AssignmentInDetailDataState = true;
      setState(ViewState.Idle);
    }
  }

  sortData(
    context, {
    required String newValue,
    required String objectId,
  }) {
    setState(ViewState.Busy);
    if (newValue == tr("name")) {
      submittedList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getAssignmentInDetailReports(
          objectId: objectId,
          sortType: 'ztoa',
        );
      } else {
        previousSelected = 'asc';
        getAssignmentInDetailReports(
          objectId: objectId,
          sortType: 'atoz',
        );
      }
    }
    if (newValue == tr("grade")) {
      submittedList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getAssignmentInDetailReports(
          objectId: objectId,
          sortType: 'maxGrade',
        );
      } else {
        previousSelected = 'asc';
        getAssignmentInDetailReports(
          objectId: objectId,
          sortType: 'minGrade',
        );
      }
    }
  }
}
