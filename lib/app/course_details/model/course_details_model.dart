class CourseDetailsModel {
  Data? data;

  CourseDetailsModel({this.data});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? courseid;
  String? coursename;
  String? free;
  String? requirements;
  String? forwhom;
  String? benefits;
  String? language;
  String? certificate;
  List<Null>? objectives;
  String? description;
  String? price;
  String? views;
  String? allenrolusers;
  int? activitiesCount;
  String? teacherId;
  String? teacherName;
  String? teacherBio;
  String? duration;
  String? promo;
  String? courseRate;
  String? teacherImage;
  String? enrol;
  String? assistant;
  List<Contents>? contents;

  Data(
      {this.courseid,
      this.coursename,
      this.free,
      this.requirements,
      this.forwhom,
      this.benefits,
      this.language,
      this.certificate,
      this.objectives,
      this.description,
      this.price,
      this.views,
      this.allenrolusers,
      this.activitiesCount,
      this.teacherId,
      this.teacherName,
      this.teacherBio,
      this.duration,
      this.promo,
      this.courseRate,
      this.teacherImage,
      this.enrol,
      this.assistant,
      this.contents});

  Data.fromJson(Map<String, dynamic> json) {
    courseid = json['courseid'];
    coursename = json['coursename'];
    free = json['free'];
    requirements = json['requirements'];
    forwhom = json['forwhom'];
    benefits = json['benefits'];
    language = json['language'];
    certificate = json['certificate'];
    description = json['description'];
    price = json['price'];
    views = json['views'];
    allenrolusers = json['allenrolusers'];
    activitiesCount = json['activitiesCount'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    teacherBio = json['teacherBio'];
    duration = json['duration'];
    promo = json['promo'];
    courseRate = json['courseRate'];
    teacherImage = json['teacherImage'];
    enrol = json['enrol'];
    assistant = json['assistant'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }
}

class Contents {
  String? id;
  String? name;
  String? visible;
  String? summary;
  String? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;
  List<Modules>? modules;

  Contents(
      {this.id,
      this.name,
      this.visible,
      this.summary,
      this.summaryformat,
      this.section,
      this.hiddenbynumsections,
      this.uservisible,
      this.modules});

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visible = json['visible'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    section = json['section'];
    hiddenbynumsections = json['hiddenbynumsections'];
    uservisible = json['uservisible'];
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }
}

class Modules {
  String? id;
  String? name;
  String? instance;
  String? modname;
  String? modplural;
  String? modicon;
  String? onclick;
  Null? afterlink;
  String? customdata;
  int? completion;
  bool? noviewlink;
  String? paid;
  bool? avail;
  String? quizType;
  String? resourceType;
  String? pageUrl;
  String? url;
  String? visible;
  int? visibleoncoursepage;
  bool? uservisible;
  String? availability;
  Completiondata? completiondata;
  String? availMessage;
  Contentsinfo? contentsinfo;
  List<ContentsCustom>? contents;

  Modules(
      {this.id,
      this.name,
      this.instance,
      this.modname,
      this.modplural,
      this.modicon,
      this.onclick,
      this.afterlink,
      this.customdata,
      this.noviewlink,
      this.paid,
      this.avail,
      this.quizType,
      this.resourceType,
      this.pageUrl,
      this.url,
      this.visible,
      this.visibleoncoursepage,
      this.uservisible,
      this.availability,
      this.completiondata,
      this.availMessage,
      this.contentsinfo,
      this.contents});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    instance = json['instance'];
    modname = json['modname'];
    modplural = json['modplural'];
    modicon = json['modicon'];
    onclick = json['onclick'];
    afterlink = json['afterlink'];
    customdata = json['customdata'];

    noviewlink = json['noviewlink'];
    paid = json['paid'];
    avail = json['avail'];
    quizType = json['quiz_type'];
    resourceType = json['resource_type'];
    pageUrl = json['page_url'];
    url = json['url'];
    visible = json['visible'];
    visibleoncoursepage = json['visibleoncoursepage'];
    uservisible = json['uservisible'];
    availability = json['availability'];
    completiondata = json['completiondata'] != null
        ? Completiondata.fromJson(json['completiondata'])
        : null;
    availMessage = json['avail_message'];
    contentsinfo = json['contentsinfo'] != null
        ? Contentsinfo.fromJson(json['contentsinfo'])
        : null;
    if (json['contents'] != null) {
      contents = <ContentsCustom>[];
      json['contents'].forEach((v) {
        contents!.add(ContentsCustom.fromJson(v));
      });
    }
  }
}

class Completiondata {
  String? state;
  String? timecompleted;
  Null? overrideby;
  bool? valueused;

  Completiondata(
      {this.state, this.timecompleted, this.overrideby, this.valueused});

  Completiondata.fromJson(Map<String, dynamic> json) {
    // state = json['state'];
    // timecompleted = json['timecompleted'];
    // overrideby = json['overrideby'];
    // valueused = json['valueused'];
  }
}

class Contentsinfo {
  int? filescount;
  int? filessize;
  String? lastmodified;
  String? repositorytype;

  Contentsinfo(
      {required this.filescount,
      required this.filessize,
      required this.lastmodified,
      required this.repositorytype});

  factory Contentsinfo.fromJson(Map<String, dynamic> json) {
    return Contentsinfo(
      filescount: int.parse(json['filescount'].toString()),
      filessize: int.parse(json['filessize'].toString()),
      lastmodified: json['lastmodified'].toString(),
      repositorytype: json['repositorytype'].toString(),
    );
  }
}

class ContentsCustom {
  String? type;
  String? filename;
  String? filepath;
  String? filesize;
  String? fileurl;
  String? timecreated;
  String? timemodified;
  String? sortorder;
  String? userid;
  String? author;
  String? license;
  String? mimetype;
  bool? isexternalfile;

  ContentsCustom(
      {required this.type,
      required this.filename,
      required this.filepath,
      required this.filesize,
      required this.fileurl,
      required this.timecreated,
      required this.timemodified,
      required this.sortorder,
      required this.userid,
      required this.author,
      required this.license,
      required this.mimetype,
      required this.isexternalfile});

  factory ContentsCustom.fromJson(Map<String, dynamic> json) {
    return ContentsCustom(
      type: json['type'].toString(),
      filename: json['filename'].toString(),
      filepath: json['filepath'].toString(),
      filesize: json['filesize'].toString(),
      fileurl: json['fileurl'].toString(),
      timecreated: json['timecreated'].toString(),
      timemodified: json['timemodified'].toString(),
      sortorder: json['sortorder'].toString(),
      userid: json['userid'].toString(),
      author: json['author'].toString(),
      license: json['license'].toString(),
      mimetype: json['mimetype'].toString(),
      isexternalfile: json['isexternalfile'],
    );
  }
}

// class CourseDetailsModel {
//   CourseDetailsModel({
//     required this.data,
//   });
//
//   late final Data data;
//
//   CourseDetailsModel.fromJson(Map<String, dynamic> json) {
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.courseid,
//     required this.coursename,
//     required this.free,
//     required this.requirements,
//     required this.forwhom,
//     required this.benefits,
//     required this.language,
//     required this.certificate,
//     required this.objectives,
//     required this.description,
//     required this.price,
//     required this.views,
//     required this.allenrolusers,
//     required this.activitiesCount,
//     required this.teacherId,
//     required this.teacherName,
//     required this.teacherBio,
//     required this.duration,
//     required this.promo,
//     required this.courseRate,
//     required this.teacherImage,
//     required this.enrol,
//     required this.assistant,
//     required this.contents,
//   });
//
//   late final int courseid;
//   late final String coursename;
//   late final String free;
//   late final String requirements;
//   late final String forwhom;
//   late final String benefits;
//   late final String language;
//   late final String certificate;
//   late final List<dynamic> objectives;
//   late final String description;
//   late final String price;
//   late final String views;
//   late final String allenrolusers;
//   late final int activitiesCount;
//   late final String teacherId;
//   late final String teacherName;
//   late final String teacherBio;
//   late final String duration;
//   late final String promo;
//   late final String courseRate;
//   late final String teacherImage;
//   late final String enrol;
//   late final String assistant;
//   late final List<Contents> contents;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     courseid = json['courseid'];
//     coursename = json['coursename'];
//     free = json['free'];
//     requirements = json['requirements'];
//     forwhom = json['forwhom'];
//     benefits = json['benefits'];
//     language = json['language'];
//     certificate = json['certificate'];
//     objectives = List.castFrom<dynamic, dynamic>(json['objectives']);
//     description = json['description'];
//     price = json['price'];
//     views = json['views'];
//     allenrolusers = json['allenrolusers'];
//     activitiesCount = json['activitiesCount'];
//     teacherId = json['teacherId'];
//     teacherName = json['teacherName'];
//     teacherBio = json['teacherBio'];
//     duration = json['duration'];
//     promo = json['promo'];
//     courseRate = json['courseRate'];
//     teacherImage = json['teacherImage'];
//     enrol = json['enrol'];
//     assistant = json['assistant'];
//     contents =
//         List.from(json['contents']).map((e) => Contents.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['courseid'] = courseid;
//     _data['coursename'] = coursename;
//     _data['free'] = free;
//     _data['requirements'] = requirements;
//     _data['forwhom'] = forwhom;
//     _data['benefits'] = benefits;
//     _data['language'] = language;
//     _data['certificate'] = certificate;
//     _data['objectives'] = objectives;
//     _data['description'] = description;
//     _data['price'] = price;
//     _data['views'] = views;
//     _data['allenrolusers'] = allenrolusers;
//     _data['activitiesCount'] = activitiesCount;
//     _data['teacherId'] = teacherId;
//     _data['teacherName'] = teacherName;
//     _data['teacherBio'] = teacherBio;
//     _data['duration'] = duration;
//     _data['promo'] = promo;
//     _data['courseRate'] = courseRate;
//     _data['teacherImage'] = teacherImage;
//     _data['enrol'] = enrol;
//     _data['assistant'] = assistant;
//     _data['contents'] = contents.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Contents {
//   Contents({
//     required this.id,
//     required this.name,
//     required this.visible,
//     required this.summary,
//     required this.summaryformat,
//     required this.section,
//     required this.hiddenbynumsections,
//     required this.uservisible,
//     required this.modules,
//   });
//
//   late final String id;
//   late final String name;
//   late final String visible;
//   late final String summary;
//   late final String summaryformat;
//   late final int section;
//   late final int hiddenbynumsections;
//   late final bool uservisible;
//   late final List<Modules> modules;
//
//   Contents.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     visible = json['visible'];
//     summary = json['summary'];
//     summaryformat = json['summaryformat'];
//     section = json['section'];
//     hiddenbynumsections = json['hiddenbynumsections'];
//     uservisible = json['uservisible'];
//     modules =
//         List.from(json['modules']).map((e) => Modules.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['visible'] = visible;
//     _data['summary'] = summary;
//     _data['summaryformat'] = summaryformat;
//     _data['section'] = section;
//     _data['hiddenbynumsections'] = hiddenbynumsections;
//     _data['uservisible'] = uservisible;
//     _data['modules'] = modules.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Modules {
//   Modules({
//     required this.id,
//     required this.name,
//     required this.instance,
//     required this.modname,
//     required this.modplural,
//     required this.modicon,
//     required this.indent,
//     required this.onclick,
//     this.afterlink,
//     required this.customdata,
//     required this.completion,
//     required this.noviewlink,
//     required this.paid,
//     required this.avail,
//     required this.quizType,
//     required this.resourceType,
//     required this.url,
//     required this.visible,
//     required this.visibleoncoursepage,
//     required this.uservisible,
//     this.availability,
//   });
//
//   late final String id;
//   late final String name;
//   late final String instance;
//   late final String modname;
//   late final String modplural;
//   late final String modicon;
//   late final int indent;
//   late final String onclick;
//   late final Null afterlink;
//   late final String customdata;
//   late final int? completion;
//   late final bool noviewlink;
//   late final String paid;
//   late final bool avail;
//   late final String quizType;
//   late final String resourceType;
//   late final String? url;
//   late final String? visible;
//   late final int? visibleoncoursepage;
//   late final bool? uservisible;
//   late final bool? availability;
//
//   factory Modules.fromJson(Map<String, dynamic> json) {
//     return Modules(
//       id: json['id'],
//       name: json['name'],
//       instance: json['instance'],
//       modname: json['modname'],
//       modplural: json['modplural'],
//       modicon: json['modicon'],
//       indent: json['indent'],
//       onclick: json['onclick'],
//       customdata: json['customdata'],
//       completion: int.parse(json['completion'].toString()),
//       noviewlink: json['noviewlink'],
//       paid: json['paid'],
//       avail: json['avail'],
//       url: json['url'],
//       visible: json['visible'],
//       visibleoncoursepage: json['visibleoncoursepage'],
//       uservisible: json['uservisible'],
//       resourceType: json['resource_type'],
//       quizType: json['quiz_type'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['instance'] = instance;
//     _data['modname'] = modname;
//     _data['modplural'] = modplural;
//     _data['modicon'] = modicon;
//     _data['indent'] = indent;
//     _data['onclick'] = onclick;
//     _data['afterlink'] = afterlink;
//     _data['customdata'] = customdata;
//     _data['completion'] = completion;
//     _data['noviewlink'] = noviewlink;
//     _data['paid'] = paid;
//     _data['avail'] = avail;
//     _data['quiz_type'] = quizType;
//     _data['resource_type'] = resourceType;
//     _data['url'] = url;
//     _data['visible'] = visible;
//     _data['visibleoncoursepage'] = visibleoncoursepage;
//     _data['uservisible'] = uservisible;
//     _data['availability'] = availability;
//     return _data;
//   }
// }
//
// class Url {
//   Url({
//     required this.state,
//     required this.timecompleted,
//     this.overrideby,
//     required this.valueused,
//   });
//
//   late final String? state;
//   late final String? timecompleted;
//   late final Null overrideby;
//   late final bool valueused;
//
//   Url.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     timecompleted = json['timecompleted'];
//     overrideby = null;
//     valueused = json['valueused'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['state'] = state;
//     _data['timecompleted'] = timecompleted;
//     _data['overrideby'] = overrideby;
//     _data['valueused'] = valueused;
//     return _data;
//   }
// }
//
// class Visible {
//   Visible({
//     required this.state,
//     required this.timecompleted,
//     this.overrideby,
//     required this.valueused,
//   });
//
//   late final int state;
//   late final int timecompleted;
//   late final Null overrideby;
//   late final bool valueused;
//
//   Visible.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     timecompleted = json['timecompleted'];
//     overrideby = null;
//     valueused = json['valueused'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['state'] = state;
//     _data['timecompleted'] = timecompleted;
//     _data['overrideby'] = overrideby;
//     _data['valueused'] = valueused;
//     return _data;
//   }
// }
