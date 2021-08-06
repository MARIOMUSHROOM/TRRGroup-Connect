import '../../base_class/models/ai_base_model.dart';

// To parse this JSON data, do
//     final trrGroupYearJsonModel = trrGroupYearJsonModelFromJson(jsonString);

import 'dart:convert';

TrrGroupYearJsonModel trrGroupYearJsonModelFromJson(String str) => TrrGroupYearJsonModel.fromJson(json.decode(str));

String trrGroupYearJsonModelToJson(TrrGroupYearJsonModel data) => json.encode(data.toJson());

class TrrGroupYearJsonModel extends AiBasicItem {
  TrrGroupYearJsonModel({
    this.result,
    this.data,
  });

  int result;
  List<GroupYearJsonModelItem> data;

  factory TrrGroupYearJsonModel.fromJson(Map<String, dynamic> json) => TrrGroupYearJsonModel(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? [] : List<GroupYearJsonModelItem>.from(json["data"].map((x) => GroupYearJsonModelItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  bool get isNotEmpty => (result == 1 && data.isNotEmpty);

  static final TrrGroupYearJsonModel instance = TrrGroupYearJsonModel();
}

class GroupYearJsonModelItem extends AiBasicItem {
  GroupYearJsonModelItem({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory GroupYearJsonModelItem.fromJson(Map<String, dynamic> json) => GroupYearJsonModelItem(
        text: json["text"] == null ? null : json["text"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "value": value == null ? null : value,
      };
}
