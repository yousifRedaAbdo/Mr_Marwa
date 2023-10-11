class ActivityAvailabilityModel {
  ActivityAvailabilityModel({
    required this.flag,
    required this.data,
  });

  late final bool flag;
  late final String data;

  ActivityAvailabilityModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'] ?? false;
    data = json['data'] ?? '';
  }
}
