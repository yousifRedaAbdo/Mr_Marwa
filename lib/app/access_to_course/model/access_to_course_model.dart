class AccessToCourseModel {
  AccessToCourseModel({
    required this.state,
    required this.viewed,
    required this.notViewed,
  });
  late final String state;
  late final List<Viewed> viewed;
  late final List<NotViewed> notViewed;

  AccessToCourseModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    viewed = List.from(json['viewed']).map((e) => Viewed.fromJson(e)).toList();
    notViewed =
        List.from(json['notViewed']).map((e) => NotViewed.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['state'] = state;
    _data['viewed'] = viewed.map((e) => e.toJson()).toList();
    _data['notViewed'] = notViewed.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Viewed {
  Viewed({
    required this.id,
    required this.name,
    required this.lastaccess,
    required this.centername,
  });
  late final String id;
  late final String name;
  late final String lastaccess;
  late final String centername;

  Viewed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastaccess = json['lastaccess'];
    centername = json['centername'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['lastaccess'] = lastaccess;
    _data['centername'] = centername;
    return _data;
  }
}

class NotViewed {
  NotViewed({
    required this.id,
    required this.name,
    required this.lastaccess,
    required this.centername,
  });
  late final String id;
  late final String name;
  late final String lastaccess;
  late final String centername;

  NotViewed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastaccess = json['lastaccess'] == '0' ? 'not access yet' : json['lastaccess'];
    centername = json['centername'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['lastaccess'] = lastaccess;
    _data['centername'] = centername;
    return _data;
  }
}
