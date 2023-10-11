import 'package:easy_localization/easy_localization.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

import '../../../../locator.dart';
import '../generate_pdf_for_pdf_report/generate_pdf.dart';
import '../model/pdf_report_in_detail_model.dart';
import '../model/pdf_report_model.dart';

class PdfReportViewModel extends BaseViewModel {
  ApiService apiService = locator<ApiService>();
  SharedPrefServices sharedPrefServices = locator<SharedPrefServices>();
  GeneratePdfReportPDF generatePdfReportPDF = GeneratePdfReportPDF();
  String token = '';
  String previousSelected = 'asc'; //ascending
  bool dataState = false;

  String? selectionOrder;
  List<String> orderByList = [
    tr("name"),
    tr("views"),
  ];
  List<Data> pdfList = [];
  List<SeenData> pdfSeenList = [];
  List<NotSeenData> pdfNotSeenList = [];

  getAllPdf({required String courseId}) async {
    var data = await apiService.getPdfReports(courseId: courseId);
    if (data == 'fail') {
    } else {
      PdfReportModel pdfReportModel = PdfReportModel.fromJson(data);
      for (var i in pdfReportModel.data) {
        pdfList.add(i);
      }
      dataState = true;
      setState(ViewState.Idle);
    }
  }

  getPdfInDetail({
    required String objectId,
    required String sortType,
  }) async {
    String token = await sharedPrefServices.getString(userToken);
    var data = await apiService.getPdfInDetailReports(
      token: token,
      objectId: objectId,
      sortType: sortType,
    );
    if (data == 'fail') {
    } else {
      PdfReportInDetailModel pdfReportInDetailModel =
          PdfReportInDetailModel.fromJson(data);
      for (var i in pdfReportInDetailModel.notSeenData) {
        pdfNotSeenList.add(i);
      }
      for (var i in pdfReportInDetailModel.seenData) {
        pdfSeenList.add(i);
      }
      print('pdf details');
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
      pdfSeenList = [];
      pdfNotSeenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getPdfInDetail(
          objectId: objectId,
          sortType: 'ztoa',
        );
      } else {
        previousSelected = 'asc';
        getPdfInDetail(
          objectId: objectId,
          sortType: 'atoz',
        );
      }
    }
    if (newValue == tr("views")) {
      pdfSeenList = [];
      pdfNotSeenList = [];
      setState(ViewState.Idle);
      if (previousSelected == 'asc') {
        previousSelected = 'des';
        getPdfInDetail(
          objectId: objectId,
          sortType: 'maxViews',
        );
      } else {
        previousSelected = 'asc';
        getPdfInDetail(
          objectId: objectId,
          sortType: 'minViews',
        );
      }
    }
  }
}
