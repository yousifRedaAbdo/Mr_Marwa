import 'package:flutter/material.dart';

import '../routs/routing_data.dart';


extension WidgetExtension on Widget? {
  /// add tap to parent widget
  Widget onTap(
    Function? function, {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(0)),
    Color? splashColor,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: borderRadius,
      child: this,
      splashColor: splashColor,
    );
  }
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
