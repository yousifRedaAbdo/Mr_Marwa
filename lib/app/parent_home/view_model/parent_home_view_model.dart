import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/comman_model/upload_image_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/navigation_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../comman_widgets/snak_bars.dart';
import '../../../locator.dart';
import '../../../routs/routs_names.dart';
import '../../../utils/colors.dart';
import '../../../utils/strings.dart';
import '../model/parent_children_model.dart';

class ParentHomeViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var navigation = locator<NavigationService>();
  var apiService = locator<ApiService>();
  final addChildFormKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  String token = '';
  String email = '';
  String userImage = '';
  String parentFirstName = '';
  String parentLastName = '';
  bool childrenListState = false;

  List<Data> childrenList = [];

  getParentEmail() async {
    email = await pref.getString(userEmail);
    parentFirstName = await pref.getString(userFirstName);
    parentLastName = await pref.getString(userLastName);
    setState(ViewState.Idle);
  }

  getUserImage() async {
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

  getToken() async {
    token = await pref.getString(userToken);
  }

  getParentChildren(context) async {
    var token = await pref.getString(userToken);
    var data = await apiService.getParentChildrenData(token: token);
    if (data == 'fail') {
      var childrenErrorSnackBar = SnackBar(
        content: const Text(
          'Something went wrong while getting children data please try again',
        ),
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Try again',
          textColor: whiteColor,
          onPressed: () {
            getParentChildren(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(childrenErrorSnackBar);
      childrenListState == true;
    } else {
      childrenList = [];
      childrenListState == true;
      ParentChildrenModel model = ParentChildrenModel.fromJson(data);
      for (var i in model.data) {
        childrenList.add(i);
      }
      childrenListState = true;
      setState(ViewState.Idle);
    }
  }

  Future pickImage(context) async {
    var image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    if (image != null) {
      imageFile = File(image.path);
    }

    if (imageFile != null) {
      var data = await apiService.uploadImage(token: token, file: imageFile!);
      if (data == 'fail') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: tr('process_fail'),
          desc: tr('unKnown_wrong'),
          btnCancelOnPress: () {},
        ).show();
      } else {
        UploadImageModel uploadImageModel = UploadImageModel.fromJson(data);
        if (uploadImageModel.status == 'success') {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.SUCCES,
            title: tr('successful_process'),
            desc: tr('update_image'),
            btnOkOnPress: () async {
              await pref.saveString(userImageUrl, uploadImageModel.data);
              setState(ViewState.Idle);
            },
          ).show();
          await pref.saveString(userImageUrl, uploadImageModel.data);
          setState(ViewState.Idle);
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: tr('process_fail'),
            desc: tr('unKnown_wrong'),
            btnCancelOnPress: () {},
          ).show();
        }
      }
    }
  }

  addChildToParent(context) async {
    Timer(const Duration(seconds: 5), () {
      btnController.stop();
    });
    if (addChildFormKey.currentState!.validate()) {
      var token = await pref.getString(userToken);
      var data = await apiService.addChildToParent(
        token: token,
        email: emailController.text,
        mobile: mobileController.text,
      );

      if (data['data'] == 'Successfully') {
        btnController.stop();
        ScaffoldMessenger.of(context).showSnackBar(childAddSuccess);
        getParentChildren(context);
      } else if (data['data'] == 'Not your child') {
        btnController.stop();
        ScaffoldMessenger.of(context).showSnackBar(notYourChildSnackBar);
      } else if (data['data'] == 'Already exist') {
        btnController.stop();
        ScaffoldMessenger.of(context).showSnackBar(childAlreadyExist);
      } else {
        btnController.stop();
        ScaffoldMessenger.of(context).showSnackBar(failAddChildSnackBar);
      }
    } else {
      btnController.stop();
    }
  }

  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
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
}
