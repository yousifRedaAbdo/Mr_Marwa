import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:mrs_marwa/comman_widgets/inputField.dart';
import 'package:mrs_marwa/comman_widgets/mobile_text_field.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return BaseView<EditProfileViewModel>(
      onModelReady: (viewModel) {
        viewModel.getUserData();
      },
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.editFormKey,
              child: Scaffold(
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradColor1, gradColor2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  title: appBarTitle(tr('edit_profile')),
                ),
                body: viewModel.role == ''
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ListView(
                          children: [
                            heightSpace(30),
                            InputField(
                              hint: viewModel.emailController.text == ''
                                  ? tr('email')
                                  : viewModel.emailController.text,
                              inputType: TextInputType.text,
                              controller: viewModel.emailController,
                              icon: Icons.email,
                              validator: viewModel.emailValidator(),
                            ),
                            heightSpace(30),
                            InputField(
                              hint: viewModel.firstNameController.text == ''
                                  ? tr('first_name')
                                  : viewModel.firstNameController.text,
                              inputType: TextInputType.text,
                              controller: viewModel.firstNameController,
                              icon: Icons.person,
                              validator: viewModel.firstNameValidator(),
                            ),
                            heightSpace(30),
                            InputField(
                              hint: viewModel.lastNameController.text == ''
                                  ? tr('last_name')
                                  : viewModel.lastNameController.text,
                              inputType: TextInputType.text,
                              controller: viewModel.lastNameController,
                              icon: Icons.person,
                              validator: viewModel.lastNameValidator(),
                            ),
                            heightSpace(30),
                            MobileInputField(
                              hint: viewModel.mobileNumberController.text == ''
                                  ? tr('student_mobile')
                                  : viewModel.mobileNumberController.text,
                              inputType: TextInputType.number,
                              controller: viewModel.mobileNumberController,
                              icon: Icons.phone,
                              validator: viewModel.mobileValidator(),
                            ),
                            heightSpace(30),
                            viewModel.role == 'teacher'
                                ? Container()
                                : MobileInputField(
                                    hint: viewModel
                                                .mobileNumber2Controller.text ==
                                            ''
                                        ? 'parent mobile'
                                        : viewModel
                                            .mobileNumber2Controller.text,
                                    inputType: TextInputType.number,
                                    controller:
                                        viewModel.mobileNumber2Controller,
                                    icon: Icons.phone,
                                    validator: viewModel.mobile2Validator(),
                                  ),
                            heightSpace(30),
                            viewModel.role == 'teacher'
                                ? Container()
                                : InputField(
                                    inputType: TextInputType.text,
                                    controller: viewModel.schoolController,
                                    validator: (value) {},
                                    icon: Icons.school,
                                    hint: viewModel.schoolController.text == ''
                                        ? tr('school')
                                        : viewModel.schoolController.text,
                                  ),
                            heightSpace(30),
                            viewModel.role == 'teacher'
                                ? Container()
                                : InputField(
                                    inputType: TextInputType.text,
                                    controller: viewModel.centerNameController,
                                    validator: (value) {},
                                    icon: Icons.business_center,
                                    hint: viewModel.centerNameController.text ==
                                            ''
                                        ? tr('center_name')
                                        : viewModel.centerNameController.text,
                                  ),
                            heightSpace(30),
                            viewModel.role == 'teacher'
                                ? Container()
                                : InputField(
                                    inputType: TextInputType.text,
                                    controller: viewModel.cityController,
                                    validator: (value) {},
                                    icon: Icons.location_on_rounded,
                                    hint: viewModel.cityController.text == ''
                                        ? tr('city')
                                        : viewModel.cityController.text,
                                  ),
                            heightSpace(60),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(1, 1),
                                    colors: <Color>[
                                      gradColor1,
                                      gradColor2,
                                    ],
                                    tileMode: TileMode.mirror,
                                  ),
                                ),
                              child: RoundedLoadingButton(
                                width: deviceSize.width,
                                color: mainColor.withOpacity(0.1),
                                successColor: successfulColor,
                                errorColor: errorColor,
                                height: 50,
                                controller: viewModel.btnController,
                                onPressed: () {
                                  viewModel.editProfile(context);
                                },
                                child: roundedButtonText(
                                  tr('edit'),
                                ),
                              ),
                            ),
                            heightSpace(40)
                          ],
                        ),
                      ),
              ),
        );
      },
    );
  }
}
