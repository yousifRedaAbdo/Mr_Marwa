class PdfReportModel {
  PdfReportModel({
    required this.data,
  });

  late final List<Data> data;

  PdfReportModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] == null
        ? []
        : List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
  });

  late final String id;
  late final String name;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
  }
}
