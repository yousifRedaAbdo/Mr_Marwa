
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../base_view_model.dart';
import '../../../../comman_widgets/snak_bars.dart';
import '../../../../enums/screen_state.dart';
import '../../../../locator.dart';
import '../../../../services/api_service.dart';
import '../../../../services/navigation_service.dart';
import '../generate_quiz_pdf/generate_certificate_pdf.dart';
import '../generate_quiz_pdf/generate_quiz_pdf.dart';
import '../model/attmpts_model.dart';
import '../model/quiz_report_model.dart';

class QuizesReportsViewModel extends BaseViewModel {
  GenerateQuizReportPDF generateQuizReportPDF = GenerateQuizReportPDF();
  GenerateCertificate generateCertificate = GenerateCertificate();
  var apiServices = locator<ApiService>();
  var navigation = locator<NavigationService>();
  String previousSelected = 'asc'; //ascending
  List<Data> quizzesReportList = [];
  List<Submitted> submittedList = [];
  List inProgressList = [];
  List<Notsubmitted> notSubmittedList = [];
  List<String> orderByList = [
    tr("name"),
    tr("date"),
    tr("grade"),
    tr("center"),
  ];
  String? selectionOrder;

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
        getQuizReport(
            context: context, id: id, sortType: 'minGrade');
      } else {
        previousSelected = 'asc';
        getQuizReport(
            context: context, id: id, sortType: 'maxGrade');
      }
    }
    if (newValue == tr("center")) {
      submittedList = [];
      inProgressList = [];
      notSubmittedList = [];
      setState(ViewState.Idle);
      getQuizReport(
          context: context, id: id, sortType: 'centername');
      previousSelected = 'des';
    }
  }

  getAllQuizesReport({required String id}) async {
    var data = await apiServices.getAllQuizesReport(id: id);
    if (data == 'fail') {
    } else {
      QuizzesReportModel model = QuizzesReportModel.fromJson(data);
      for (var i in model.data) {
        quizzesReportList.add(i);
      }
      setState(ViewState.Idle);
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

  downLoadPdf() {
    //Create a new PDF document.
    final PdfDocument document = PdfDocument();
//Create a PDF page template and add header content.
    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the header.
    headerTemplate.graphics.drawString(
        'This is page header', PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 15, 200, 20));
//Add the header element to the document.
    document.template.top = headerTemplate;
//Create a PDF page template and add footer content.
    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the footer.
    footerTemplate.graphics.drawString(
        'This is page footer', PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 15, 200, 20));
//Set footer in the document.
    document.template.bottom = footerTemplate;
//Now create pages.
    document.pages.add();
    document.pages.add();
// Save the document.
//     File('HeaderandFooter.pdf').writeAsBytes(document.save());
// Dispose the document.
    document.dispose();
  }
}
