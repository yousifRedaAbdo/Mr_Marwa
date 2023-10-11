import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_members/generate_pdf/generate_pdf.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../model/course_member_model.dart';

class CourseMembersViewModel extends BaseViewModel {
  GenerateCourseMembersReportPDF generateCourseMembersReportPDF =
      GenerateCourseMembersReportPDF();
  TextEditingController searchController = TextEditingController();
  TextEditingController setPasswordController = TextEditingController();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final changePassKey = GlobalKey<FormState>();

  var apiServices = locator<ApiService>();
  List<Groupmember> enrolledMembersList = [];
  List<Others> unEnrolledMembersList = [];
  List<Groupmember> searchList = [];

  bool getData = false;

  void getMembers({required String courseId}) async {
    enrolledMembersList.clear();
    var data = await apiServices.getCourseMember(courseId: courseId);
    if (data == 'fail') {
    } else {
      CourseMemberModel courseMemberModel = CourseMemberModel.fromJson(data);

      for (var i in courseMemberModel.groupmember) {
        enrolledMembersList.add(i);
      }
      getData = true;
      searchList = enrolledMembersList;
      setState(ViewState.Idle);
    }
  }

  filter(String searchKeyWord) {
    List<Groupmember> result = [];
    if (searchKeyWord.isEmpty) {
      searchList = enrolledMembersList;
      setState(ViewState.Idle);
    } else {
      searchList = enrolledMembersList;
      result = searchList.where((element) {
        if (element.fullName.contains(searchKeyWord) ||
            element.email.contains(searchKeyWord) ||
            element.phone.toString().contains(searchKeyWord)) return true;
        return false;
      }).toList();
      searchList = result;
      print(searchList.length);
      setState(ViewState.Idle);
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

  Future<bool> setNewPassword({
    required String token,
    required String password,
  }) async {
    if (changePassKey.currentState!.validate()) {
      var result = await apiServices.changeStudentPasswordFromTeacher(
          token: token, password: password);
      return result;
    } else {
      btnController.stop();
      return false;
    }
  }
}
