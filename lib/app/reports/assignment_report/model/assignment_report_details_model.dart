class AssignmentReportDetailsModel {
  AssignmentReportDetailsModel({
    required this.state,
    required this.submitted,
    required this.notSubmitted,
  });

  late final String state;
  late final List<Submitted> submitted;
  late final List<NotSubmitted> notSubmitted;

  AssignmentReportDetailsModel.fromJson(Map<String, dynamic> json) {
    state = json['state'] ?? '';
    submitted = json['submitted'] == null
        ? []
        : List.from(json['submitted'])
            .map((e) => Submitted.fromJson(e))
            .toList();
    notSubmitted = json['notSubmitted'] == null
        ? []
        : List.from(json['notSubmitted'])
            .map((e) => NotSubmitted.fromJson(e))
            .toList();
  }
}

class Submitted {
  Submitted({
    required this.userid,
    required this.name,
    required this.image,
    required this.submissionState,
    required this.grade,
  });

  late final int userid;
  late final String name;
  late final String image;
  late final String submissionState;
  late final String grade;

  Submitted.fromJson(Map<String, dynamic> json) {
    userid = json['userid'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    submissionState = json['submissionState'] ?? '';
    grade = json['grade'] ?? '';
  }
}

class NotSubmitted {
  NotSubmitted({
    required this.userid,
    required this.name,
    required this.image,
  });

  late final String userid;
  late final String name;
  late final String image;

  NotSubmitted.fromJson(Map<String, dynamic> json) {
    userid = json['userid'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }
}
