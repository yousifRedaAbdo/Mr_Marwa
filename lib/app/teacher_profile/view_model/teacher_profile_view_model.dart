import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrs_marwa/app/home/view_model/student_teacher_view_model.dart';
import 'package:mrs_marwa/app/teacher_profile/model/delete_image_model.dart';
import 'package:mrs_marwa/app/teacher_profile/model/teacher_data_model.dart';
import 'package:mrs_marwa/app/teacher_profile/model/upload_image_model.dart';
import 'package:mrs_marwa/base_view_model.dart';
import 'package:mrs_marwa/comman_model/upload_image_model.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../locator.dart';
import '../../../services/navigation_service.dart';
import '../../../services/shared_pref_services.dart';

class TeacherProfileViewModel extends BaseViewModel {
  StudentTeacherHomeViewModel studentTeacherHomeViewModel =
      StudentTeacherHomeViewModel();
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
  double rate = 0;
  bool dataState = false;

  List<Photos> photosList = [];
  List<Feedbacks> feedbacksList = [];
  List<Courses> coursesList = [];
  List<Videos> videosList = [];

  getToken() async {
    token = await pref.getString(userToken);
  }

  Future<void> launchTeacherUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch ';
    }
  }

  launchWhatsApp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=+20$phone";
    await canLaunchUrl(Uri.parse(whatsappUrl))
        ? launchUrl(Uri.parse(whatsappUrl))
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
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
            dialogType: DialogType.INFO,
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

  getImageUrl() async {
    userImage = await pref.getString(userImageUrl);
    setState(ViewState.Idle);
  }

  getTeacherData(context, token) async {
    var data = await apiServices.getTeacherData(token: token);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else {
      TeacherDataModel teacherDataModel = TeacherDataModel.fromJson(data);
      rate = double.parse(teacherDataModel.teacher.rating);
      for (var i in teacherDataModel.teacher.courses) {
        coursesList.add(i);
      }
      for (var i in teacherDataModel.teacher.photos) {
        photosList.add(i);
      }
      for (var i in teacherDataModel.teacher.feedbacks) {
        feedbacksList.add(i);
      }
      for (var i in teacherDataModel.teacher.feedbacks) {
        feedbacksList.add(i);
      }
      for (var i in teacherDataModel.teacher.videos) {
        videosList.add(i);
      }
      dataState = true;
      setState(ViewState.Idle);
    }
  }

  getTeacherImages(context, token) async {
    var data = await apiServices.getTeacherData(token: token);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else {
      TeacherDataModel teacherDataModel = TeacherDataModel.fromJson(data);
      photosList = [];
      for (var i in teacherDataModel.teacher.photos) {
        photosList.add(i);
      }
      setState(ViewState.Idle);
    }
  }

  deleteImage(
    context, {
    required String imageId,
  }) async {
    var data = await apiServices.deleteTeacherImage(
      imageId: imageId,
    );
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {
          setState(ViewState.Idle);
        },
      ).show();
      setState(ViewState.Idle);
    } else {
      DeleteImageModel deleteImageModel = DeleteImageModel.fromJson(data);
      if (deleteImageModel.status == 'success') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('successful_process'),
          desc: tr(tr('image_deleted')),
          btnOkOnPress: () async {
            await getToken();
            getTeacherImages(context, token);
            setState(ViewState.Idle);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('process_fail'),
          desc: tr(tr('unKnown_wrong')),
          btnCancelOnPress: () {},
        ).show();
      }
    }
  }

  Future uploadTeacherImages(context) async {
    var image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    if (image != null) {
      imageFile = File(image.path);
    }
    var data = await apiServices.uploadTeacherImages(
      file: imageFile!,
      token: token,
    );
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: tr('process_fail'),
        desc: tr(tr('unKnown_wrong')),
        btnCancelOnPress: () {
          setState(ViewState.Idle);
        },
      ).show();
    } else {
      var response = UploadImagesModel.fromJson(data);
      if (response.message == 'image added') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('successful_process'),
          desc: tr('image_add'),
          btnOkOnPress: () async {
            await getToken();
            getTeacherImages(context, token);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('process_fail'),
          desc: tr(tr('unKnown_wrong')),
          btnCancelOnPress: () {
            setState(ViewState.Idle);
          },
        ).show();
      }
    }
  }
}
