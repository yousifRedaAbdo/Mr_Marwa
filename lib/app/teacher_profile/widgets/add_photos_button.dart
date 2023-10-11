import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/teacher_profile/view/edit_image_view.dart';
import 'package:mrs_marwa/app/teacher_profile/view_model/teacher_profile_view_model.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/texts.dart';

ElevatedButton addPhotosButton(
    BuildContext context, TeacherProfileViewModel viewModel) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: mainColor,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditImageView(),
        ),
      );
    },
    child: roundedButtonText(tr('edit_image')),
  );
}
