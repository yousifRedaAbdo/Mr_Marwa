import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/comman_widgets/snak_bars.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:system_info2/system_info2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../base_view_model.dart';
import '../../../locator.dart';
import '../../../routs/routs_names.dart';
import '../../../services/api_service.dart';
import '../../../services/current_session service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../model/auth_model.dart';
import '../widgets/auth_snak_bars.dart';

class AuthenticationViewModel extends BaseViewModel {
  ApiService apiServices = locator<ApiService>();
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();
  var currentSessionService = locator<CurrentSessionService>();

  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController studentMobile = TextEditingController();
  TextEditingController parentMobile = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController centerName = TextEditingController();
  TextEditingController city = TextEditingController();

  List<String> year = [
    tr('select_year'),
    tr('first_secondary'),
    tr('second_secondary'),
    tr('third_secondary'),
  ];
  String selected = tr('select_year');
  static int studentYear = 0;

  bool signUpState = false;
  bool termsValue = true;

  final logInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  toLogin() {
    navigation.navigateTo(RouteName.logIn);
  }

  FormFieldValidator<String>? firstNameValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('first_name_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? schoolValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('school_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? centerValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('center_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? cityValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('city_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? lastNameValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('last_name_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? emailValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_email');
      }
      if (!isValidEmail(value.trim())) {
        return tr('valid_email');
      }
      return null;
    };
    return validator;
  }

  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
  }

  FormFieldValidator<String>? passwordValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_password');
      }
      if (value.length < 6) {
        return tr('valid_password');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? confirmPasswordValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_password');
      }
      if (value.length < 6) {
        return tr('valid_password');
      }
      if (value != password.text) {
        return tr('confirm_password_validator');
      }
      return null;
    };
    return validator;
  }

  FormFieldValidator<String>? mobileValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_mobile');
      }
      if (value.length != 11) {
        return tr('valid_mobile');
      }
      return null;
    };
    return validator;
  }

  launchWhatsApp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=+20$phone";
    await canLaunchUrl(Uri.parse(whatsappUrl))
        ? launchUrl(Uri.parse(whatsappUrl))
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  login(context) async {
    if (logInFormKey.currentState!.validate()) {
      var response = await apiServices.loginWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      if (response == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(errorLoginSnackBar);
      } else {
        var userData = AuthModel.fromJson(response);
        if (userData.status == 'success') {
          if (userData.data!.token! == '') {
            btnController.stop();
            ScaffoldMessenger.of(context).showSnackBar(errorLoginSnackBar);
          } else {
            await pref.saveString(userImageUrl, userData.data!.image!);
            await pref.saveString(userToken, userData.data!.token!);
            await pref.saveInteger(userid, userData.data!.id!);
            await pref.saveString(userEmail, userData.data!.email!);
            if (userData.data!.role! == 'assistant') {
              await pref.saveString(userType, 'teacher');
            } else {
              await pref.saveString(userType, userData.data!.role!);
            }
            await pref.saveString(userFirstName, userData.data!.firstName!);
            await pref.saveString(userLastName, userData.data!.lastName!);
            await pref.saveString(studentSchoolName, userData.data!.school!);
            await pref.saveString(studentCenterName, userData.data!.center!);
            await pref.saveString(studentCityName, userData.data!.city!);
            await pref.saveString(userMobileNumberOne, userData.data!.phone!);
            await pref.saveString(userMobileNumberTwo, userData.data!.phone2!);
            await pref.saveBoolean(logInState, true);
            await setDeviceInfo();
            if (userData.data!.role == 'Parent' ||
                userData.data!.role == 'parent') {
              navigation.navigateToAndClearStack(RouteName.parentHome);
            } else {
              navigation.navigateToAndClearStack(RouteName.home);
            }
          }
        } else if (userData.status == 'fail') {
          btnController.error();
          Timer(const Duration(seconds: 2), () {
            btnController.stop();
          });
          ScaffoldMessenger.of(context).showSnackBar(errorLoginSnackBar);
        }
      }
    } else {
      btnController.stop();
    }
  }

  /// not used now
  qrLogin(
    context, {
    required String qrEmail,
    required String qrPassword,
  }) async {
    var response = await apiServices.loginWithEmailAndPassword(
        email: qrEmail, password: qrPassword);
    if (response == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(errorLoginSnackBar);
    } else {
      var userData = AuthModel.fromJson(response);
      if (userData.status == 'success') {
        await pref.saveString(userImageUrl, userData.data!.image!);
        await pref.saveString(userToken, userData.data!.token!);
        await pref.saveInteger(userid, userData.data!.id!);
        await pref.saveString(userEmail, userData.data!.email!);
        await pref.saveString(userType, userData.data!.role!);
        await pref.saveString(userFirstName, userData.data!.firstName!);
        await pref.saveString(userLastName, userData.data!.lastName!);
        await pref.saveString(studentSchoolName, userData.data!.school!);
        await pref.saveString(studentCenterName, userData.data!.center!);
        await pref.saveString(studentCityName, userData.data!.city!);
        await pref.saveString(userMobileNumberOne, userData.data!.phone!);
        await pref.saveBoolean(logInState, true);
        if (userData.data!.role == 'Parent' ||
            userData.data!.role == 'parent') {
          navigation.navigateToAndClearStack(RouteName.parentHome);
        } else {
          navigation.navigateToAndClearStack(RouteName.home);
        }
      } else if (userData.status == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(errorLoginSnackBar);
      }
    }
  }

  registerStudent(
    context, {
    required int role,
  }) async {
    if (!termsValue) {
      btnController.stop();
      ScaffoldMessenger.of(context).showSnackBar(termsAndConditionsSnackBar);
    } else if (studentYear != 0) {
      if (signUpFormKey.currentState!.validate()) {
        var response = await apiServices.register(
          role: role,
          firstName: firstName.text,
          lastName: secondName.text,
          email: email.text,
          password: password.text,
          mobile1: studentMobile.text,
          mobile2: parentMobile.text,
          year: studentYear,
          city: city.text.isEmpty ? "" : city.text,
          school: school.text.isEmpty ? "" : school.text,
          center: centerName.text.isEmpty ? "" : centerName.text,
        );
        if (response == 'fail') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: tr('process_fail'),
            desc: tr('unKnown_wrong'),
            btnCancelOnPress: () {
              navigation.navigateToAndClearStack(RouteName.logIn);
            },
          ).show();
        } else {
          var userData = AuthModel.fromJson(response);
          if (userData.status == 'success') {
            btnController.stop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              title: tr('user_created'),
              btnOkOnPress: () {},
            ).show();
          } else if (userData.status == 'fail') {
            btnController.stop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              title: tr('process_fail'),
              desc: userData.error == "username exists" ? tr('exist') : '',
              btnCancelOnPress: () {},
            ).show();
          }
        }
      } else {
        btnController.stop();
      }
    } else {
      btnController.stop();
      ScaffoldMessenger.of(context).showSnackBar(selectYearSnackBar);
    }
  }

  registerParent(
    context, {
    required int role,
  }) async {
    if (signUpFormKey.currentState!.validate()) {
      var response = await apiServices.register(
        role: role,
        firstName: firstName.text,
        lastName: secondName.text,
        email: email.text,
        password: password.text,
        mobile1: parentMobile.text,
        mobile2: '',
        year: studentYear,
        city: city.text,
        school: school.text,
        center: centerName.text,
      );
      if (response == 'fail') {
        btnController.stop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: tr('process_fail'),
          desc: tr('unKnown_wrong'),
          btnCancelOnPress: () {},
        ).show();
      } else {
        var userData = AuthModel.fromJson(response);
        if (userData.status == 'success') {
          btnController.stop();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: tr('user_created'),
            btnOkOnPress: () {},
          ).show();
        } else if (userData.status == 'fail') {
          btnController.error();
          Timer(const Duration(seconds: 2), () {
            btnController.stop();
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: tr('process_fail'),
            desc: userData.error == "username exists" ? tr('exist') : '',
            btnCancelOnPress: () {},
          ).show();
        }
      }
    } else {
      btnController.stop();
    }
  }

  checkSignUp() async {
    signUpState = await apiServices.checkSignUp();
    setState(ViewState.Idle);
  }

  setDeviceInfo() async {
    if (Platform.isAndroid) {
      try {
        const int megaByte = 1024 * 1024;
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var token = await pref.getString(userToken);
        var release = androidInfo.version.release;
        var sdkInt = androidInfo.version.sdkInt;
        var manufacturer = androidInfo.manufacturer;
        var model = androidInfo.model;
        var id = androidInfo.id;
        var isPhysical = androidInfo.isPhysicalDevice;
        apiServices.setDeviceInfo(
          token: token,
          id: id!,
          model: 'Android $release (SDK $sdkInt), $manufacturer $model',
          totalMemory: '${SysInfo.getTotalPhysicalMemory() ~/ megaByte} MB',
          freeMemory: '${SysInfo.getFreePhysicalMemory() ~/ megaByte} MB',
          isPhysical: isPhysical! ? '1' : '0',
        );
      } catch (e) {
        return e.toString();
      }
    }
  }


}
