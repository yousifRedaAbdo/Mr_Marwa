import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

class ExitAPPDialog extends StatelessWidget {
  const ExitAPPDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradColor1, gradColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Center(child: title(tr('are_you_sure'), color: whiteColor)),
            ),
            heightSpace(35),
            mediumText(tr('exit_app')),
            heightSpace(45),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradColor1, gradColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    tr('yes'),
                    style: const TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ).onTap(
                  () {
                    Navigator.pop(context, true);
                  },
                ),
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradColor1, gradColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    tr('no'),
                    style: const TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ).onTap(
                  () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
