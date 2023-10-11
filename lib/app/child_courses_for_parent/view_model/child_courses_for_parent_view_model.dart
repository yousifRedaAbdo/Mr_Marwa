import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';

import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../model/child_courses_for_parent_model.dart';

class ChildCoursesForParentViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var navigation = locator<NavigationService>();
  var apiService = locator<ApiService>();
  InAppWebViewController? webViewController;
  List<Courses> coursesList = [];
  String token = '';
  bool dataState = false;
  double progress = 0;

  getToken() async {
    token = await pref.getString(userToken);
  }

  getChildCourseToParent({required childId}) async {
    setState(ViewState.Idle);
    var token = await pref.getString(userToken);
    var data =
        await apiService.getChildCourseToParent(id: childId, token: token);
    if (data == 'fail') {
    } else {
      ChildCoursesForParentModel childCoursesForParentModel =
          ChildCoursesForParentModel.fromJson(data);
      for (var i in childCoursesForParentModel.courses) {
        coursesList.add(i);
      }
      print('course list length : ${coursesList.length} ');
      dataState = true;
      setState(ViewState.Idle);
    }
  }

  updateState() {
    setState(ViewState.Idle);
  }
}
