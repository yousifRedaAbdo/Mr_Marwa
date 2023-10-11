import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mrs_marwa/base_view_model.dart';

import '../../../enums/screen_state.dart';
import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../../auth/view_model/auth_view_model.dart';
import '../../edit_profile/model/update_profile_model.dart';

class ParentEditProfileViewModel extends BaseViewModel {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  var authViewModel = locator<AuthenticationViewModel>();

  getUserData() async {
    firstNameController.text = await pref.getString(userFirstName);
    lastNameController.text = await pref.getString(userLastName);
    mobileNumberController.text = await pref.getString(userMobileNumberOne);
    setState(ViewState.Idle);
  }

  void editProfile(context) async {
    var data = await apiServices.editParentProfile(
      mobile: mobileNumberController.text,
    );
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
      UpdateProfileModel response = UpdateProfileModel.fromJson(data);
      if (response.status == 'success') {
        await pref.saveString(userMobileNumberOne, mobileNumberController.text);

        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('successful_process'),
          desc: tr('successful'),
          btnOkOnPress: () {
            setState(ViewState.Idle);
          },
        ).show();
        setState(ViewState.Idle);
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('process_fail'),
          desc: tr('unKnown_wrong'),
          btnCancelOnPress: () {},
        ).show();
      }
    }
  }
}
