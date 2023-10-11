import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/home_drawer/model/about_us_model.dart';
import 'package:mrs_marwa/app/change_password/model/change_password_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/navigation_service.dart';

import '../../../routs/routs_names.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../../auth/view_model/auth_view_model.dart';
import '../../edit_profile/model/update_profile_model.dart';

class HomeDrawerViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  var authViewModel = locator<AuthenticationViewModel>();
  var navigation = locator<NavigationService>();
  final editFormKey = GlobalKey<FormState>();

  var role = '';
  var aboutUs = '';
  var email = '';
  var firstName = '';
  var lastName = '';
  var userImage = '';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  getHomeDrawerData() async {
    role = await pref.getString(userType);
    email = await pref.getString(userEmail);
    firstName = await pref.getString(userFirstName);
    lastName = await pref.getString(userLastName);
    userImage = await pref.getString(userImageUrl);
    setState(ViewState.Idle);
  }

  logOut() async {
    await pref.saveBoolean(logInState, false);
    await pref.saveString(userToken, '');
    await pref.saveString(userEmail, '');
    await pref.saveString(userType, '');
    await pref.saveString(userFirstName, '');
    await pref.saveString(userLastName, '');
    await pref.saveString(studentSchoolName, '');
    await pref.saveString(studentCenterName, '');
    await pref.saveString(studentCityName, '');
    await pref.saveString(userMobileNumberOne, '');
    navigation.navigateToAndClearStack(RouteName.splash);
  }

  getAboutUs() async {
    var data = await apiServices.getAboutUs();
    if (data == 'fail') {
      aboutUs = tr('unKnown_wrong');
      setState(ViewState.Idle);
    } else {
      AboutUsModel response = AboutUsModel.fromJson(data);
      aboutUs = response.data;
      setState(ViewState.Idle);
    }
  }


}
