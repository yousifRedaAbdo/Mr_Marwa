import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../routs/routs_names.dart';
import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/texts.dart';
import '../view_model/student_teacher_view_model.dart';

Container hiddenCourseCard(StudentTeacherHomeViewModel viewModel, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    child: Card(
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                viewModel.hiddenCoursesList[index].image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpace(10),
                    title(viewModel.hiddenCoursesList[index].courseName!),
                    smallText(viewModel.hiddenCoursesList[index].courseDesc!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 15,
                              color: Colors.grey.shade700,
                            ),
                            widthSpace(10),
                            smallText(
                                viewModel.hiddenCoursesList[index].views!),
                          ],
                        ),
                        RatingBar.builder(
                          itemSize: 15.0,
                          initialRating: double.parse(viewModel
                              .hiddenCoursesList[index].rate!
                              .toString()),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: true,
                          ignoreGestures: true,
                          unratedColor: Colors.grey,
                          glowColor: Colors.yellow,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                    heightSpace(5),
                    mainColorTitle('mr_name'.tr()).onTap(
                      () {
                        viewModel.navigation.navigateTo(
                          RouteName.teacherInformationForStudentsView,
                        );
                      },
                    ),
                    heightSpace(10)
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: smallText(
                tr('new'),
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
