import '../../../../utils/strings.dart';

class QuizVideosReportModel {
  QuizVideosReportModel({
    required this.seen,
    required this.notseen,
  });

  late final List<Seen> seen;
  late final List<Notseen> notseen;

  QuizVideosReportModel.fromJson(Map<String, dynamic> json) {
    seen = List.from(json['seen']).map((e) => Seen.fromJson(e)).toList();
    notseen =
        List.from(json['notseen']).map((e) => Notseen.fromJson(e)).toList();
  }
}

class Seen {
  Seen({
    required this.state,
    required this.userid,
    required this.fullname,
    required this.number,
    required this.lastseen,
    required this.image,
    required this.centername,
    required this.schoolname,
  });

  late final String state;
  late final String userid;
  late final String fullname;
  late final String number;
  late final String lastseen;
  late final String image;
  late final String centername;
  late final String schoolname;

  factory Seen.fromJson(Map<String, dynamic> json) {
    return Seen(
      state: json['state'] ?? '',
      userid: json['userid'] ?? '',
      fullname: json['fullname'] ?? '',
      number: json['number'] ?? '',
      lastseen: json['lastseen'] ?? '',
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : json['image'],
      centername: json['centername'] ?? '',
      schoolname: json['schoolname'] ?? '',
    );
  }
}

class Notseen {
  Notseen({
    required this.state,
    required this.userid,
    required this.fullname,
    required this.number,
    required this.image,
    required this.centername,
    required this.schoolname,
  });

  late final String state;
  late final String userid;
  late final String fullname;
  late final String number;
  late final String image;
  late final String centername;
  late final String schoolname;

  factory Notseen.fromJson(Map<String, dynamic> json) {
    return Notseen(
      state: json['state'] ?? '',
      userid: json['userid'] ?? '',
      fullname: json['fullname'] ?? '',
      number: json['number'] ?? '',
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : json['image'],
      centername: json['centername'] ?? '',
      schoolname: json['schoolname'] ?? '',
    );
  }
}
