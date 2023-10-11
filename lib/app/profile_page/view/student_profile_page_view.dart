import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/routs/routs_names.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../../base_screen.dart';
import '../../../utils/spaces.dart';
import '../view_model/profile_page_view_model.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getUserData();
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                centerTitle: true,
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
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    appBarTitle(viewModel.firstName),
                    widthSpace(5),
                    appBarTitle(viewModel.lastName),
                  ],
                ),
              ),
              body: ListView(
                children: [
                  heightSpace(20),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: viewModel.userImage,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: whiteColor,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 16,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: whiteColor,
                                  size: 16,
                                ),
                                onPressed: () async {
                                  await viewModel.pickImage(context);
                                  viewModel.getUserImage();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  heightSpace(10),
                  Center(
                    child: smallText(
                      tr('feedbacks'),
                      color: mainColor,
                    ).onTap(() {
                      viewModel.navigation
                          .navigateTo(RouteName.studentFeedBacks);
                    }),
                  ),
                  heightSpace(20),
                  titleWidget(tr('contacts')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(20),
                        smallBoldTitle(tr('email'), color: blackColor),
                        heightSpace(10),
                        smallText(viewModel.email),
                        heightSpace(10),
                      ],
                    ),
                  ),
                  const Divider(
                    color: grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallBoldTitle(tr('country'), color: blackColor),
                        heightSpace(10),
                        smallText(tr('eg')),
                        heightSpace(10),
                      ],
                    ),
                  ),
                  titleWidget(tr('user_details')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(20),
                        smallBoldTitle(tr('center_name'), color: blackColor),
                        heightSpace(10),
                        smallText(viewModel.centerName),
                        heightSpace(10),
                      ],
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

Widget titleWidget(String text) {
  return Container(
    color: mainColor,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: mediumText(text, color: whiteColor),
  );
}
