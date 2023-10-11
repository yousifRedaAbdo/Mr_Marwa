import 'package:flutter/material.dart';

import '../../../base_screen.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      onModelReady: (viewModel) {
        viewModel.splashNavigation();
      },
      builder: (context, viewModel, child) {
        return SafeArea(
          bottom: false,
          right: false,
          left: false,
          top: false,
          child: Scaffold(
            backgroundColor: const Color(0xffF7F6F8),
            body: Center(
              child: Image.asset(
                'assets/images/splash_screen.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }
}
