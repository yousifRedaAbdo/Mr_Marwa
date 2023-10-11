class AssignmentModel {
  AssignmentModel({
    required this.courses,
    required this.warnings,
  });

  late final List<Courses> courses;
  late final List<dynamic> warnings;

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    courses =
        List.from(json['courses']).map((e) => Courses.fromJson(e)).toList();
    warnings = List.castFrom<dynamic, dynamic>(json['warnings']);
  }
}

class Courses {
  Courses({
    required this.id,
    required this.fullname,
    required this.shortname,
    required this.timemodified,
    required this.assignments,
  });

  late final int id;
  late final String fullname;
  late final String shortname;
  late final int timemodified;
  late final List<Assignments> assignments;

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fullname = json['fullname'] ?? '';
    shortname = json['shortname'] ?? '';
    timemodified = json['timemodified'] ?? 0;
    assignments = json['assignments'] == null
        ? []
        : List.from(json['assignments'])
            .map((e) => Assignments.fromJson(e))
            .toList();
  }
}

class Assignments {
  Assignments({
    required this.id,
    required this.cmid,
    required this.course,
    required this.name,
    required this.nosubmissions,
    required this.submissiondrafts,
    required this.sendnotifications,
    required this.sendlatenotifications,
    required this.sendstudentnotifications,
    required this.duedate,
    required this.allowsubmissionsfromdate,
    required this.grade,
    required this.timemodified,
    required this.completionsubmit,
    required this.cutoffdate,
    required this.gradingduedate,
    required this.teamsubmission,
    required this.requireallteammemberssubmit,
    required this.teamsubmissiongroupingid,
    required this.blindmarking,
    required this.hidegrader,
    required this.revealidentities,
    required this.attemptreopenmethod,
    required this.maxattempts,
    required this.markingworkflow,
    required this.markingallocation,
    required this.requiresubmissionstatement,
    required this.preventsubmissionnotingroup,
    required this.introformat,
  });

  late final int id;
  late final int cmid;
  late final int course;
  late final String name;
  late final int nosubmissions;
  late final int submissiondrafts;
  late final int sendnotifications;
  late final int sendlatenotifications;
  late final int sendstudentnotifications;
  late final int duedate;
  late final int allowsubmissionsfromdate;
  late final int grade;
  late final int timemodified;
  late final int completionsubmit;
  late final int cutoffdate;
  late final int gradingduedate;
  late final int teamsubmission;
  late final int requireallteammemberssubmit;
  late final int teamsubmissiongroupingid;
  late final int blindmarking;
  late final int hidegrader;
  late final int revealidentities;
  late final String attemptreopenmethod;
  late final int maxattempts;
  late final int markingworkflow;
  late final int markingallocation;
  late final int requiresubmissionstatement;
  late final int preventsubmissionnotingroup;
  late final int introformat;

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    cmid = json['cmid'] ?? 0;
    course = json['course'] ?? 0;
    name = json['name'] ?? '';
    nosubmissions = json['nosubmissions'] ?? 0;
    submissiondrafts = json['submissiondrafts'] ?? 0;
    sendnotifications = json['sendnotifications'] ?? 0;
    sendlatenotifications = json['sendlatenotifications'] ?? 0;
    sendstudentnotifications = json['sendstudentnotifications'] ?? 0;
    duedate = json['duedate'] ?? 0;
    allowsubmissionsfromdate = json['allowsubmissionsfromdate'] ?? 0;
    grade = json['grade'] ?? 0;
    timemodified = json['timemodified'] ?? 0;
    completionsubmit = json['completionsubmit'] ?? 0;
    cutoffdate = json['cutoffdate'] ?? 0;
    gradingduedate = json['gradingduedate'] ?? 0;
    teamsubmission = json['teamsubmission'] ?? 0;
    requireallteammemberssubmit = json['requireallteammemberssubmit'] ?? 0;
    teamsubmissiongroupingid = json['teamsubmissiongroupingid'] ?? 0;
    blindmarking = json['blindmarking'] ?? 0;
    hidegrader = json['hidegrader'] ?? 0;
    revealidentities = json['revealidentities'] ?? 0;
    attemptreopenmethod = json['attemptreopenmethod'] ?? '';
    maxattempts = json['maxattempts'] ?? 0;
    markingworkflow = json['markingworkflow'] ?? 0;
    markingallocation = json['markingallocation'] ?? 0;
    requiresubmissionstatement = json['requiresubmissionstatement'] ?? 0;
    preventsubmissionnotingroup = json['preventsubmissionnotingroup'] ?? 0;
  }
}
