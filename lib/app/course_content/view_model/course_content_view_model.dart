import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../../contact_us/model/check_code_model.dart';

class CourseContentViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  final codeFormKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  String userRole = '';
  List<String> moduleIds = [];
  bool isCodeValid = true;

  updateState() {
    setState(ViewState.Idle);
  }

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  String token = '';

  getToken() async {
    token = await pref.getString(userToken);
  }

  checkCode(
    context, {
    required String token,
    required String courseId,
    required String activityId,
    required String code,
  }) async {
    if (codeFormKey.currentState!.validate()) {
      var data = await apiServices.checkCode(
        token: token,
        courseId: courseId,
        activityId: activityId,
        code: code,
      );
      if (data == 'fail') {
        return 'fail';
      } else {
        CheckCodeModel checkCodeModel = CheckCodeModel.fromJson(data);
        if (checkCodeModel.status == 'success') {
          return 'success';
        } else if (checkCodeModel.status == 'fail') {
          return 'not valid code';
        }
      }
    }
  }

  FormFieldValidator<String>? codeValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_code');
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
}
