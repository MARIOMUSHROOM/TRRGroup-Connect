// To parse this JSON data, do
//
//     final fcmNotification = fcmNotificationFromJson(jsonString);

import 'dart:convert';

FcmNotification fcmNotificationFromJson(String str) =>
    FcmNotification.fromJson(json.decode(str));

String fcmNotificationToJson(FcmNotification data) =>
    json.encode(data.toJson());

class FcmNotification {
  FcmNotification({
    this.to,
    this.notification,
    this.data,
  });

  String to;
  Notification notification;
  Data data;

  factory FcmNotification.fromJson(Map<String, dynamic> json) =>
      FcmNotification(
        to: json["to"] == null ? null : json["to"],
        notification: json["notification"] == null
            ? null
            : Notification.fromJson(json["notification"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "to": to == null ? null : to,
        "notification": notification == null ? null : notification.toJson(),
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.notificationType,
    this.notificationTextType,
    this.image,
    this.message,
    this.date,
    this.read,
  });

  String notificationType;
  String notificationTextType;
  String image;
  String message;
  DateTime date;
  bool read;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notificationType:
            json["notificationType"] == null ? null : json["notificationType"],
        notificationTextType: json["notificationTextType"] == null
            ? null
            : json["notificationTextType"],
        image: json["image"] == null ? null : json["image"],
        message: json["message"] == null ? null : json["message"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        read: json["read"] == null ? null : json["read"],
      );

  Map<String, dynamic> toJson() => {
        "notificationType": notificationType == null ? null : notificationType,
        "notificationTextType":
            notificationTextType == null ? null : notificationTextType,
        "image": image == null ? null : image,
        "message": message == null ? null : message,
        "date": date == null ? null : date.toIso8601String(),
        "read": read == null ? null : read,
      };
}

class Notification {
  Notification();

  factory Notification.fromJson(Map<String, dynamic> json) => Notification();

  Map<String, dynamic> toJson() => {};
}
