import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrs_marwa/app/profile_page/model/user_feedback_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/comman_model/upload_image_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/services/navigation_service.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';

class ProfilePageViewModel extends BaseViewModel {
  var apiServices = locator<ApiService>();
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  String token = '';
  String email = '';
  String firstName = '';
  String lastName = '';
  String centerName = '';
  String userImage = '';
  List<Feedbacks> studentFeedbackList = [];

  getToken() async {
    token = await pref.getString(userToken);
  }

  getUserData() async {
    email = await pref.getString(userEmail);
    firstName = await pref.getString(userFirstName);
    lastName = await pref.getString(userLastName);
    centerName = await pref.getString(studentCenterName);
    userImage = await pref.getString(userImageUrl);
    setState(ViewState.Idle);
  }

  getUserImage() async {
    userImage = await pref.getString(userImageUrl);
    setState(ViewState.Idle);
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
      var data = await apiServices.uploadImage(token: token, file: imageFile!);
      if (data == 'fail') {
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

  getStudentFeedbacks(
    context,
  ) async {
    var data = await apiServices.getStudentFeedbacks(token: token);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else if (data['feedbacks'] == 'no feedbacks') {
      setState(ViewState.Idle);
    } else {
      var feedBacks = UserFeedBackModel.fromJson(data);
      for (var i in feedBacks.feedbacks!) {
        studentFeedbackList.add(i);
      }
      setState(ViewState.Idle);
    }
  }
}
