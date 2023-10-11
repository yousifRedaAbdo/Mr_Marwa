
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/texts.dart';

Future<void> restrictionDialog(context, String description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        elevation: 10.0,
        backgroundColor: Colors.transparent,
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: mainColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: title(tr('content_restricted'), color: whiteColor)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: mediumText(description),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: smallText(
                  tr('cancel'),
                  color: whiteColor,
                ),
              ).onTap(
                () {
                  Navigator.of(context).pop('true');
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
