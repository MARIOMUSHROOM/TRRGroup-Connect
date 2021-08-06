import 'package:flutter/material.dart';

class LocalNotificationModel {
  int notificatioID;
  int typeID;
  String typeText;
  String image;
  String message;
  DateTime date;
  String dateString;
  bool read;
  dynamic routeName;
  Widget Function(BuildContext) builderRoute;
}
