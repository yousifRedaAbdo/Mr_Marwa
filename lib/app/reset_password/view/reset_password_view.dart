import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/comman_widgets/main_button.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/inputField.dart';
import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/texts.dart';
import '../view_model/reset_password_view_model.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                title: appBarTitle(tr('reset_pass')),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradColor1, gradColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Form(
                    key: viewModel.resetPasswordFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          inputType: TextInputType.emailAddress,
                          controller: viewModel.email,
                          validator: viewModel.emailValidator(),
                          icon: Icons.email,
                          hint: tr('email'),
                        ),
                        heightSpace(50),
                        mainButton(tr('reset_password')).onTap(() {
                          viewModel.resetPassword(context,);
                        })

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
