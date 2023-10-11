class DeleteImageModel {
  DeleteImageModel({
    required this.status,
    required this.data,
    required this.error,
  });
  late final String status;
  late final String data;
  late final String error;

  DeleteImageModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data;
    _data['error'] = error;
    return _data;
  }
}