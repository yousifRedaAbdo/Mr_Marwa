import 'package:mrs_marwa/utils/strings.dart';

class CourseMemberModel {
  CourseMemberModel({
    required this.groupmember,
    required this.others,
  });

  late final List<Groupmember> groupmember;
  late final List<Others> others;

  CourseMemberModel.fromJson(Map<String, dynamic> json) {
    groupmember = List.from(json['groupmember'])
        .map((e) => Groupmember.fromJson(e))
        .toList();
    others = List.from(json['others']).map((e) => Others.fromJson(e)).toList();
  }
}

class Groupmember {
  Groupmember({
    required this.id,
    required this.fullName,
    required this.image,
    required this.centerName,
    required this.schoolName,
    required this.email,
    required this.phone,
    required this.token,
  });

  late final String id;
  late final String fullName;
  late final String image;
  late final String centerName;
  late final String schoolName;
  late final String email;
  late final String phone;
  late final String token;

  factory Groupmember.fromJson(Map<String, dynamic> json) {
    return Groupmember(
      id: json['id'],
      fullName: json['fullname'].toString().toLowerCase(),
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : 'https://academy2022.nitg-eg.com//theme/edumy/images/teachers/${json['image']}',
      centerName: json['center_name'],
      schoolName: json['school_name'],
      email: json['email'],
      phone: json['student_phone'],
      token: json['usertoken'],
    );
  }
}

class Others {
  Others({
    required this.id,
    required this.fullName,
    required this.image,
    required this.centerName,
    required this.schoolName,
  });

  late final String id;
  late final String fullName;
  late final String image;
  late final String centerName;
  late final String schoolName;

  factory Others.fromJson(Map<String, dynamic> json) {
    return Others(
      id: json['id'],
      fullName: json['fullname'],
      image: (json['image'] == '' || json['image'] == null)
          ? defaultImage
          : 'https://academy2022.nitg-eg.com//theme/edumy/images/teachers/${json['image']}',
      centerName: json['center_name'],
      schoolName: json['school_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullname'] = fullName;
    _data['image'] = image;
    _data['center_name'] = centerName;
    _data['school_name'] = schoolName;
    return _data;
  }
}
