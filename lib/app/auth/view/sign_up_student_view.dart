import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/auth/widgets/select_year.dart';
import 'package:mrs_marwa/comman_widgets/mobile_text_field.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/inputField.dart';
import '../../../utils/texts.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/terms_and_conditions.dart';
class SignUpStudentView extends StatelessWidget {
  const SignUpStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return BaseView<AuthenticationViewModel>(
      onModelReady: (viewModel) {
        print(AuthenticationViewModel.studentYear);
      },
      builder: (context, viewModel, child) {
        AuthenticationViewModel.studentYear = 0;
        return Scaffold(
          body: Form(
            key: viewModel.signUpFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.emailAddress,
                      controller: viewModel.email,
                      validator: viewModel.emailValidator(),
                      icon: Icons.email,
                      hint: tr('email'),
                    ),
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.text,
                      controller: viewModel.firstName,
                      validator: viewModel.firstNameValidator(),
                      icon: Icons.person,
                      hint: tr('first_name'),
                    ),
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.text,
                      controller: viewModel.secondName,
                      validator: viewModel.lastNameValidator(),
                      icon: Icons.person,
                      hint: tr('last_name'),
                    ),
                    heightSpace(20),
                    MobileInputField(
                      inputType: TextInputType.phone,
                      controller: viewModel.studentMobile,
                      validator: viewModel.mobileValidator(),
                      icon: Icons.phone,
                      hint: tr('student_mobile'),
                    ),
                    heightSpace(20),
                    MobileInputField(
                      inputType: TextInputType.phone,
                      controller: viewModel.parentMobile,
                      validator: viewModel.mobileValidator(),
                      icon: Icons.phone,
                      hint: tr('parent_mobile_num'),
                    ),
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.text,
                      controller: viewModel.school,
                      validator: (value) {},
                      icon: Icons.school,
                      hint: tr('school'),
                    ),
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.text,
                      controller: viewModel.centerName,
                      validator: (value) {},
                      icon: Icons.business_center,
                      hint: tr('center_name'),
                    ),
                    heightSpace(20),
                    InputField(
                      inputType: TextInputType.text,
                      controller: viewModel.city,
                      validator: (value) {},
                      icon: Icons.location_on_rounded,
                      hint: tr('city'),
                    ),
                    heightSpace(20),
                    InputField(
                      isPassword: true,
                      inputType: TextInputType.text,
                      controller: viewModel.password,
                      validator: viewModel.passwordValidator(),
                      icon: Icons.lock,
                      hint: tr('password'),
                    ),
                    heightSpace(20),
                    InputField(
                      isPassword: true,
                      inputType: TextInputType.text,
                      controller: viewModel.confirmPassword,
                      validator: viewModel.confirmPasswordValidator(),
                      icon: Icons.lock,
                      hint: tr('confirm_password'),
                    ),
                    heightSpace(20),
                    SelectStudyYear(),
                    heightSpace(20),
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
                          viewModel.registerStudent(
                            context,
                            role: 5,
                          );
                        },
                        child: roundedButtonText(
                          tr('register'),
                        ),
                      ),
                    ),
                    heightSpace(50),
                    termsAndConditions(context),
                    heightSpace(10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      onFinish: (viewModel) {
        // AuthenticationViewModel.studentYear = 0;
        viewModel.firstName.dispose();
        viewModel.secondName.dispose();
        viewModel.email.dispose();
        viewModel.password.dispose();
        viewModel.confirmPassword.dispose();
        viewModel.studentMobile.dispose();
        viewModel.parentMobile.dispose();
        viewModel.school.dispose();
        viewModel.centerName.dispose();
        viewModel.city.dispose();
      },
    );
  }
}
