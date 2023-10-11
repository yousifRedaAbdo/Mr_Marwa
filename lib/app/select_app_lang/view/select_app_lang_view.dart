import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/select_app_lang/view_model/select_app_lang_view_model.dart';
import 'package:mrs_marwa/comman_widgets/main_button.dart';
import 'package:mrs_marwa/routs/routs_names.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/strings.dart';

class SelectAppLangView extends StatelessWidget {
  const SelectAppLangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectAppLangViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return SafeArea(
          bottom: false,
          right: false,
          left: false,
          top: false,
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainButton('كيمياء').onTap(() async {
                      context.setLocale(const Locale('ar'));
                      await viewModel.pref.saveBoolean(isFirstOpen, false);
                      await viewModel.pref.saveString(selectedLang, 'ar');
                      viewModel.navigation
                          .navigateToAndClearStack(RouteName.logIn);
                    }),
                    heightSpace(30),
                    mainButton('Chemistry').onTap(() async {
                      context.setLocale(const Locale('en'));
                      await viewModel.pref.saveBoolean(isFirstOpen, false);
                      await viewModel.pref.saveString(selectedLang, 'en');
                      viewModel.navigation
                          .navigateToAndClearStack(RouteName.logIn);
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
