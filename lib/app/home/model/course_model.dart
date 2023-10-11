import 'package:mrs_marwa/utils/strings.dart';

class CourseModel {
  String? status;
  List<Course>? data;
  String? error;

  CourseModel({this.status, this.data, this.error});

  CourseModel.fromJson(Map<String, dynamic> json, {required String token}) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Course.fromJson(v, token: token));
      });
    }
    error = json['error'];
  }
}

class Course {
  String? courseId;
  String? courseName;
  String? courseDesc;
  String? catId;
  String? catName;
  int? rate;
  String? courseImage;
  String? price;
  String? views;
  String? catDesc;

  Course(
      {this.courseId,
      this.courseName,
      this.courseDesc,
      this.catId,
      this.catName,
      this.rate,
      this.courseImage,
      this.price,
      this.views,
      this.catDesc});

  factory Course.fromJson(Map<String, dynamic> json, {required String token}) {
    return Course(
      courseId: json['courseId'] ?? '',
      courseName: json['courseName'] ?? '',
      courseDesc: json['courseDesc'] ?? '',
      catId: json['cat_id'] ?? '',
      catName: json['catName'] ?? '',
      courseImage: json['course_image'] == null
          ? defaultCourseImage
          : '${json['course_image']}?token=$token',
      price: json['price'] ?? '',
      views: json['views'] ?? '',
      catDesc: json['catDesc'] ?? '',
      rate: json['rate'] ?? 0,
    );
  }
}
