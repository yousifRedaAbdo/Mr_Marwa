
class UploadImagesModel {
  String? message;

  UploadImagesModel({this.message});

  UploadImagesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}