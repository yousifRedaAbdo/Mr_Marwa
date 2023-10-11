import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/teacher_information_for_students/view_model/teacher_information_for_students_view_model.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

class AddRateView extends StatelessWidget {
  String courseId;

  AddRateView(this.courseId);

  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherInformationForStudentsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getToken();
      },
      onFinish: (viewModel) {
        viewModel.setState(ViewState.Idle);
      },
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.rateFormKey,
          child: Container(
            color: mainColor,
            child: SafeArea(
              bottom: false,
              right: false,
              left: false,
              top: true,
              child: Scaffold(
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradColor1, gradColor2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  elevation: 0,
                  centerTitle: true,
                  title: appBarTitle(tr('add_feed_back')),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 25),
                  child: ListView(
                    children: [
                      TextFormField(
                        cursorColor: mainColor,
                        maxLines: 8,
                        controller: viewModel.feedBackController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        decoration: InputDecoration(
                          hintText: tr('add_feed_back'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          isDense: true,
                          labelStyle: const TextStyle(color: blueColor),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: errorColor, width: 2),
                            gapPadding: 0,
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 2),
                            gapPadding: 0,
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: errorColor, width: 2),
                            gapPadding: 0,
                          ),
                          constraints: const BoxConstraints(minHeight: 100),
                        ),
                        validator: viewModel.feedBackValidator(),
                      ),
                      heightSpace(30),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.addFeedBackForOneCourse(
                            context,
                            token: viewModel.token,
                            feedBackMessage: viewModel.feedBackController.text,
                            courseId: courseId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: mainColor,
                        ),
                        child: mediumText(
                          tr('add'),
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
