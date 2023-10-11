class ChildCoursesForParentModel {
  ChildCoursesForParentModel({
    required this.courses,
  });
  late final List<Courses> courses;

  ChildCoursesForParentModel.fromJson(Map<String, dynamic> json){
    courses = List.from(json['courses']).map((e)=>Courses.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['courses'] = courses.map((e)=>e.toJson()).toList();
    return _data;
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

  Courses.fromJson(Map<String, dynamic> json){
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
    overviewfiles = List.from(json['overviewfiles']).map((e)=>Overviewfiles.fromJson(e)).toList();
    contacts = List.from(json['contacts']).map((e)=>Contacts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category'] = category;
    _data['sortorder'] = sortorder;
    _data['shortname'] = shortname;
    _data['fullname'] = fullname;
    _data['idnumber'] = idnumber;
    _data['startdate'] = startdate;
    _data['visible'] = visible;
    _data['defaultgroupingid'] = defaultgroupingid;
    _data['groupmode'] = groupmode;
    _data['groupmodeforce'] = groupmodeforce;
    _data['overviewfiles'] = overviewfiles.map((e)=>e.toJson()).toList();
    _data['contacts'] = contacts.map((e)=>e.toJson()).toList();
    return _data;
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

  Overviewfiles.fromJson(Map<String, dynamic> json){
    filename = json['filename'];
    fileurl = json['fileurl'];
    filesize = json['filesize'];
    filepath = json['filepath'];
    mimetype = json['mimetype'];
    timemodified = json['timemodified'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['filename'] = filename;
    _data['fileurl'] = fileurl;
    _data['filesize'] = filesize;
    _data['filepath'] = filepath;
    _data['mimetype'] = mimetype;
    _data['timemodified'] = timemodified;
    return _data;
  }
}

class Contacts {
  Contacts({
    required this.id,
    required this.fullname,
    required this.rolename,
  });
  late final String id;
  late final String fullname;
  late final String rolename;

  Contacts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullname = json['fullname'];
    rolename = json['rolename'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullname'] = fullname;
    _data['rolename'] = rolename;
    return _data;
  }
}