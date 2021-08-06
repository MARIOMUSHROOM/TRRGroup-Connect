// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  NotificationListModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.notification,
    this.hasMore,
  });

  List<Notification> notification;
  bool hasMore;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notification: json["notification"] == null
            ? null
            : List<Notification>.from(
                json["notification"].map((x) => Notification.fromJson(x))),
        hasMore: json["hasMore"] == null ? null : json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification == null
            ? null
            : List<dynamic>.from(notification.map((x) => x.toJson())),
        "hasMore": hasMore == null ? null : hasMore,
      };
}

class Notification {
  Notification({
    this.idNotification,
    this.idUser,
    this.idTypeNotification,
    this.title,
    this.body,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int idNotification;
  int idUser;
  int idTypeNotification;
  String title;
  String body;
  String description;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        idNotification:
            json["idNotification"] == null ? null : json["idNotification"],
        idUser: json["idUser"] == null ? null : json["idUser"],
        idTypeNotification: json["idTypeNotification"] == null
            ? null
            : json["idTypeNotification"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "idNotification": idNotification == null ? null : idNotification,
        "idUser": idUser == null ? null : idUser,
        "idTypeNotification":
            idTypeNotification == null ? null : idTypeNotification,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "description": description == null ? null : description,
        "status": status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
