import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_content/view_model/course_content_view_model.dart';
import 'package:mrs_marwa/app/course_content/widgets/code_form_field.dart';
import 'package:mrs_marwa/app/qr_code/view/qr_code_view.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/strings.dart';
import '../../../utils/texts.dart';
import '../../course_details/widgets/contact_with_tech.dart';

///custom restriction dialog only for lessons
Future<dynamic> lessonsRestrictionDialog({
  required context,
  required String description,
  required String courseId,
  required String activityId,
}) async {
  /// split , with \n to move to next line
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        elevation: 10.0,
        backgroundColor: Colors.transparent,
        child: LessonsRestrictionsDialog(
          context,
          description,
          courseId,
          activityId,
        ),
      );
    },
  );
}

class LessonsRestrictionsDialog extends StatelessWidget {
  BuildContext context;
  String description;
  String courseId;
  String activityId;

  LessonsRestrictionsDialog(
    this.context,
    this.description,
    this.courseId,
    this.activityId,
  );

  // required
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseContentViewModel>(
      onModelReady: (viewModel) async {},
      onFinish: (viewModel) {
        viewModel.isCodeValid = true;
      },
      builder: (context, viewModel, child) {
        var updateAvailMessages = description.replaceAll(',', '\n').toString();

        return Form(
          key: viewModel.codeFormKey,
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    color: mainColor,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                          left: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              size: 25,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              viewModel.codeController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        title(tr('content_restricted'), color: whiteColor),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: mediumText(updateAvailMessages),
                          ),
                          heightSpace(15),
                          updateAvailMessages
                                  .contains('you have reached the limit of')
                              ? Container()
                              : contactWithUsOnlyTech(tecContactNumber)
                                  .onTap(() {
                                  viewModel.launchWhatsApp(tecContactNumber);
                                }),
                          heightSpace(25),
                          Icon(
                            Icons.qr_code,
                            size: 50,
                          ).onTap(
                            () async {
                              String code = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const QrCodeView(),
                                ),
                              );
                              await viewModel.getToken();
                              viewModel.codeController.text = code;
                              await viewModel.getToken();
                              var result = await viewModel.checkCode(
                                context,
                                token: viewModel.token,
                                courseId: courseId,
                                activityId: activityId,
                                code: viewModel.codeController.text,
                              );

                              switch (result) {
                                case 'success':
                                  {
                                    if (description.contains(',')) {
                                      Navigator.pop(context, false);
                                    } else {
                                      Navigator.pop(context, true);
                                    }
                                  }
                                  break;
                                case 'not valid code':
                                  {
                                    viewModel.isCodeValid = false;
                                    viewModel.updateState();
                                  }
                                  break;

                                default:
                                  {
                                    viewModel.isCodeValid = false;
                                    viewModel.updateState();
                                  }
                                  break;
                              }
                            },
                          ),
                          heightSpace(20),
                          updateAvailMessages
                                  .contains('you have reached the limit of')
                              ? Container()
                              : Column(
                                  children: [
                                    codeFormField(viewModel),
                                    heightSpace(12.5),
                                    !viewModel.isCodeValid
                                        ? Text(
                                            tr('not_valid_code'),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                            ),
                                          )
                                        : Container(),
                                    heightSpace(25),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () async {
                                        await viewModel.getToken();
                                        var result = await viewModel.checkCode(
                                          context,
                                          token: viewModel.token,
                                          courseId: courseId,
                                          activityId: activityId,
                                          code: viewModel.codeController.text,
                                        );

                                        switch (result) {
                                          case 'success':
                                            {
                                              if (description.contains(',')) {
                                                Navigator.pop(context, false);
                                              } else {
                                                Navigator.pop(context, true);
                                              }
                                            }
                                            break;
                                          case 'not valid code':
                                            {
                                              viewModel.isCodeValid = false;
                                              viewModel.updateState();
                                            }
                                            break;

                                          default:
                                            {
                                              viewModel.isCodeValid = false;
                                              viewModel.updateState();
                                            }
                                            break;
                                        }
                                      },
                                      child: mediumText(
                                        tr('add'),
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
