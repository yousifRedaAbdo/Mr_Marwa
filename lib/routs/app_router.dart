import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/auth/view/sign_up_view.dart';
import 'package:mrs_marwa/app/change_password/view/change_password_view.dart';
import 'package:mrs_marwa/app/codes_info/view/codes_information_view.dart';
import 'package:mrs_marwa/app/edit_profile/view/edit_profile_view.dart';
import 'package:mrs_marwa/app/home/view/student_teacher_home.dart';
import 'package:mrs_marwa/app/home_drawer/view/about_us_view.dart';
import 'package:mrs_marwa/app/home_drawer/view/contact_us.dart';
import 'package:mrs_marwa/app/parent_home/view/parent_home_view.dart';
import 'package:mrs_marwa/app/profile_page/view/student_feedback_view.dart';
import 'package:mrs_marwa/app/teacher_profile/view/teacher_profile_view.dart';

import '../app/auth/view/log_in_view.dart';
import '../app/parent_edit_profile/view/parent_edit_profile.dart';
import '../app/qr_code/view/qr_code_view.dart';
import '../app/reset_password/view/reset_password_view.dart';
import '../app/select_app_lang/view/select_app_lang_view.dart';
import '../app/splash/view/splash_view.dart';
import 'routing_data.dart';
import 'routs_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uriData = Uri.parse(settings.name!);

    print('settings.name ${settings.name}');

    var routingData = RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );

    switch (routingData.route) {
      case RouteName.splash:
        return _getPageRoute(const SplashView(), settings);
      case RouteName.home:
        return _getPageRoute(StudentTeacherHomeView(), settings);
      case RouteName.logIn:
        return _getPageRoute(const LogInView(), settings);
      case RouteName.signUp:
        return _getPageRoute(const SignUp(), settings);
      case RouteName.resetPassword:
        return _getPageRoute(const ResetPasswordView(), settings);
      case RouteName.parentHome:
        return _getPageRoute(const ParentHomeView(), settings);
      case RouteName.qrCode:
        return _getPageRoute(const QrCodeView(), settings);
      case RouteName.editProfileView:
        return _getPageRoute(const EditProfileView(), settings);
      case RouteName.changePasswordView:
        return _getPageRoute(const ChangePasswordView(), settings);
      case RouteName.contactUsView:
        return _getPageRoute(const ContactUsView(), settings);
      case RouteName.aboutUsView:
        return _getPageRoute(const AboutUsView(), settings);
      case RouteName.parentEditProfile:
        return _getPageRoute(const ParentEditProfileView(), settings);
      case RouteName.teacherProfileView:
        return _getPageRoute(const TeacherProfileView(), settings);
      case RouteName.selectLang:
        return _getPageRoute(const SelectAppLangView(), settings);
      case RouteName.studentFeedBacks:
        return _getPageRoute(const StudentFeedBackView(), settings);

      default:
        return _getPageRoute(const SplashView(), settings);
    }
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
