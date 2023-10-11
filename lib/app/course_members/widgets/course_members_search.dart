import 'package:flutter/material.dart';
import 'package:mrs_marwa/app/course_members/view_model/course_member_view_model.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/spaces.dart';

Widget courseMembersSearch(CourseMembersViewModel viewModel) {
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              heightSpace(15),
              SizedBox(
                height: 40,
                child: Center(
                  child: TextFormField(
                    controller: viewModel.searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'search by name or email or phone',
                      icon: Icon(Icons.search),
                      isDense: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        viewModel.searchList.isEmpty
                            ? viewModel.searchList =
                                viewModel.enrolledMembersList
                            : null;
                        viewModel.filter(value.toLowerCase());
                        print(value);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
