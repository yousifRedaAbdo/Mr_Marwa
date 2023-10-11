import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/auth/view_model/auth_view_model.dart';
import 'package:mrs_marwa/app/auth/widgets/contact_with_us.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/comman_widgets/main_button.dart';
import 'package:mrs_marwa/routs/routs_names.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../comman_widgets/inputField.dart';
import '../../../utils/strings.dart';
import '../../../utils/texts.dart';

class QrCodeLoginView extends StatelessWidget {
  String? email, password;

  QrCodeLoginView({
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return BaseView<AuthenticationViewModel>(
      onModelReady: (viewModel) {
        viewModel.qrLogin(context, qrEmail: email!, qrPassword: password!);
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Form(
              key: viewModel.logInFormKey,
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          heightSpace(50),
                          CircleAvatar(
                            backgroundColor: mainColor,
                            radius: 70,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/teacher_image.png',
                                width: 135,
                                height: 135,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          heightSpace(20),
                          mainColorTitle(tr('mr_name')),
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
                            controller: viewModel.password,
                            icon: Icons.lock,
                            validator: viewModel.passwordValidator(),
                            isPassword: true,
                            hint: tr('password'),
                          ),
                          heightSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              smallBoldTitle(
                                tr('forget_password'),
                              )
                            ],
                          ).onTap(() {
                            viewModel.navigation
                                .navigateTo(RouteName.resetPassword);
                          }),
                          heightSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 30,
                                color: Colors.red.shade900,
                              )
                            ],
                          ).onTap(() {
                            viewModel.navigation.navigateTo(RouteName.qrCode);
                          }),
                          heightSpace(25),
                          RoundedLoadingButton(
                            width: deviceSize.width,
                            color: mainColor,
                            successColor: successfulColor,
                            errorColor: errorColor,
                            height: 50,
                            controller: viewModel.btnController,
                            onPressed: () {
                              viewModel.login(context);
                            },
                            child: roundedButtonText(
                              tr('log_in'),
                            ),
                          ),
                          heightSpace(15),
                          mainButton(tr('register')).onTap(() {
                            viewModel.navigation.navigateTo(RouteName.signUp);
                          }),
                          heightSpace(25),
                          contactWithUs(
                            context: context,
                            techNumber: tecContactNumber,
                            teacherNumber1: tecContactNumber,
                            teacherNumber2: teacherContactNumber2,
                          ),
                          heightSpace(30),
                          smallText('All rights reserved to N.I.T © 2022'),
                          heightSpace(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        ;
      },
    );
  }
}
