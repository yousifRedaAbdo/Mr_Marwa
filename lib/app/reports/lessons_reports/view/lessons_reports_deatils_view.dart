import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/base_screen.dart';
import 'package:mrs_marwa/utils/colors.dart';
import 'package:mrs_marwa/utils/extensions.dart';
import 'package:mrs_marwa/utils/spaces.dart';

import '../../../../enums/screen_state.dart';
import '../../../single_student_report/view/single_student_report_view.dart';
import '../../../../utils/texts.dart';
import '../../quizzes_report/view/attendance_view.dart';
import '../../revision_reports/model/revision_report_model.dart';
import '../view_model/lessons_report_view_model.dart';

class LessonsReportDetailsView extends StatelessWidget {
  String title;
  String courseId;
  String objectId;

  LessonsReportDetailsView(this.title, this.courseId, this.objectId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LessonsReportsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getLessonsDetails(
          context,
          courseId: courseId,
          objectId: objectId,
          sortType: 'atoz',
        );
      },
      builder: (context, viewModel, child) {
        return Scaffold(
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
            title: appBarTitle(title),
            centerTitle: true,
            actions: [
              DropdownButton(
                hint: Text(
                  tr('order_by'),
                  style: const TextStyle(color: whiteColor, fontSize: 18),
                ),
                value: viewModel.selectionOrder,
                alignment: AlignmentDirectional.center,
                dropdownColor: mainColor,
                iconSize: 0,
                underline: heightSpace(0),
                items: viewModel.orderByList.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  viewModel.sortData(
                    context,
                    newValue: newValue!,
                    courseId: courseId,
                    objectId: objectId,
                  );
                },
              )
            ],
          ),
          body: viewModel.state == ViewState.Busy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : seenView(viewModel.seenList, courseId),
          floatingActionButton: FloatingActionButton(
            backgroundColor: backgroundColor,
            elevation: 10,
            child: const Icon(
              Icons.download,
              color: mainColor,
            ),
            onPressed: () {
              viewModel.generateLessonsReportPDF
                  .generateReport(viewModel.seenList, title);
            },
          ),
        );
      },
    );
  }
}

Widget seenView(List<Seen> list, String courseId) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace(10),
        Text(
          "${tr('student_num')} : ${list.length}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        heightSpace(10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return list.isEmpty
                  ? Center(
                      child: mediumText(tr('no_data')),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          radius: 20,
                          child: ClipOval(
                            child: Image.network(
                              list[index].image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardText(
                              list[index].fullname,
                              fontWeight: FontWeight.bold,
                            ),
                            cardText(
                              'Number of view :${list[index].number}',
                              fontWeight: FontWeight.w500,
                            ),
                            cardText(
                              list[index].lastseen,
                            ),
                            cardText(
                              'Center : ${list[index].centername}',
                            ),
                            cardText(
                              'Id : ${list[index].userid}',
                            ),
                          ],
                        ),
                      ),
                    ).onTap(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleStudentReportView(
                              list[index].fullname,
                              list[index].userid,
                              courseId,
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
        heightSpace(10),
      ],
    ),
  );
}
