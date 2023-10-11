import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/spaces.dart';

import '../../../utils/texts.dart';
Widget contactWithUsOnlyTech(
    String techNumber,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
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
      )
    ],
  );
}