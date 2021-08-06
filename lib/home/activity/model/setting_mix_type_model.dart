// To parse this JSON data, do
//
//     final settingMixTypeModel = settingMixTypeModelFromJson(jsonString);

import 'dart:convert';

SettingMixTypeModel settingMixTypeModelFromJson(String str) =>
    SettingMixTypeModel.fromJson(json.decode(str));

String settingMixTypeModelToJson(SettingMixTypeModel data) =>
    json.encode(data.toJson());

class SettingMixTypeModel {
  SettingMixTypeModel({
    this.data,
  });

  List<MixPlotDetail> data;

  factory SettingMixTypeModel.fromJson(Map<String, dynamic> json) =>
      SettingMixTypeModel(
        data: json["data"] == null
            ? null
            : List<MixPlotDetail>.from(
                json["data"].map((x) => MixPlotDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MixPlotDetail {
  MixPlotDetail({
    this.idUserEnroll,
    this.year,
    this.plot,
    this.amountNew,
    this.amountTor,
  });

  int idUserEnroll;
  String year;
  int plot;
  double amountNew;
  double amountTor;

  factory MixPlotDetail.fromJson(Map<String, dynamic> json) => MixPlotDetail(
        idUserEnroll:
            json["idUserEnroll"] == null ? null : json["idUserEnroll"],
        year: json["year"] == null ? null : json["year"],
        plot: json["plot"] == null ? null : json["plot"],
        amountNew:
            json["amountNew"] == null ? null : json["amountNew"].toDouble(),
        amountTor:
            json["amountTor"] == null ? null : json["amountTor"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idUserEnroll": idUserEnroll == null ? null : idUserEnroll,
        "year": year == null ? null : year,
        "plot": plot == null ? null : plot,
        "amountNew": amountNew == null ? null : amountNew,
        "amountTor": amountTor == null ? null : amountTor,
      };
}
