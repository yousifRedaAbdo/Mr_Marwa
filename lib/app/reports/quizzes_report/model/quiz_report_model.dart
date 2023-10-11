class QuizzesReportModel {
  QuizzesReportModel({
    required this.data,
  });
  late final List<Data> data;

  QuizzesReportModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.course,
    required this.name,
    required this.intro,
    required this.introformat,
    required this.timeopen,
    required this.timeclose,
    required this.timelimit,
    required this.overduehandling,
    required this.graceperiod,
    required this.preferredbehaviour,
    required this.canredoquestions,
    required this.attempts,
    required this.attemptonlast,
    required this.grademethod,
    required this.decimalpoints,
    required this.questiondecimalpoints,
    required this.reviewattempt,
    required this.reviewcorrectness,
    required this.reviewmarks,
    required this.reviewspecificfeedback,
    required this.reviewgeneralfeedback,
    required this.reviewrightanswer,
    required this.reviewoverallfeedback,
    required this.questionsperpage,
    required this.navmethod,
    required this.shuffleanswers,
    required this.sumgrades,
    required this.grade,
    required this.timecreated,
    required this.timemodified,
    required this.password,
    required this.subnet,
    required this.browsersecurity,
    required this.delay1,
    required this.delay2,
    required this.showuserpicture,
    required this.showblocks,
    required this.completionattemptsexhausted,
    required this.completionpass,
    required this.allowofflineattempts,
  });
  late final String id;
  late final String course;
  late final String name;
  late final String intro;
  late final String introformat;
  late final String timeopen;
  late final String timeclose;
  late final String timelimit;
  late final String overduehandling;
  late final String graceperiod;
  late final String preferredbehaviour;
  late final String canredoquestions;
  late final String attempts;
  late final String attemptonlast;
  late final String grademethod;
  late final String decimalpoints;
  late final String questiondecimalpoints;
  late final String reviewattempt;
  late final String reviewcorrectness;
  late final String reviewmarks;
  late final String reviewspecificfeedback;
  late final String reviewgeneralfeedback;
  late final String reviewrightanswer;
  late final String reviewoverallfeedback;
  late final String questionsperpage;
  late final String navmethod;
  late final String shuffleanswers;
  late final String sumgrades;
  late final String grade;
  late final String timecreated;
  late final String timemodified;
  late final String password;
  late final String subnet;
  late final String browsersecurity;
  late final String delay1;
  late final String delay2;
  late final String showuserpicture;
  late final String showblocks;
  late final String completionattemptsexhausted;
  late final String completionpass;
  late final String allowofflineattempts;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    course = json['course'];
    name = json['name'];
    intro = json['intro'];
    introformat = json['introformat'];
    timeopen = json['timeopen'];
    timeclose = json['timeclose'];
    timelimit = json['timelimit'];
    overduehandling = json['overduehandling'];
    graceperiod = json['graceperiod'];
    preferredbehaviour = json['preferredbehaviour'];
    canredoquestions = json['canredoquestions'];
    attempts = json['attempts'];
    attemptonlast = json['attemptonlast'];
    grademethod = json['grademethod'];
    decimalpoints = json['decimalpoints'];
    questiondecimalpoints = json['questiondecimalpoints'];
    reviewattempt = json['reviewattempt'];
    reviewcorrectness = json['reviewcorrectness'];
    reviewmarks = json['reviewmarks'];
    reviewspecificfeedback = json['reviewspecificfeedback'];
    reviewgeneralfeedback = json['reviewgeneralfeedback'];
    reviewrightanswer = json['reviewrightanswer'];
    reviewoverallfeedback = json['reviewoverallfeedback'];
    questionsperpage = json['questionsperpage'];
    navmethod = json['navmethod'];
    shuffleanswers = json['shuffleanswers'];
    sumgrades = json['sumgrades'];
    grade = json['grade'];
    timecreated = json['timecreated'];
    timemodified = json['timemodified'];
    password = json['password'];
    subnet = json['subnet'];
    browsersecurity = json['browsersecurity'];
    delay1 = json['delay1'];
    delay2 = json['delay2'];
    showuserpicture = json['showuserpicture'];
    showblocks = json['showblocks'];
    completionattemptsexhausted = json['completionattemptsexhausted'];
    completionpass = json['completionpass'];
    allowofflineattempts = json['allowofflineattempts'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['course'] = course;
    _data['name'] = name;
    _data['intro'] = intro;
    _data['introformat'] = introformat;
    _data['timeopen'] = timeopen;
    _data['timeclose'] = timeclose;
    _data['timelimit'] = timelimit;
    _data['overduehandling'] = overduehandling;
    _data['graceperiod'] = graceperiod;
    _data['preferredbehaviour'] = preferredbehaviour;
    _data['canredoquestions'] = canredoquestions;
    _data['attempts'] = attempts;
    _data['attemptonlast'] = attemptonlast;
    _data['grademethod'] = grademethod;
    _data['decimalpoints'] = decimalpoints;
    _data['questiondecimalpoints'] = questiondecimalpoints;
    _data['reviewattempt'] = reviewattempt;
    _data['reviewcorrectness'] = reviewcorrectness;
    _data['reviewmarks'] = reviewmarks;
    _data['reviewspecificfeedback'] = reviewspecificfeedback;
    _data['reviewgeneralfeedback'] = reviewgeneralfeedback;
    _data['reviewrightanswer'] = reviewrightanswer;
    _data['reviewoverallfeedback'] = reviewoverallfeedback;
    _data['questionsperpage'] = questionsperpage;
    _data['navmethod'] = navmethod;
    _data['shuffleanswers'] = shuffleanswers;
    _data['sumgrades'] = sumgrades;
    _data['grade'] = grade;
    _data['timecreated'] = timecreated;
    _data['timemodified'] = timemodified;
    _data['password'] = password;
    _data['subnet'] = subnet;
    _data['browsersecurity'] = browsersecurity;
    _data['delay1'] = delay1;
    _data['delay2'] = delay2;
    _data['showuserpicture'] = showuserpicture;
    _data['showblocks'] = showblocks;
    _data['completionattemptsexhausted'] = completionattemptsexhausted;
    _data['completionpass'] = completionpass;
    _data['allowofflineattempts'] = allowofflineattempts;
    return _data;
  }
}