import '../../../utils/strings.dart';

class HiddenCoursesModel {
  List<Data>? data;

  HiddenCoursesModel({this.data});

  HiddenCoursesModel.fromJson(Map<String, dynamic> json,
      {required String token}) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach(
        (v) {
          data!.add(
            Data.fromJson(
              v,
              token: token,
            ),
          );
        },
      );
    }
  }
}

class Data {
  String? courseId;
  String? courseName;
  String? enrol;
  String? courseDesc;
  String? courseYear;
  String? views;
  String? teacherId;
  String? teacherName;
  String? image;
  String? price;
  String? rate;
  String? catId;
  String? catName;

  Data({
    required this.courseId,
    required this.courseName,
    required this.enrol,
    required this.courseDesc,
    required this.courseYear,
    required this.views,
    required this.teacherId,
    required this.teacherName,
    required this.image,
    required this.price,
    required this.rate,
    required this.catId,
    required this.catName,
  });

  factory Data.fromJson(Map<String, dynamic> json, {required String token}) {
    return Data(
      courseId: json['course_id'] ?? '',
      courseName: json['course_name'] ?? '',
      enrol: json['enrol'] ?? '',
      courseDesc: json['course_desc'] ?? '',
      courseYear: json['course_year'] ?? '',
      views: json['views'],
      teacherId: json['teacherId'] ?? '',
      teacherName: json['teacherName'] ?? '',
      image: json['image'] == null
          ? defaultCourseImage
          : '${json['image']}?token=$token',
      price: json['price'] ?? '',
      rate: json['rate'] ?? '0',
      catId: json['cat_id'] ?? '',
      catName: json['cat_name'] ?? '',
    );
  }
}
