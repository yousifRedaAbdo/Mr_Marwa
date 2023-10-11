import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../terms_and_privacy/view/terms_and_condetions_view.dart';

RichText termsAndConditions(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: '${tr('by_creating')} \n',
      style: const TextStyle(
        color: blackColor,
        height: 1.5,
        fontFamily: 'dinfont',
      ),
      children: [
        TextSpan(
          text: tr('terms_and_conditions'),
          style: const TextStyle(
              color: blackColor,
              fontFamily: 'dinfont',
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndPolicy(
                    mdFileName: 'terms_and_conditions.md',
                    appBarTitleText: tr('terms_and_conditions'),
                  ),
                ),
              );
            },
        ),
        TextSpan(
          text: tr('and'),
          style: const TextStyle(
            color: blackColor,
            fontFamily: 'dinfont',
          ),
        ),
        TextSpan(
          text: tr('privacy_policy'),
          style: const TextStyle(
            color: blackColor,
            fontFamily: 'dinfont',
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndPolicy(
                    mdFileName: 'privacy_policy.md',
                    appBarTitleText: tr('privacy_policy'),
                  ),
                ),
              );
            },
        ),
      ],
    ),
  );
}
