import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/auth/model/auth_model.dart';
import 'package:mrs_marwa/app/edit_profile/model/update_profile_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditStudentProfileViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  final editFormKey = GlobalKey<FormState>();
  bool isLoading = true;
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController mobileNumber2Controller = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  var role = '';

  getUserData({required String token}) async {
    var data = await apiServices.getUseDataByToken(token: token);
    if (data == 'fail') {
    } else {
      AuthModel model = AuthModel.fromJson(data);
      emailController.text = model.data!.email!;
      firstNameController.text = model.data!.firstName!;
      lastNameController.text = model.data!.lastName!;
      mobileNumberController.text = model.data!.phone!;
      mobileNumber2Controller.text = model.data!.phone2!;
      schoolController.text = model.data!.school!;
      centerNameController.text = model.data!.center!;
      cityController.text = model.data!.city!;
      isLoading = false;
    }
    setState(ViewState.Idle);
  }

  void editStudentProfile(context, {required String token}) async {
    if (editFormKey.currentState!.validate()) {
      var data = await apiServices.editProfile(
        mobile: mobileNumberController.text,
        city: cityController.text,
        school: schoolController.text,
        center: centerNameController.text,
        lastName: lastNameController.text,
        firstName: firstNameController.text,
        email: emailController.text,
        token:token, mobile2: mobileNumber2Controller.text,
      );
      if (data == 'fail') {
        btnController.stop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: tr('process_fail'),
          desc: tr('unKnown_wrong'),
          btnCancelOnPress: () {},
        ).show();
      } else {
        UpdateProfileModel response = UpdateProfileModel.fromJson(data);
        if (response.status == 'success') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: tr('successful_process'),
            desc: tr('successful'),
            btnOkOnPress: () {
              setState(ViewState.Idle);
            },
          ).show();
          btnController.stop();

          setState(ViewState.Idle);
        } else {
          btnController.stop();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: tr('process_fail'),
            desc: tr('exist'),
            btnCancelOnPress: () {},
          ).show();
        }
      }
    } else {
      btnController.stop();
    }
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
   FormFieldValidator<String>? mobile2Validator() {
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
}
