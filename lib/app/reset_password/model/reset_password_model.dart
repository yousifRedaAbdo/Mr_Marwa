class ResetPasswordModel {
  String? status;
  String? message;
  String? error;

  ResetPasswordModel({this.status, this.message, this.error});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
