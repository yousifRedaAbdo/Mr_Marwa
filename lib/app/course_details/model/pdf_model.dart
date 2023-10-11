
class PDFModel {
  Data? data;

  PDFModel({required this.data});

  PDFModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
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
  Contentsinfo? contentsinfo;
  List<ForPDF>? forPDF;
  List<String>? availMessage;

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
        this.completion,
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
        this.contentsinfo,
        this.forPDF,
        this.availMessage});

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

    contentsinfo = json['contentsinfo'] != null
        ? Contentsinfo.fromJson(json['contentsinfo'])
        : null;
    if (json['contents'] != null) {
      forPDF = <ForPDF>[];
      json['contents'].forEach((v) {
        forPDF!.add(ForPDF.fromJson(v));
      });
    }
  }
}

class Contentsinfo {
  int? filescount;
  int? filessize;
  int? lastmodified;
  List<Null>? mimetypes;
  String? repositorytype;

  Contentsinfo(
      {this.filescount,
        this.filessize,
        this.lastmodified,
        this.mimetypes,
        this.repositorytype});

  Contentsinfo.fromJson(Map<String, dynamic> json) {
    filescount = json['filescount'];
    filessize = json['filessize'];

    repositorytype = json['repositorytype'];
  }
}

class ForPDF {
  String? type;
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  String? timecreated;
  String? timemodified;
  int? sortorder;
  String? userid;
  String? author;
  String? license;
  String? mimetype;
  bool? isexternalfile;

  ForPDF({
    this.fileurl,
    this.filename,
  });

  ForPDF.fromJson(Map<String, dynamic> json) {
    fileurl = json['fileurl'];
    filename = json['filename'];
  }
}