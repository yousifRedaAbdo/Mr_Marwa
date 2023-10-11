class UserFeedBackModel {
  List<Feedbacks>? feedbacks;

  UserFeedBackModel({this.feedbacks});

  UserFeedBackModel.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(Feedbacks.fromJson(v));
      });
    }
  }
}

class Feedbacks {
  String? id;
  String? title;
  String? feedback;
  String? course;
  String? user;
  String? teacherId;
  String? timecreated;
  String? timemodified;
  Teacher? teacher;

  Feedbacks(
      {this.id,
      this.title,
      this.feedback,
      this.course,
      this.user,
      this.teacherId,
      this.timecreated,
      this.timemodified,
      this.teacher});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    feedback = json['feedback'];
    course = json['course'];
    user = json['user'];
    teacherId = json['teacher_id'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }
}

class Teacher {
  String? id;
  String? fullname;
  List<Customfields>? customfields;
  String? profileimageurl;
  String? profileimageurlsmall;
  String? description;
  String? descriptionformat;
  String? country;
  String? url;
  bool? suspended;
  String? firstaccess;
  String? lastaccess;
  int? lastcourseaccess;
  String? email;
  List<Enrolledcourses>? enrolledcourses;
  String? city;

  Teacher(
      {this.id,
      this.fullname,
      this.customfields,
      this.profileimageurl,
      this.profileimageurlsmall,
      this.description,
      this.descriptionformat,
      this.country,
      this.url,
      this.suspended,
      this.firstaccess,
      this.lastaccess,
      this.lastcourseaccess,
      this.email,
      this.enrolledcourses,
      this.city});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    if (json['customfields'] != null) {
      customfields = <Customfields>[];
      json['customfields'].forEach((v) {
        customfields!.add(Customfields.fromJson(v));
      });
    }
    profileimageurl = json['profileimageurl'];
    profileimageurlsmall = json['profileimageurlsmall'];
    description = json['description'];
    descriptionformat = json['descriptionformat'];
    country = json['country'];
    url = json['url'];
    suspended = json['suspended'];
    firstaccess = json['firstaccess'];
    lastaccess = json['lastaccess'];
    lastcourseaccess = json['lastcourseaccess'];
    email = json['email'];

    city = json['city'];
  }
}

class Customfields {
  String? name;
  String? value;
  String? type;
  String? shortname;

  Customfields({this.name, this.value, this.type, this.shortname});

  Customfields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    type = json['type'];
    shortname = json['shortname'];
  }
}

class Enrolledcourses {
  String? id;
  String? fullname;
  String? shortname;

  Enrolledcourses({this.id, this.fullname, this.shortname});

  Enrolledcourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    shortname = json['shortname'];
  }
}
