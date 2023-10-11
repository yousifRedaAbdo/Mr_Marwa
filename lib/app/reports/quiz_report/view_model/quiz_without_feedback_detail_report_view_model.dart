import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

import '../../../../comman_widgets/snak_bars.dart';
import '../../quizzes_report/model/attmpts_model.dart';
import '../generate_home_work_report_pdf/generate_home_work_pdf.dart';

class QuizReportViewModel extends BaseViewModel {
  GenerateHomeWorkReportPDF generateHomeWorkReportPDF =
      GenerateHomeWorkReportPDF();
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  String token = '';
  bool dataState = false;

  String previousSelected = 'asc'; //ascending

  List<Submitted> submittedList = [];
  List inProgressList = [];
  List<Notsubmitted> notSubmittedList = [];
  List<String> orderByList = [
    tr("name"),
    tr("grade"),
    tr("date"),
    tr("center"),
  ];
  String? selectionOrder;

  getToken() async {
    token = await pref.getString(userToken);
  }

  void getHomeWorkReport({
    required String id,
    required String sortType,
    required BuildContext context,
  }) async {
    setState(ViewState.Busy);
    var data = await apiServices.getQuizReport(
      context: context,
      id: id,
      sortType: sortType,
    );
    if (data == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(unKnownErrorSnackBar);
    } else {
      AttempsModel model = AttempsModel.fromJson(data);
      for (var i in model.submitted) {
        submittedList.add(i);
      }
      for (var i in model.notsubmitted) {
        notSubmittedList.add(i);
      }
      for (var i in model.inprogress) {
        inProgressList.add(i);
      }
      setState(ViewState.Idle);
    }
  }

  sortData(context, String newValue, id) {
    if (newValue == tr("name")) {
      submittedList = [];
      inProgressList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getQuizReport(context: context, id: id, sortType: 'ztoa');
      } else {
        previousSelected = 'asc';
        getQuizReport(context: context, id: id, sortType: 'atoz');
      }
    }
    if (newValue == tr("date")) {
      submittedList = [];
      inProgressList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getQuizReport(
            context: context, id: id, sortType: 'timefinishAsc');
      } else {
        previousSelected = 'asc';
        getQuizReport(
            context: context, id: id, sortType: 'timefinishDesc');
      }
    }
    if (newValue == tr("grade")) {
      submittedList = [];
      inProgressList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getQuizReport(context: context, id: id, sortType: 'minGrade');
      } else {
        previousSelected = 'asc';
        getQuizReport(context: context, id: id, sortType: 'maxGrade');
      }
    }
    if (newValue == tr("center")) {
      submittedList = [];
      inProgressList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      getQuizReport(context: context, id: id, sortType: 'centername');
      previousSelected = 'des';
    }
  }

  getQuizReport(
      {required BuildContext context,
      required String id,
      required String sortType}) async {
    setState(ViewState.Busy);
    var data = await apiServices.getQuizReport(
        context: context, id: id, sortType: sortType);
    if (data == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(unKnownErrorSnackBar);
    } else {
      AttempsModel model = AttempsModel.fromJson(data);
      for (var i in model.submitted) {
        submittedList.add(i);
      }
      for (var i in model.notsubmitted) {
        notSubmittedList.add(i);
      }
      for (var i in model.inprogress) {
        inProgressList.add(i);
      }
      setState(ViewState.Idle);
    }
  }


}
