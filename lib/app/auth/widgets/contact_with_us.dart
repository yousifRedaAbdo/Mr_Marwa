import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../utils/spaces.dart';
import '../../../utils/texts.dart';
import '../view_model/auth_view_model.dart';

Widget contactWithUs({
  required String techNumber,
  required String teacherNumber1,
  required String teacherNumber2,
  context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      mediumText(
        tr('contact_center'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          normalMainBlueText(
            teacherNumber1,
          ),
          widthSpace(10),
          Image.asset(
            'assets/images/whats_app.png',
            height: 40,
            width: 40,
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: teacherNumber1);
      }),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          normalMainBlueText(
            teacherNumber2,
          ),
          widthSpace(10),
          Image.asset(
            'assets/images/whats_app.png',
            height: 40,
            width: 40,
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: teacherNumber2);
      }),
      mediumText(tr('tec_&_res')),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          normalMainBlueText(
            techNumber,
          ),
          widthSpace(10),
          Image.asset(
            'assets/images/whats_app.png',
            height: 40,
            width: 40,
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: techNumber);
      }),
    ],
  );
}

launchWhatsApp({
  required String mobileNumber,
}) async {
  final link = WhatsAppUnilink(
    phoneNumber: '002$mobileNumber',
  );
  await launch('$link');
}
