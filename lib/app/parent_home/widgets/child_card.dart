import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';

import '../../../utils/spaces.dart';
import '../../../utils/strings.dart';
import '../../../utils/texts.dart';
import '../../child_courses_for_parent/view/child_courses_for_parent_view.dart';
import '../model/parent_children_model.dart';

Widget childCard(Data child, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(50)),
              child: Image.network(
                child.url == '' ? defaultImage : child.url,
                fit: BoxFit.cover,
              ),
            ),
            widthSpace(20),
            mediumText(
              '${child.firstname}  ${child.lastname}',
            ),
          ],
        ),
      ),
    ).onTap(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChildCoursesForParentView(
            firstName: child.firstname,
            lastName: child.lastname,
            childId: child.childid,
            childName: '${child.firstname}  ${child.lastname}',
          ),
        ),
      );
    }),
  );
}
