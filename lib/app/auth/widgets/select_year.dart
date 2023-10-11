import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../view_model/auth_view_model.dart';

class SelectStudyYear extends StatefulWidget {
  AuthenticationViewModel authenticationViewModel = AuthenticationViewModel();

  @override
  State<SelectStudyYear> createState() => _SelectStudyYearState();
}

class _SelectStudyYearState extends State<SelectStudyYear> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradColor1, gradColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: DropdownButton(
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: whiteColor,
          ),
          isExpanded: true,
          underline: Container(),
          dropdownColor: mainColor,
          items: widget.authenticationViewModel.year.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(color: whiteColor, fontSize: 17),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              widget.authenticationViewModel.selected = value!;
              checkSelectYear(context);
            });
          },
          value: widget.authenticationViewModel.selected,
        ),
      ),
    );
  }

  checkSelectYear(context) {
    if (widget.authenticationViewModel.selected == tr('select_year')) {
      AuthenticationViewModel.studentYear = 0;
    } else if (widget.authenticationViewModel.selected ==
        tr('first_secondary')) {
      AuthenticationViewModel.studentYear = 10;
    } else if (widget.authenticationViewModel.selected ==
        tr('second_secondary')) {
      AuthenticationViewModel.studentYear = 11;
    } else if (widget.authenticationViewModel.selected ==
        tr('third_secondary')) {
      AuthenticationViewModel.studentYear = 12;
    }
  }
}
