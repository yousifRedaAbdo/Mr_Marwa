import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/contact_us/view_model/contact_us_view_model.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/strings.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../auth/widgets/contact_with_us.dart';

class ContactUsView extends StatelessWidget {
  String activityId;
  String courseId;
  String availMessages;
  ContactUsView({
    Key? key,
    required this.activityId,
    required this.courseId,
    required this.availMessages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(activityId);
    print('check availMessages : ');
    print(availMessages);
    print(availMessages.length);
    return BaseView<ContactUsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getToken();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
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
                centerTitle: true,
                title: appBarTitle(tr('contact')),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  contactWithUs(
                    context: context,
                    techNumber: tecContactNumber,
                    teacherNumber2: teacherContactNumber2,
                    teacherNumber1: teacherContactNumber,
                  ),
                  heightSpace(25),
                ],
              ),
        );
      },
    );
  }
}
