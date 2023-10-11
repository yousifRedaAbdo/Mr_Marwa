import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../base_view_model.dart';
import '../../../locator.dart';
import '../../../routs/routs_names.dart';
import '../../../services/navigation_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';

class SplashViewModel extends BaseViewModel {
  var navigation = locator<NavigationService>();

  var pref = locator<SharedPrefServices>();

  splashNavigation() async {
    var prefs = await SharedPreferences.getInstance();
    var isLogIn = prefs.getBool(logInState) ?? false;
    if (isLogIn) {
      String userRole = await pref.getString(userType);
      if (userRole == 'Parent' || userRole == 'parent') {
        print('from splash user role : $userRole ');
        navigationTimer(RouteName.parentHome);
      } else {
        print('from splash user role : $userRole ');
        navigationTimer(RouteName.home);
      }
    } else {
      navigationTimer(RouteName.logIn);
    }
  }

  void navigationTimer(String routName) async {
    Timer(
      const Duration(seconds: 3),
      () {
        navigation.navigateToAndClearStack(routName);
      },
    );
  }
}
