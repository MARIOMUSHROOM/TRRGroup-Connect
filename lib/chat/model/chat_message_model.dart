// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

ChatMessageModel chatMessageModelFromJson(String str) =>
    ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) =>
    json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    this.idMessage,
    this.idChatRoom,
    this.idUserEnroll,
    this.to,
    this.typeMessage,
    this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int idMessage;
  int idChatRoom;
  int idUserEnroll;
  int to;
  int typeMessage;
  int status;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        idMessage: json["idMessage"] == null ? null : json["idMessage"],
        idChatRoom: json["idChatRoom"] == null ? null : json["idChatRoom"],
        idUserEnroll:
            json["idUserEnroll"] == null ? null : json["idUserEnroll"],
        to: json["to"] == null ? null : json["to"],
        typeMessage: json["type_message"] == null ? null : json["type_message"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "idMessage": idMessage == null ? null : idMessage,
        "idChatRoom": idChatRoom == null ? null : idChatRoom,
        "idUserEnroll": idUserEnroll == null ? null : idUserEnroll,
        "to": to == null ? null : to,
        "type_message": typeMessage == null ? null : typeMessage,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
