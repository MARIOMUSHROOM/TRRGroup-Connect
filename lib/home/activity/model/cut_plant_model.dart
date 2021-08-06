// To parse this JSON data, do
//
//     final cutPlantModel = cutPlantModelFromJson(jsonString);

import 'dart:convert';

CutPlantModel cutPlantModelFromJson(String str) =>
    CutPlantModel.fromJson(json.decode(str));

String cutPlantModelToJson(CutPlantModel data) => json.encode(data.toJson());

class CutPlantModel {
  CutPlantModel({
    this.idActivityProcess,
    this.plot,
    this.no,
    this.idHybrid,
    this.idCutOffType,
    this.idPercentLeaves,
    this.idSugarcraneCat,
    this.cutOffAmount,
    this.leaves,
    this.harvestCost,
    this.grabCost,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneCutOffType,
    this.hasOnePercentLeaves,
    this.hasOneSugarcraneCat,
  });

  int idActivityProcess;
  String plot;
  int no;
  dynamic idHybrid;
  int idCutOffType;
  int idPercentLeaves;
  int idSugarcraneCat;
  int cutOffAmount;
  int leaves;
  double harvestCost;
  double grabCost;
  double laborCost;
  double fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  dynamic topic;
  HasOneCutOffType hasOneCutOffType;
  HasOnePercentLeaves hasOnePercentLeaves;
  HasOneSugarcraneCat hasOneSugarcraneCat;

  factory CutPlantModel.fromJson(Map<String, dynamic> json) => CutPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        no: json["no"] == null ? null : json["no"],
        idHybrid: json["idHybrid"],
        idCutOffType:
            json["idCutOffType"] == null ? null : json["idCutOffType"],
        idPercentLeaves:
            json["idPercentLeaves"] == null ? null : json["idPercentLeaves"],
        idSugarcraneCat:
            json["idSugarcraneCat"] == null ? null : json["idSugarcraneCat"],
        cutOffAmount:
            json["cutOffAmount"] == null ? null : json["cutOffAmount"],
        leaves: json["leaves"] == null ? null : json["leaves"],
        harvestCost:
            json["harvestCost"] == null ? null : json["harvestCost"].toDouble(),
        grabCost: json["grabCost"] == null ? null : json["grabCost"].toDouble(),
        laborCost:
            json["laborCost"] == null ? null : json["laborCost"].toDouble(),
        fuelPrice:
            json["fuelPrice"] == null ? null : json["fuelPrice"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        successStatus:
            json["successStatus"] == null ? null : json["successStatus"],
        title: json["title"] == null
            ? null
            : List<String>.from(json["title"].map((x) => x)),
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        dateFormat: json["date_format"] == null ? null : json["date_format"],
        timeFormat: json["time_format"] == null ? null : json["time_format"],
        topic: json["topic"],
        hasOneCutOffType: json["has_one_cut_off_type"] == null
            ? null
            : HasOneCutOffType.fromJson(json["has_one_cut_off_type"]),
        hasOnePercentLeaves: json["has_one_percent_leaves"] == null
            ? null
            : HasOnePercentLeaves.fromJson(json["has_one_percent_leaves"]),
        hasOneSugarcraneCat: json["has_one_sugarcrane_cat"] == null
            ? null
            : HasOneSugarcraneCat.fromJson(json["has_one_sugarcrane_cat"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "no": no == null ? null : no,
        "idHybrid": idHybrid,
        "idCutOffType": idCutOffType == null ? null : idCutOffType,
        "idPercentLeaves": idPercentLeaves == null ? null : idPercentLeaves,
        "idSugarcraneCat": idSugarcraneCat == null ? null : idSugarcraneCat,
        "cutOffAmount": cutOffAmount == null ? null : cutOffAmount,
        "leaves": leaves == null ? null : leaves,
        "harvestCost": harvestCost == null ? null : harvestCost,
        "grabCost": grabCost == null ? null : grabCost,
        "laborCost": laborCost == null ? null : laborCost,
        "fuelPrice": fuelPrice == null ? null : fuelPrice,
        "date": date == null ? null : date.toIso8601String(),
        "successStatus": successStatus == null ? null : successStatus,
        "title": title == null ? null : List<dynamic>.from(title.map((x) => x)),
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "date_format": dateFormat == null ? null : dateFormat,
        "time_format": timeFormat == null ? null : timeFormat,
        "topic": topic,
        "has_one_cut_off_type":
            hasOneCutOffType == null ? null : hasOneCutOffType.toJson(),
        "has_one_percent_leaves":
            hasOnePercentLeaves == null ? null : hasOnePercentLeaves.toJson(),
        "has_one_sugarcrane_cat":
            hasOneSugarcraneCat == null ? null : hasOneSugarcraneCat.toJson(),
      };
}

class Datum {
  Datum({
    this.name,
    this.value,
    this.unit,
  });

  String name;
  String value;
  String unit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "unit": unit == null ? null : unit,
      };
}

class HasOneCutOffType {
  HasOneCutOffType({
    this.idCutOffType,
    this.name,
  });

  int idCutOffType;
  String name;

  factory HasOneCutOffType.fromJson(Map<String, dynamic> json) =>
      HasOneCutOffType(
        idCutOffType:
            json["idCutOffType"] == null ? null : json["idCutOffType"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idCutOffType": idCutOffType == null ? null : idCutOffType,
        "name": name == null ? null : name,
      };
}

class HasOnePercentLeaves {
  HasOnePercentLeaves({
    this.idPercentLeaves,
    this.name,
  });

  int idPercentLeaves;
  String name;

  factory HasOnePercentLeaves.fromJson(Map<String, dynamic> json) =>
      HasOnePercentLeaves(
        idPercentLeaves:
            json["idPercentLeaves"] == null ? null : json["idPercentLeaves"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idPercentLeaves": idPercentLeaves == null ? null : idPercentLeaves,
        "name": name == null ? null : name,
      };
}

class HasOneSugarcraneCat {
  HasOneSugarcraneCat({
    this.idSugarcraneCat,
    this.name,
  });

  int idSugarcraneCat;
  String name;

  factory HasOneSugarcraneCat.fromJson(Map<String, dynamic> json) =>
      HasOneSugarcraneCat(
        idSugarcraneCat:
            json["idSugarcraneCat"] == null ? null : json["idSugarcraneCat"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idSugarcraneCat": idSugarcraneCat == null ? null : idSugarcraneCat,
        "name": name == null ? null : name,
      };
}
