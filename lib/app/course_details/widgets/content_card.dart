import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/locator.dart';
import 'package:mrs_marwa/services/api_service.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../web_view/view/web_view.dart';

var apiServices = locator<ApiService>();

Widget contentCard({
  context,
  required String image,
  required String text,
  required String url,
  required String token,
  required String courseId,
  required String activityId,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: mainColor,
    ),
    child: Row(
      children: [
        Image.asset(
          image,
          height: 35,
        ),
        widthSpace(20),
        Flexible(child: mediumText(text, color: whiteColor)),
      ],
    ),
  ).onTap(
    () async {
      var data = await apiServices.checkActivityAvailability(
        token: token,
        courseId: courseId,
        activityId: activityId,
      );
      if (data == 'fail') {
        //TODO show dialog
      } else {
        var model = ActivityAvailbiltyModel.fromJson(data);
        if (model.flag) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppWebView('$url&token=$token', text),
            ),
          );
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: tr('sorry'),
            desc: model.data,
            btnCancelOnPress: () {},
          ).show();
        }
      }
    },
  );
}

class ActivityAvailbiltyModel {
  ActivityAvailbiltyModel({
    required this.flag,
    required this.data,
  });

  late final bool flag;
  late final String data;

  ActivityAvailbiltyModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    data = json['data'];
  }
}
