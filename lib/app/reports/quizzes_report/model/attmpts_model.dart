import '../../../../utils/strings.dart';

class AttempsModel {
  AttempsModel({
    required this.submitted,
    required this.inprogress,
    required this.notsubmitted,
  });

  late final List<Submitted> submitted;
  late final List<dynamic> inprogress;
  late final List<Notsubmitted> notsubmitted;

  AttempsModel.fromJson(Map<String, dynamic> json) {
    submitted =
        List.from(json['submitted']).map((e) => Submitted.fromJson(e)).toList();
    inprogress = List.from(json['inprogress'])
        .map((e) => Inprogress.fromJson(e))
        .toList();
    notsubmitted = List.from(json['notsubmitted'])
        .map((e) => Notsubmitted.fromJson(e))
        .toList();
  }
}

class Submitted {
  Submitted({
    required this.state,
    required this.userid,
    required this.quiz,
    required this.timefinished,
    required this.fullname,
    required this.grade,
    required this.image,
    required this.centername,
    required this.schooname,
  });

  late final String state;
  late final String userid;
  late final int quiz;
  late final String timefinished;
  late final String fullname;
  late final String grade;
  late final String image;
  late final String centername;
  late final String schooname;

  factory Submitted.fromJson(Map<String, dynamic> json) {
    return Submitted(
      state: json['state'] ?? '',
      userid: json['userid'] ?? '',
      quiz: json['quiz'] ?? 0,
      timefinished: json['timefinished'] ?? '',
      fullname: json['fullname'] ?? '',
      grade: json['grade'] ?? '',
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : json['image'],
      centername: json['centername'] ?? '',
      schooname: json['schooname'] ?? '',
    );
  }
}

class Notsubmitted {
  Notsubmitted({
    required this.state,
    required this.userid,
    required this.quiz,
    required this.fullname,
    required this.image,
    required this.centername,
    required this.schooname,
  });

  late final String state;
  late final String userid;
  late final int quiz;
  late final String fullname;
  late final String image;
  late final String centername;
  late final String schooname;

  factory Notsubmitted.fromJson(Map<String, dynamic> json) {
    return Notsubmitted(
      state: json['state'] ?? '',
      userid: json['userid'] ?? '',
      quiz: json['quiz'] ?? 0,
      fullname: json['fullname'] ?? '',
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : json['image'],
      centername: json['centername'] ?? '',
      schooname: json['schooname'] ?? '',
    );
  }
}

class Inprogress {
  Inprogress({
    required this.state,
    required this.userid,
    required this.quiz,
    required this.fullname,
    required this.centername,
    required this.schooname,
  });

  late final String state;
  late final String userid;
  late final int quiz;
  late final String fullname;
  late final String centername;
  late final String schooname;

  Inprogress.fromJson(Map<String, dynamic> json) {
    state = json['state'] ?? '';
    userid = json['userid'] ?? '';
    quiz = json['quiz'] ?? 0;
    fullname = json['fullname'] ?? '';
    centername = json['centername'] ?? '';
    schooname = json['schooname'] ?? '';
  }
}
