import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/parent_home/view_model/parent_home_view_model.dart';
import 'package:mrs_marwa/comman_widgets/inputField.dart';
import 'package:mrs_marwa/routs/routs_names.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../base_screen.dart';
import '../widgets/child_card.dart';
import '../widgets/exit_app_dialog.dart';

class ParentHomeView extends StatefulWidget {
  const ParentHomeView({Key? key}) : super(key: key);

  @override
  State<ParentHomeView> createState() => _ParentHomeViewState();
}

class _ParentHomeViewState extends State<ParentHomeView> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool exit = await showDialog(
          context: context,
          builder: (context) {
            return const ExitAPPDialog();
          },
        );
        return Future.value(exit);
      },
      child: BaseView<ParentHomeViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getToken();
          await viewModel.getUserImage();
          await viewModel.getParentEmail();
          if (!mounted) return;
          viewModel.getParentChildren(context);
        },
        builder: (context, viewModel, child) {
          return Container(
            color: mainColor,
            child: SafeArea(
              top: true,
              left: false,
              right: false,
              bottom: false,
              child: Form(
                key: viewModel.addChildFormKey,
                child: Scaffold(
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
                    title: appBarTitle(tr('mr_name')),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout_outlined),
                        onPressed: () {
                          viewModel.logOut();
                        },
                      ),
                    ],
                  ),
                  body: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          heightSpace(20),
                          Stack(
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
                                      borderRadius: BorderRadius.circular(50)),
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
                          smallBoldTitle(
                            '${viewModel.parentFirstName} ${viewModel.parentLastName}',
                            color: blackColor,
                          ),
                          smallText(
                            tr('change_pass'),
                            color: mainColor,
                          ).onTap(() {
                            viewModel.navigation
                                .navigateTo(RouteName.changePasswordView);
                          }),
                          smallText(
                            tr('edit_profile'),
                            color: mainColor,
                          ).onTap(() {
                            viewModel.navigation.navigateTo(
                              RouteName.parentEditProfile,
                            );
                          }),
                          heightSpace(20),
                        ],
                      ),
                      titleWidget(tr('contacts')),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallBoldTitle(tr('email'), color: blackColor),
                            Text(viewModel.email),
                          ],
                        ),
                      ),
                      titleWidget(tr('children')),
                      viewModel.childrenListState == false
                          ? const SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              ),
                            )
                          : viewModel.childrenList.isEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: mediumText(
                                      tr('no_child'),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    ...viewModel.childrenList.map(
                                      (child) {
                                        return childCard(child, context);
                                      },
                                    ).toList(),
                                  ],
                                ),
                      titleWidget(tr('add_child')),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputField(
                              hint: tr('student_email'),
                              inputType: TextInputType.text,
                              controller: viewModel.emailController,
                              icon: Icons.email,
                              validator: viewModel.emailValidator(),
                            ),
                            heightSpace(10),
                            InputField(
                              hint: tr('student_mobile_num'),
                              inputType: TextInputType.number,
                              controller: viewModel.mobileController,
                              icon: Icons.phone,
                              validator: viewModel.mobileValidator(),
                            ),
                            heightSpace(20),
                            RoundedLoadingButton(
                              width: deviceSize.width,
                              color: mainColor,
                              successColor: successfulColor,
                              errorColor: errorColor,
                              height: 50,
                              controller: viewModel.btnController,
                              onPressed: () {
                                viewModel.addChildToParent(context);
                              },
                              child: roundedButtonText(
                                tr('add'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
