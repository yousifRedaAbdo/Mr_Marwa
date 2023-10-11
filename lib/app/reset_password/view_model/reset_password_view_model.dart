import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_view_model.dart';

import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../model/reset_password_model.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  ApiService apiServices = locator<ApiService>();

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

  resetPassword(
    context,
  ) async {
    if (resetPasswordFormKey.currentState!.validate()) {
      var data = await apiServices.resetPassword(email: email.text);
      if (data == 'fail') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: tr('process_fail'),
          btnCancelOnPress: () {},
        ).show();
      } else {
        var model = ResetPasswordModel.fromJson(data);
        if (model.status == 'fail') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: tr('process_fail'),
            desc: tr('not_exist'),
            btnCancelOnPress: () {},
          ).show();
        } else if (model.status == 'success') {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.SCALE,
                  title: tr('successful_process'),
                  desc: tr('check_email'),
                  btnOkOnPress: () {})
              .show();
        }
      }
    }
  }
}
