class UploadImageModel {
  UploadImageModel({
    required this.status,
    required this.data,
    required this.error,
  });

  late final String status;
  late final String data;
  late final String error;

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    error = json['error'];
  }
}
