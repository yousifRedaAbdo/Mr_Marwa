class PdfReportInDetailModel {
  PdfReportInDetailModel({
    required this.seenData,
    required this.notSeenData,
  });

  late final List<SeenData> seenData;
  late final List<NotSeenData> notSeenData;

  PdfReportInDetailModel.fromJson(Map<String, dynamic> json) {
    seenData = json['seenData'] == null
        ? []
        : List.from(json['seenData']).map((e) => SeenData.fromJson(e)).toList();

    notSeenData = json['notSeenData'] == null
        ? []
        : List.from(json['notSeenData'])
            .map((e) => NotSeenData.fromJson(e))
            .toList();
  }
}

class SeenData {
  SeenData({
    required this.userid,
    required this.name,
    required this.image,
    required this.views,
  });

  late final String userid;
  late final String name;
  late final String image;
  late final String views;

  SeenData.fromJson(Map<String, dynamic> json) {
    userid = json['userid'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    views = json['views'] ?? '';
  }
}

class NotSeenData {
  NotSeenData({
    required this.userid,
    required this.name,
    required this.image,
    required this.views,
  });

  late final String userid;
  late final String name;
  late final String image;
  late final int views;

  NotSeenData.fromJson(Map<String, dynamic> json) {
    userid = json['userid'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    views = json['views'] ?? '';
  }
}
