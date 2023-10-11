

import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/navigation_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

class CourseContentDrawerViewModel extends BaseViewModel {
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();

  String userRole = '';
  String token = '';

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  getToken() async {
    token = await pref.getString(userToken);
    setState(ViewState.Idle);
  }
}
