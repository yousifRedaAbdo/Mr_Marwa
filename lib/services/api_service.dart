import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/services/shared_pref_services.dart';
import 'package:mrs_marwa/utils/strings.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../locator.dart';

class ApiService {
  String baseUrl = 'https://academy2022.nitg-eg.com/';
  var pref = locator<SharedPrefServices>();
  var dio = Dio();

  ApiService() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
    var options = BaseOptions(// baseUrl: baseUrl,
        );
    dio.options = options;
  }

  loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/signleteacher/apis.php?function=login&email=$email&password=$password');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  register({
    required int role,
    required int year,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobile1,
    required String mobile2,
    required String city,
    required String school,
    required String center,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl/marwa/signleteacher/apis.php?function=register&fname=$firstName&lname=$lastName&email=$email&password=$password&phone1=$mobile1&phone2=$mobile2&role=$role&year=$year&city=$city&school=$school&center=$center',
      );
      if (response.statusCode == 200) {
        print('api call from api services');
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {}
  }

  resetPassword({required String email}) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/academyApi/json.php?username=$email&function=forget_password');
      if (response.statusCode == 200) {
        print('api call from api services');
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      print(e);
    }
  }

  getCourse({required String token}) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/signleteacher/apis.php?function=get_user_courses&token=$token&teacherid=$teacherUniqueId');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      print(e);
    }
  }

  getAboutUs() async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/signleteacher/apis.php?function=aboutInfo');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      print(e);
    }
  }

  editProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String mobile2,
    required String city,
    required String school,
    required String center,
    required String token,
  }) async {
    try {
      var response = await dio.post(
          '$baseUrl/marwa/signleteacher/apis.php?function=edit_user&token=$token&phone1=$mobile&city=$city&school=$school&center=$center&fname=$firstName&lname=$lastName&email=$email&phone2=$mobile2');
      if (response.statusCode == 200) {
        print(response);
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  editParentProfile({
    required String mobile,
  }) async {
    String token = await pref.getString(userToken);
    try {
      var response = await dio.post(
          '$baseUrl/marwa/signleteacher/apis.php?function=edit_user&token=$token&email=$mobile');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  getCourseContent({
    required String courseId,
    required String token,
  }) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/academyApi/json.php?token=$token&function=course_content_mobile&courseID=$courseId');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      print(e);
    }
  }

  getCourseHidden({
    required String token,
    required String teacherId,
  }) async {
    try {
      var lang = await pref.getString(selectedLang);
      var response = await dio.get(
          '$baseUrl/marwa/academyApi/json.php?token=$token&function=get_all_courses&id=$teacherId&language=$lang');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String token = await pref.getString(userToken);
    try {
      var response = await dio.post(
        '$baseUrl/marwa/signleteacher/apis.php?token=$token&function=change_pas&oldpassword=$oldPassword&newpassword=$newPassword',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      print(e);
    }
  }

  getCourseMember({required String courseId}) async {
    try {
      var response = await dio.post(
        '$baseUrl/marwa/academyApi/json.php?function=get_enrolled_users_members&courseID=$courseId',
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getAllQuizesReport({required String id}) async {
    try {
      var response = await dio.post(
        '$baseUrl/marwa/academyApi/quizreport.php?function=all_exams&courseid=$id',
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getQuizReport({
    required BuildContext context,
    required String id,
    required String sortType,
  }) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/academyApi/quizreport.php?function=quiz_report_course&id=$id&option=$sortType');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getStudentReport({
    required String userId,
    required String courseId,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl/marwa/academyApi/quizreport.php?function=course_report_quiz_user&courseid=$courseId&userid=$userId',
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getCourseVideosReport({
    required String courseId,
    required String objectId,
    required String sortType,
  }) async {
    try {
      var response = await dio.get(
          '$baseUrl/marwa/academyApi/quizreport.php?function=download_resource_report&courseid=$courseId&objectid=$objectId&option=$sortType');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getSeenAndUnseenReportsDetail({
    required String courseId,
    required String objectId,
    required String sortType,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?function=download_resource_report&courseid=$courseId&objectid=$objectId&option=$sortType';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getChildCourseToParent({
    required String id,
    required String token,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=get_child_courses&id=$id&token=$token';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {}
  }

  getParentChildrenData({required String token}) async {
    String url =
        '$baseUrl/marwa/signleteacher/apis.php?function=get_parent_data&token=$token';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  addChildToParent({
    required String token,
    required String email,
    required String mobile,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=create_child&token=$token&email=$email&phone1=$mobile';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  uploadImage({
    required File file,
    required String token,
  }) async {
    String url =
        '$baseUrl/marwa/signleteacher/apis.php?function=upload_image&token=$token';
    try {
      var data = FormData.fromMap(
        {
          "image": await MultipartFile.fromFile(
            file.path,
          ),
        },
      );
      var response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return 'fail';
    }
  }

  getTeacherData({required String token}) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?token=$token&function=teacher_data&id=$teacherUniqueId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  deleteTeacherImage({
    required String imageId,
  }) async {
    String url =
        '$baseUrl/marwa/signleteacher/apis.php?function=delete_teacher_images&imageId=$imageId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  addFeedBackForOneCourse({
    required String token,
    required String feedBackMessage,
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=add_student_feedback&teacherId=$teacherUniqueId&token=$token&feedback=$feedBackMessage&courseID=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  ///static teacher id
  addRating({
    required String token,
    required String rating,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=add_teacher_rating&id=$teacherUniqueId&token=$token&rating=$rating';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  uploadTeacherImages({
    required File file,
    required String token,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?token=$token&function=add_teacher_images';
    try {
      var data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file.path,
        ),
      });
      var response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  /// get all homework reports view
  getAllHomeWorkReport({
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?function=all_quizes&courseid=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {}
  }

  ///check code on hidden activities
  checkCode({
    required String token,
    required String courseId,
    required String activityId,
    required String code,
  }) async {
    String url =
        '$baseUrl/marwa/signleteacher/apis.php?function=check_codes&token=$token&course=$courseId&activityid=$activityId&code=$code';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  ///to add student to course group
  Future<bool> enrollStudentToCourse({
    required String token,
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=enrol_student&token=$token&courseID=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  ///get student feedbacks
  getStudentFeedbacks({required String token}) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?token=$token&function=get_user_feedbacks';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  ///to check activity availability
  checkActivityAvailability({
    required String token,
    required String courseId,
    required String activityId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=check_availability&token=$token&courseID=$courseId&activityid=$activityId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  Future<bool> checkSignUp() async {
    String url =
        'https://academy2022.nitg-eg.com/marwa/signleteacher/apis.php?function=confirm_signup';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  incCourseView({
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=course_view_data&courseID=$courseId';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    }
    return 'fail';
  }

  addCourseRate({
    required String courseId,
    required String token,
    required String rate,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/json.php?function=add_course_rate&token=$token&courseID=$courseId&rate=$rate';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return 'fail';
    }
  }

  getPdfInDetailReports({
    required String objectId,
    required String token,
    required String sortType,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?token=$token&function=pdfReport&objectid=$objectId&option=$sortType';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  getPdfReports({
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?function=allPdfs&courseid=$courseId';

    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  getAssignmentInDetailReports({
    required String objectId,
    required String token,
    required String sortType,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?function=assignReport&objectid=$objectId&token=$token&option=$sortType';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  getAssignment({
    required String token,
    required String courseId,
  }) async {
    String url =
        'https://academy2022.nitg-eg.com/webservice/rest/server.php?wstoken=$token&wsfunction=mod_assign_get_assignments&moodlewsrestformat=json&courseids[]=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  accessToCourse({
    required String courseId,
  }) async {
    String url =
        '$baseUrl/marwa/academyApi/quizreport.php?function=last_access_users&courseid=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  getCodesInformation({
    required String courseId,
    required String token,
  }) async {
    String url =
        'https://academy2022.nitg-eg.com/academygeneralapis/apis.php?function=get_course_Codes&token=$token&course=$courseId';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }

  setDeviceInfo({
    required String token,
    required String id,
    required String model,
    required String totalMemory,
    required String freeMemory,
    required String isPhysical,
  }) async {
    String url =
        'https://academy2022.nitg-eg.com/academygeneralapis/apis.php?function=set_user_mobile&token=$token&deviceid=$id&model=$model&totalmemory=$totalMemory&freememory=$freeMemory&phsical=$isPhysical&appname=MedhatNabil';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return;
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<bool> changeStudentPasswordFromTeacher({
    required String token,
    required String password,
  }) async {
    String url =
        'https://academy2022.nitg-eg.com/marwa/signleteacher/apis.php?function=teacherchangestudentpassword&token=$token&newpassword=$password';
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  getUseDataByToken({
    required String token,
  }) async {
    try {
      String url =
          'https://academy2022.nitg-eg.com/marwa/signleteacher/apis.php?function=get_user_by_token&token=$token';
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }
}
