import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:mrs_marwa/app/change_password/model/change_password_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/comman_widgets/snak_bars.dart';
import 'package:mrs_marwa/enums/screen_state.dart';

import '../../../locator.dart';
import '../../../services/api_service.dart';

class ChangePasswordViewModel extends BaseViewModel {
  var apiServices = locator<ApiService>();
  final changePasswordKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  changePassword(
    context,
  ) async {
    btnController.stop();
    if (changePasswordKey.currentState!.validate()) {
      var data = await apiServices.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      );
      if (data == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(unKnownErrorSnackBar);
        btnController.error();
        Timer(const Duration(seconds: 2), () {
          btnController.stop();
        });
      } else {
        ChangePasswordModel model = ChangePasswordModel.fromJson(data);
        if (model.status == 'fail') {
          ScaffoldMessenger.of(context).showSnackBar(wrongOldPasswordSnackBar);

          btnController.stop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(changePasswordSuccessfulSnackBar);
          btnController.stop();
        }
      }
    }
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
      if (value != newPasswordController.text) {
        return tr('confirm_password_validator');
      }
      return null;
    };
    return validator;
  }
}
