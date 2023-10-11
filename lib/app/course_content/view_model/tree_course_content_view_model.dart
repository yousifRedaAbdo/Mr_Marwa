import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_details/widgets/restriction_dialog.dart';

import '../../../base_view_model.dart';
import '../../../enums/screen_state.dart';
import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../../course_details/view/pdf_activity_view.dart';
import '../../web_view/view/web_view.dart';
import '../model/activity_availability_model.dart';
import '../model/final_course_content_mobile_model.dart';
import 'course_content_view_model.dart';

class TreeCourseContentViewModel extends BaseViewModel {
  CourseContentViewModel contentViewModel = CourseContentViewModel();
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  String token = '';
  bool isForumListEmpty = false;
  bool isCourseLoaded = false;
  String forumUrl = '';

  List<Contents> contentsList = [];

  getToken() async {
    token = await pref.getString(userToken);
  }

  getCourseContentLists({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      FinalCourseContentMobileModel courseDetailsModel =
          FinalCourseContentMobileModel.fromJson(data);
      for (var i in courseDetailsModel.data!.contents!) {
        contentsList.add(i);
      }

      if (contentsList[0].modules!.isNotEmpty) {
        forumUrl = contentsList[0].modules![0].url!;
      }
      isForumListEmpty = contentsList[0].modules!.isEmpty;
      isCourseLoaded = true;
      setState(ViewState.Idle);
    }
  }

  void checkContent({
    required BuildContext context,
    required Modules element,
    required TreeCourseContentViewModel viewModel,
    required String courseId,
  }) async {
    if (element.modname == 'testnew') {
      var pdfLink = '${element.content![0].fileurl!.split(
        '?forcedownload=1',
      )[0]}?token=${viewModel.token}';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPdf(
            pdfLink,
            element.name!,
          ),
        ),
      );
    } else {
      var data = await apiServices.checkActivityAvailability(
        token: viewModel.token,
        courseId: courseId,
        activityId: element.id!,
      );
      if (data == 'fail') {
        //TODO show dialog
      } else {
        ///check availability
        var model = ActivityAvailabilityModel.fromJson(data);
        if (model.flag) {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppWebView(
                '${element.url}&token=${viewModel.token}',
                element.name,
              ),
            ),
          );
          if (result) {
            viewModel.contentsList = [];
            viewModel.isCourseLoaded = false;
            viewModel.updateState();
            await viewModel.getToken();
            viewModel.getCourseContentLists(
              courseId: courseId,
              token: viewModel.token,
            );
          }
        } else {
          restrictionDialog(
            context,
            model.data,
          );
        }
      }
    }
  }

  updateState() {
    setState(ViewState.Idle);
  }
}
