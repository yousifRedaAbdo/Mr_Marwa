
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_content/view_model/course_content_view_model.dart';
import 'package:mrs_marwa/utils/colors.dart';

SizedBox codeFormField(CourseContentViewModel viewModel) {
  return SizedBox(
    width: 200,
    child: TextFormField(
      cursorColor: mainColor,
      validator: viewModel.codeValidator(),
      controller: viewModel.codeController,
      style: const TextStyle(
          color: Colors.black, fontSize: 17),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13, horizontal: 10),
        isDense: true,
        hintText: tr('enter_code'),
        labelStyle: const TextStyle(color: blueColor),
        enabledBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: mainColor, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: mainColor, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: errorColor, width: 2),
          gapPadding: 0,
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grey, width: 2),
          gapPadding: 0,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: errorColor, width: 2),
          gapPadding: 0,
        ),
        suffixIconConstraints:
        const BoxConstraints(maxHeight: 20),
      ),
    ),
  );
}
