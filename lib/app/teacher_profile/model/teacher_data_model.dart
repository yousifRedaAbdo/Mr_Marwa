class TeacherDataModel {
  TeacherDataModel({
    required this.teacher,
  });

  late final Teacher teacher;

  TeacherDataModel.fromJson(Map<String, dynamic> json) {
    teacher = Teacher.fromJson(json['teacher']);
  }
}

class Teacher {
  Teacher({
    required this.id,
    required this.auth,
    required this.confirmed,
    required this.policyagreed,
    required this.deleted,
    required this.suspended,
    required this.mnethostid,
    required this.username,
    required this.password,
    required this.idnumber,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.emailstop,
    required this.phone1,
    required this.phone2,
    required this.institution,
    required this.department,
    required this.address,
    required this.city,
    required this.country,
    required this.lang,
    required this.calendartype,
    required this.theme,
    required this.timezone,
    required this.firstaccess,
    required this.lastaccess,
    required this.lastlogin,
    required this.currentlogin,
    required this.lastip,
    required this.secret,
    required this.picture,
    required this.description,
    required this.descriptionformat,
    required this.mailformat,
    required this.maildigest,
    required this.maildisplay,
    required this.autosubscribe,
    required this.trackforums,
    required this.timecreated,
    required this.timemodified,
    required this.trustbitmask,
    required this.imagealt,
    required this.lastnamephonetic,
    required this.firstnamephonetic,
    required this.middlename,
    required this.alternatename,
    required this.bio,
    required this.enrolled,
    required this.courses,
    required this.feedbacks,
    required this.photos,
    required this.videos,
    required this.rating,
  });

  late final String id;
  late final String auth;
  late final String confirmed;
  late final String policyagreed;
  late final String deleted;
  late final String suspended;
  late final String mnethostid;
  late final String username;
  late final String password;
  late final String idnumber;
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String emailstop;
  late final String phone1;
  late final String phone2;
  late final String institution;
  late final String department;
  late final String address;
  late final String city;
  late final String country;
  late final String lang;
  late final String calendartype;
  late final String theme;
  late final String timezone;
  late final String firstaccess;
  late final String lastaccess;
  late final String lastlogin;
  late final String currentlogin;
  late final String lastip;
  late final String secret;
  late final String picture;
  late final String description;
  late final String descriptionformat;
  late final String mailformat;
  late final String maildigest;
  late final String maildisplay;
  late final String autosubscribe;
  late final String trackforums;
  late final String timecreated;
  late final String timemodified;
  late final String trustbitmask;
  late final String imagealt;
  late final String lastnamephonetic;
  late final String firstnamephonetic;
  late final String middlename;
  late final String alternatename;
  late final String bio;
  late final String enrolled;
  late final List<Courses> courses;
  late final List<Feedbacks> feedbacks;
  late final List<Photos> photos;
  late final List<Videos> videos;
  late final String rating;

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auth = json['auth'];
    confirmed = json['confirmed'];
    policyagreed = json['policyagreed'];
    deleted = json['deleted'];
    suspended = json['suspended'];
    mnethostid = json['mnethostid'];
    username = json['username'];
    password = json['password'];
    idnumber = json['idnumber'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    emailstop = json['emailstop'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    institution = json['institution'];
    department = json['department'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    lang = json['lang'];
    calendartype = json['calendartype'];
    theme = json['theme'];
    timezone = json['timezone'];
    firstaccess = json['firstaccess'];
    lastaccess = json['lastaccess'];
    lastlogin = json['lastlogin'];
    currentlogin = json['currentlogin'];
    lastip = json['lastip'];
    secret = json['secret'];
    picture = json['picture'];
    description = json['description'];
    descriptionformat = json['descriptionformat'];
    mailformat = json['mailformat'];
    maildigest = json['maildigest'];
    maildisplay = json['maildisplay'];
    autosubscribe = json['autosubscribe'];
    trackforums = json['trackforums'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    trustbitmask = json['trustbitmask'];
    imagealt = json['imagealt'];
    lastnamephonetic = json['lastnamephonetic'];
    firstnamephonetic = json['firstnamephonetic'];
    middlename = json['middlename'];
    alternatename = json['alternatename'];
    bio = json['bio'];
    enrolled = json['enrolled'];
    courses =
        List.from(json['courses']).map((e) => Courses.fromJson(e)).toList();
    feedbacks =
        List.from(json['feedbacks']).map((e) => Feedbacks.fromJson(e)).toList();
    photos = List.from(json['photos']).map((e) => Photos.fromJson(e)).toList();
    videos = List.from(json['videos']).map((e) => Videos.fromJson(e)).toList();
    rating = json['rating'] ?? '0';
  }
}

class Courses {
  Courses({
    required this.id,
    required this.category,
    required this.sortorder,
    required this.shortname,
    required this.fullname,
    required this.idnumber,
    required this.startdate,
    required this.visible,
    required this.defaultgroupingid,
    required this.groupmode,
    required this.groupmodeforce,
    required this.overviewfiles,
    required this.contacts,
  });

  late final String id;
  late final String category;
  late final String sortorder;
  late final String shortname;
  late final String fullname;
  late final String idnumber;
  late final String startdate;
  late final String visible;
  late final String defaultgroupingid;
  late final String groupmode;
  late final String groupmodeforce;
  late final List<Overviewfiles> overviewfiles;
  late final List<Contacts> contacts;

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    sortorder = json['sortorder'];
    shortname = json['shortname'];
    fullname = json['fullname'];
    idnumber = json['idnumber'];
    startdate = json['startdate'];
    visible = json['visible'];
    defaultgroupingid = json['defaultgroupingid'];
    groupmode = json['groupmode'];
    groupmodeforce = json['groupmodeforce'];
    overviewfiles = List.from(json['overviewfiles'])
        .map((e) => Overviewfiles.fromJson(e))
        .toList();
    contacts =
        List.from(json['contacts']).map((e) => Contacts.fromJson(e)).toList();
  }
}

class Overviewfiles {
  Overviewfiles({
    required this.filename,
    required this.fileurl,
    required this.filesize,
    required this.filepath,
    required this.mimetype,
    required this.timemodified,
  });

  late final String filename;
  late final String fileurl;
  late final String filesize;
  late final String filepath;
  late final String mimetype;
  late final String timemodified;

  Overviewfiles.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    fileurl = json['fileurl'];
    filesize = json['filesize'];
    filepath = json['filepath'];
    mimetype = json['mimetype'];
    timemodified = json['timemodified'];
  }
}

class Contacts {
  Contacts({
    required this.id,
    required this.fullname,
    required this.role,
    required this.rolename,
  });

  late final String id;
  late final String fullname;

  late final Role role;
  late final String rolename;

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];

    role = Role.fromJson(json['role']);
    rolename = json['rolename'];
  }
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  late final String id;
  late final String name;

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Feedbacks {
  Feedbacks({
    required this.id,
    required this.title,
    required this.feedback,
    required this.course,
    required this.user,
    required this.teacherId,
    required this.timecreated,
    required this.timemodified,
    required this.username,
    // required this.userimage,
  });

  late final String id;
  late final String title;
  late final String feedback;
  late final String course;
  late final String user;
  late final String teacherId;
  late final String timecreated;
  late final String timemodified;
  late final String username;
  // late final String userimage;

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    feedback = json['feedback'];
    course = json['course'];
    user = json['user'];
    teacherId = json['teacher_id'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    username = json['username'];
    // userimage = json['userimage'];
  }
}

class Photos {
  Photos({
    required this.id,
    required this.teacherId,
    required this.photos,
    required this.timecreated,
    required this.timemodified,
  });

  late final String id;
  late final String teacherId;
  late final String photos;
  late final String timecreated;
  late final String timemodified;

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'],
      teacherId: json['teacher_id'],
      photos:
      'https://academy2022.nitg-eg.com//theme/edumy/images/teachers/${json['photos']}',
      timecreated: json['timecreated'],
      timemodified: json['timemodified'],
    );
  }
}

class Videos {
  Videos({
    required this.id,
    required this.teacherId,
    required this.description,
    required this.name,
    required this.output,
    required this.timecreated,
    required this.timemodified,
  });

  late final String id;
  late final String teacherId;
  late final String description;
  late final String name;
  late final String output;
  late final String timecreated;
  late final String timemodified;

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    description = json['description'];
    name = json['name'];
    output = json['output'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
  }
}
