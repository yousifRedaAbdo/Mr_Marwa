import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/comman_widgets/mobile_text_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/inputField.dart';
import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/texts.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/terms_and_conditions.dart';

class SignUpParentView extends StatelessWidget {
  const SignUpParentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return BaseView<AuthenticationViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
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
                    controller: viewModel.parentMobile,
                    validator: viewModel.mobileValidator(),
                    icon: Icons.phone,
                    hint: tr('parent_mobile_num'),
                  ),
                  heightSpace(20),
                  InputField(
                    inputType: TextInputType.text,
                    controller: viewModel.password,
                    validator: viewModel.passwordValidator(),
                    icon: Icons.lock,
                    hint: tr('password'),
                    isPassword: true,
                  ),
                  heightSpace(20),
                  InputField(
                    inputType: TextInputType.text,
                    controller: viewModel.confirmPassword,
                    validator: viewModel.confirmPasswordValidator(),
                    icon: Icons.lock,
                    hint: tr('confirm_password'),
                    isPassword: true,
                  ),
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
                        viewModel.registerParent(context, role: 9);
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
        ));
      },
      onFinish: (viewModel) {
        AuthenticationViewModel.studentYear = 0;
        viewModel.email.dispose();
        viewModel.firstName.dispose();
        viewModel.secondName.dispose();
        viewModel.parentMobile.dispose();
        viewModel.password.dispose();
        viewModel.confirmPassword.dispose();
      },
    );
  }
}
