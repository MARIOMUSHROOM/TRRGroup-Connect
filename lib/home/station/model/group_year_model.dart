// To parse this JSON data, do
//
//     final groupYearModel = groupYearModelFromJson(jsonString);

import 'dart:convert';

GroupYearModel groupYearModelFromJson(String str) =>
    GroupYearModel.fromJson(json.decode(str));

String groupYearModelToJson(GroupYearModel data) => json.encode(data.toJson());

class GroupYearModel {
  GroupYearModel({
    this.result,
    this.data,
  });

  int result;
  List<LastCurrentYear> data;

  factory GroupYearModel.fromJson(Map<String, dynamic> json) => GroupYearModel(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null
            ? null
            : List<LastCurrentYear>.from(
                json["data"].map((x) => LastCurrentYear.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LastCurrentYear {
  LastCurrentYear({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory LastCurrentYear.fromJson(Map<String, dynamic> json) =>
      LastCurrentYear(
        text: json["text"] == null ? null : json["text"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "value": value == null ? null : value,
      };
}
