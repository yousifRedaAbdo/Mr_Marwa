import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/colors.dart';

Future<void> loadingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      );
    },
  );
}
