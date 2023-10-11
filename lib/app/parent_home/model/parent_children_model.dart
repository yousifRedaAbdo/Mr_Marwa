import 'package:mrs_marwa/utils/strings.dart';

class ParentChildrenModel {
  ParentChildrenModel({
    required this.status,
    required this.data,
    required this.error,
  });

  late final String status;
  late final List<Data> data;
  late final String error;

  ParentChildrenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
  }
}

class Data {
  Data({
    required this.childid,
    required this.firstname,
    required this.lastname,
    required this.url,
  });

  late final String childid;
  late final String firstname;
  late final String lastname;
  late final String url;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      childid: json['childid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      url: json['url'] == '' ? defaultImage : json['url'],
    );
  }
}
