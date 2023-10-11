class FinalCourseContentMobileModel {
  Data? data;

  FinalCourseContentMobileModel({this.data});

  FinalCourseContentMobileModel.fromJson(Map<String, dynamic> json) {
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
  List<Objectives>? objectives;
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
    if (json['objectives'] != null) {
      objectives = <Objectives>[];
      json['objectives'].forEach((v) {
        objectives!.add(Objectives.fromJson(v));
      });
    }
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

class Objectives {
  String? value;

  Objectives({this.value});

  Objectives.fromJson(Map<String, dynamic> json) {
    value = json['value'];
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
  int? indent;
  String? onclick;
  Null? afterlink;
  String? customdata;
  bool? noviewlink;
  String? paid;
  bool? avail;
  String? quizType;
  String? elementResourceType;
  String? pageUrl;
  String? url;
  String? visible;
  int? visibleoncoursepage;
  bool? uservisible;
  Completiondata? completiondata;
  Contentsinfo? contentsinfo;
  List<Content>? content;
  String? availMessage;

  Modules(
      {this.id,
      this.name,
      this.instance,
      this.modname,
      this.modplural,
      this.modicon,
      this.indent,
      this.onclick,
      this.afterlink,
      this.customdata,
      this.noviewlink,
      this.paid,
      this.avail,
      this.quizType,
      this.elementResourceType,
      this.pageUrl,
      this.url,
      this.visible,
      this.visibleoncoursepage,
      this.uservisible,
      this.completiondata,
      this.contentsinfo,
      this.content,
      this.availMessage});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    instance = json['instance'];
    modname = json['modname'];
    modplural = json['modplural'];
    modicon = json['modicon'];
    indent = json['indent'];
    onclick = json['onclick'];
    afterlink = json['afterlink'];
    customdata = json['customdata'];
    noviewlink = json['noviewlink'];
    paid = json['paid'];
    avail = json['avail'];
    quizType = json['quiz_type'];
    elementResourceType = json['resource_type'];
    pageUrl = json['page_url'];
    url = json['url'];
    visible = json['visible'];
    visibleoncoursepage = json['visibleoncoursepage'];
    uservisible = json['uservisible'];
    completiondata = json['completiondata'] != null
        ? Completiondata.fromJson(json['completiondata'])
        : null;
    contentsinfo = json['contentsinfo'] != null
        ? Contentsinfo.fromJson(json['contentsinfo'])
        : null;
    if (json['contents'] != null) {
      content = <Content>[];
      json['contents'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
    availMessage = json['avail_message'];
  }
}

class Completiondata {
  int? state;
  int? timecompleted;

  bool? valueused;

  Completiondata({
    this.state,
    this.timecompleted,
    this.valueused,
  });

  Completiondata.fromJson(Map<String, dynamic> json) {
    state = int.parse(json['state'].toString());
    timecompleted = int.parse(json['timecompleted'].toString());
    valueused = json['valueused'];
  }
}

class Contentsinfo {
  int? filescount;
  int? filessize;
  String? repositorytype;

  Contentsinfo({
    this.filescount,
    this.filessize,
    this.repositorytype,
  });

  Contentsinfo.fromJson(Map<String, dynamic> json) {
    filescount = json['filescount'];
    filessize = json['filessize'];
    repositorytype = json['repositorytype'];
  }
}

class Mimetypes {
  String? applicationPdf;

  Mimetypes({this.applicationPdf});

  Mimetypes.fromJson(Map<String, dynamic> json) {
    applicationPdf = json['application/pdf'];
  }
}

class Content {
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

  Content({
    this.type,
    this.filename,
    this.filepath,
    this.filesize,
    this.fileurl,
    this.timecreated,
    this.timemodified,
    this.sortorder,
    this.userid,
    this.author,
    this.license,
    this.mimetype,
  });

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    filename = json['filename'];
    filepath = json['filepath'];
    filesize = json['filesize'].toString();
    fileurl = json['fileurl'];
    timecreated = json['timecreated'].toString();
    timemodified = json['timemodified'].toString();
    sortorder = json['sortorder'].toString();
    userid = json['userid'].toString();
    author = json['author'].toString();
    license = json['license'].toString();
    mimetype = json['mimetype'].toString();
  }
}
