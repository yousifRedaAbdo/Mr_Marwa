import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/teacher_profile/model/teacher_data_model.dart';
import 'package:mrs_marwa/app/teacher_profile/view_model/teacher_profile_view_model.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/enums/screen_state.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

class EditImageView extends StatefulWidget {
  @override
  State<EditImageView> createState() => _EditImageViewState();
}

class _EditImageViewState extends State<EditImageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherProfileViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        if (!mounted) return;
        viewModel.getTeacherImages(context, viewModel.token);
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: false,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradColor1, gradColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                centerTitle: true,
                title: appBarTitle(
                  tr('mr_name'),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightSpace(10),
                  ElevatedButton(
                    onPressed: () async {
                      viewModel.uploadTeacherImages(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                    ),
                    child: mediumText(
                      tr('add'),
                      color: whiteColor,
                    ),
                  ),
                  heightSpace(10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.photosList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Image.network(
                                    viewModel.photosList[index].photos),
                                heightSpace(5),
                                ElevatedButton(
                                  onPressed: () async {
                                    await viewModel.deleteImage(
                                      context,
                                      imageId: viewModel.photosList[index].id,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: errorColor,
                                  ),
                                  child: mediumText(
                                    tr('delete'),
                                    color: whiteColor,
                                  ),
                                ),
                                heightSpace(5),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
