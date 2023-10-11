class AuthModel {
  String? status;
  Data? data;
  String? error;

  AuthModel({required this.status, required this.data, required this.error});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class Data {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? token;
  String? email;
  String? role;
  int? year;
  String? phone;
  String? phone2;
  String? city;
  String? school;
  String? center;

  Data({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.token,
    required this.email,
    required this.role,
    required this.year,
    required this.phone,
    required this.phone2,
    required this.city,
    required this.school,
    required this.center,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    token = json['token'] ?? '';
    email = json['email'];
    role = json['role'];
    year = json['year'];
    phone = json['phone'];
    phone2 = json['phone2'];
    city = json['city'];
    school = json['school'];
    center = json['center'];
  }
}
