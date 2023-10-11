import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mrs_marwa/app/teacher_profile/view_model/teacher_profile_view_model.dart';
import 'package:mrs_marwa/app/teacher_profile/widgets/add_photos_button.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';
import 'package:mrs_marwa/utils/texts.dart';

import '../../../utils/strings.dart';

class TeacherProfileView extends StatefulWidget {
  const TeacherProfileView({Key? key}) : super(key: key);

  @override
  State<TeacherProfileView> createState() => _TeacherProfileViewState();
}

class _TeacherProfileViewState extends State<TeacherProfileView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherProfileViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getImageUrl();
        if (!mounted) return;
        await viewModel.getTeacherData(context, viewModel.token);
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
                title: appBarTitle(
                  tr('mr_name'),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    heightSpace(20),
                    Stack(
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: SizedBox(
                            height: 120,
                            width: 120,
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
                                  viewModel.getImageUrl();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSpace(10),
                    title(tr('mr_name')),
                    heightSpace(20),
                    RatingBar.builder(
                      initialRating: viewModel.rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    heightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            viewModel.launchWhatsApp(teacherContactNumber);
                          },
                          icon: Image.asset(
                            'assets/images/whats_app.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(20),
                        IconButton(
                          onPressed: () {
                            viewModel.launchTeacherUrl(
                              Uri.parse(teacherFaceBookLink),
                            );
                          },
                          icon: Image.asset(
                            'assets/images/fb.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(20),
                        IconButton(
                          onPressed: () {
                            viewModel.launchTeacherUrl(
                              Uri.parse(teacherYoutubeLink),
                            );
                          },
                          icon: Image.asset(
                            'assets/images/youtube.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    heightSpace(20),
                    titleWidget(tr('courses')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: viewModel.coursesList.map(
                                  (e) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        width: 250,
                                        child: Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                '${e.overviewfiles[0].fileurl}?token=${viewModel.token}',
                                                height: 180,
                                                width: 250,
                                                fit: BoxFit.fill,
                                              ),
                                              heightSpace(10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    title(e.fullname),
                                                    heightSpace(10),
                                                    mediumText(
                                                      tr('mr_name'),
                                                      color: mainColor,
                                                    ),
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
                                ).toList(),
                              ),
                            ),
                          ),
                    heightSpace(20),
                    titleWidget(tr('photos')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : viewModel.photosList.isEmpty
                            ? Column(
                                children: [
                                  heightSpace(20),
                                  Center(
                                    child: mediumText(
                                      tr('no_data'),
                                    ),
                                  ),
                                  heightSpace(10),
                                  addPhotosButton(context, viewModel),
                                  heightSpace(20),
                                ],
                              )
                            : Column(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.30,
                                      enableInfiniteScroll: false,
                                      aspectRatio: 16 / 9,
                                      initialPage: 0,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1000),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                    ),
                                    items: viewModel.photosList.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, right: 8.0),
                                            child: Image.network(
                                              i.photos,
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  heightSpace(10),
                                  addPhotosButton(context, viewModel),
                                  heightSpace(10),
                                ],
                              ),
                    titleWidget(tr('feedback')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : viewModel.feedbacksList.isEmpty
                            ? Center(
                                child: mediumText(
                                  tr('no_data'),
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 16 / 9,
                                  initialPage: 0,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                ),
                                items: viewModel.feedbacksList.map(
                                  (i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: mediumText(
                                            i.feedback,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                  ],
                ),
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
    width: double.infinity,
    color: mainColor,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: mediumText(text, color: whiteColor),
  );
}
