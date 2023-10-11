class StudentReportModel {
  StudentReportModel({
    required this.quiz,
    required this.exam,
    required this.page,
    required this.file,
    required this.lesson,
    required this.homework,
    required this.summary,
    required this.pdf,
    required this.assign,
    required this.revision,
  });

  late final List<Quiz> quiz;
  late final List<Exam> exam;
  late final List<Page> page;
  late final List<File> file;
  late final List<Lesson> lesson;
  late final List<Homework> homework;
  late final List<Summary> summary;
  late final List<Pdf> pdf;
  late final List<Assign> assign;
  late final List<Revision> revision;

  StudentReportModel.fromJson(Map<String, dynamic> json) {
    quiz = json['quiz'] == null
        ? []
        : List.from(json['quiz']).map((e) => Quiz.fromJson(e)).toList();
    exam = json['exam'] == null
        ? []
        : List.from(json['exam']).map((e) => Exam.fromJson(e)).toList();
    page = json['page'] == null
        ? []
        : List.from(json['page']).map((e) => Page.fromJson(e)).toList();
    file = json['file'] == null
        ? []
        : List.from(json['file']).map((e) => File.fromJson(e)).toList();
    lesson = json['lesson'] == null
        ? []
        : List.from(json['lesson']).map((e) => Lesson.fromJson(e)).toList();
    homework = json['homework'] == null
        ? []
        : List.from(json['homework']).map((e) => Homework.fromJson(e)).toList();
    summary = json['summary'] == null
        ? []
        : List.from(json['summary']).map((e) => Summary.fromJson(e)).toList();

    pdf = json['pdf'] == null
        ? []
        : List.from(json['pdf']).map((e) => Pdf.fromJson(e)).toList();
    assign = json['assign'] == null
        ? []
        : List.from(json['assign']).map((e) => Assign.fromJson(e)).toList();
    revision = json['revision'] == null
        ? []
        : List.from(json['revision']).map((e) => Revision.fromJson(e)).toList();
  }
}

class Quiz {
  Quiz({
    required this.status,
    required this.quizid,
    required this.userid,
    required this.grade,
    required this.quizname,
  });

  late final String status;
  late final String quizid;
  late final String userid;
  late final String grade;
  late final String quizname;

  Quiz.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    quizid = json['quizid'] ?? '';
    userid = json['userid'].toString();
    grade = json['grade'] ?? '';
    quizname = json['quizname'] ?? '';
  }
}

class Exam {
  Exam({
    required this.status,
    required this.quizid,
    required this.userid,
    required this.grade,
    required this.quizname,
  });

  late final String status;
  late final String quizid;
  late final String userid;
  late final String grade;
  late final String quizname;

  Exam.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    quizid = json['quizid'] ?? '';
    userid = json['userid'] ?? '';
    grade = json['grade'] ?? '';
    quizname = json['quizname'] ?? '';
  }
}

class Page {
  Page({
    required this.pageViewed,
    required this.pageName,
    required this.views,
  });

  late final String pageViewed;
  late final String pageName;
  late final String views;

  Page.fromJson(Map<String, dynamic> json) {
    pageViewed = json['page_viewed'] ?? '';
    pageName = json['pageName'] ?? '';
    views = json['views'] ?? '';
  }
}

class File {
  File({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  File.fromJson(Map<String, dynamic> json) {
    fileViewed = json['file_viewed'] ?? '';
    fileName = json['fileName'] ?? '';
    views = json['views'] ?? '';
  }
}

class Lesson {
  Lesson({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  Lesson.fromJson(Map<String, dynamic> json) {
    fileViewed = json['file_viewed'] ?? '';
    fileName = json['fileName'] ?? '';
    views = json['views'] ?? '';
  }
}

class Homework {
  Homework({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  Homework.fromJson(Map<String, dynamic> json) {
    fileViewed = json['file_viewed'] ?? '';
    fileName = json['fileName'] ?? '';
    views = json['views'] ?? '';
  }
}

class Summary {
  Summary({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  Summary.fromJson(Map<String, dynamic> json) {
    fileViewed = json['file_viewed'] ?? '';
    fileName = json['fileName'] ?? '';
    views = json['views'] ?? '';
  }
}

class Pdf {
  Pdf({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  Pdf.fromJson(Map<String, dynamic> json) {
    fileViewed = json['pdfId'] ?? '';
    fileName = json['pdfName'] ?? '';
    views = json['views'] ?? '';
  }
}

class Assign {
  Assign({
    required this.assignId,
    required this.assignName,
    required this.submissionState,
    required this.grade,
    required this.grader,
    required this.timecreated,
    required this.timemodified,
  });

  late final String assignId;
  late final String assignName;
  late final String submissionState;
  late final String grade;
  late final String grader;
  late final String timecreated;
  late final String timemodified;

  Assign.fromJson(Map<String, dynamic> json) {
    assignId = json['assignId'] ?? '';
    assignName = json['assignName'] ?? '';
    submissionState = json['submissionState'].toString();
    grade = json['grade'] ?? '';
    grader = json['grader'] ?? '';
    timecreated = json['timecreated'] ?? '';
    timemodified = json['timemodified'] ?? '';
  }
}

class Revision {
  Revision({
    required this.fileViewed,
    required this.fileName,
    required this.views,
  });

  late final String fileViewed;
  late final String fileName;
  late final String views;

  Revision.fromJson(Map<String, dynamic> json) {
    fileViewed = json['file_viewed'] ?? '';
    fileName = json['fileName'] ?? '';
    views = json['views'] ?? '';
  }
}
