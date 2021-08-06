// To parse this JSON data, do
//
//     final waterPlantModel = waterPlantModelFromJson(jsonString);

import 'dart:convert';

WaterPlantModel waterPlantModelFromJson(String str) =>
    WaterPlantModel.fromJson(json.decode(str));

String waterPlantModelToJson(WaterPlantModel data) =>
    json.encode(data.toJson());

class WaterPlantModel {
  WaterPlantModel({
    this.idActivityProcess,
    this.plot,
    this.idHybrid,
    this.idWaterResources,
    this.idWaterSystem,
    this.waterSystemDesc,
    this.no,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneWaterResources,
    this.hasOneWaterSystem,
  });

  int idActivityProcess;
  String plot;
  int idHybrid;
  int idWaterResources;
  int idWaterSystem;
  String waterSystemDesc;
  dynamic no;
  int laborCost;
  int fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  String topic;
  HasOneWaterResources hasOneWaterResources;
  HasOneWaterSystem hasOneWaterSystem;

  factory WaterPlantModel.fromJson(Map<String, dynamic> json) =>
      WaterPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        idHybrid: json["idHybrid"] == null ? null : json["idHybrid"],
        idWaterResources:
            json["idWaterResources"] == null ? null : json["idWaterResources"],
        idWaterSystem:
            json["idWaterSystem"] == null ? null : json["idWaterSystem"],
        waterSystemDesc:
            json["waterSystemDesc"] == null ? null : json["waterSystemDesc"],
        no: json["no"],
        laborCost: json["laborCost"] == null ? null : json["laborCost"],
        fuelPrice: json["fuelPrice"] == null ? null : json["fuelPrice"],
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
        topic: json["topic"] == null ? null : json["topic"],
        hasOneWaterResources: json["has_one_water_resources"] == null
            ? null
            : HasOneWaterResources.fromJson(json["has_one_water_resources"]),
        hasOneWaterSystem: json["has_one_water_system"] == null
            ? null
            : HasOneWaterSystem.fromJson(json["has_one_water_system"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "idHybrid": idHybrid == null ? null : idHybrid,
        "idWaterResources": idWaterResources == null ? null : idWaterResources,
        "idWaterSystem": idWaterSystem == null ? null : idWaterSystem,
        "waterSystemDesc": waterSystemDesc == null ? null : waterSystemDesc,
        "no": no,
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
        "topic": topic == null ? null : topic,
        "has_one_water_resources":
            hasOneWaterResources == null ? null : hasOneWaterResources.toJson(),
        "has_one_water_system":
            hasOneWaterSystem == null ? null : hasOneWaterSystem.toJson(),
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

class HasOneWaterResources {
  HasOneWaterResources({
    this.idWaterResources,
    this.name,
  });

  int idWaterResources;
  String name;

  factory HasOneWaterResources.fromJson(Map<String, dynamic> json) =>
      HasOneWaterResources(
        idWaterResources:
            json["idWaterResources"] == null ? null : json["idWaterResources"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idWaterResources": idWaterResources == null ? null : idWaterResources,
        "name": name == null ? null : name,
      };
}

class HasOneWaterSystem {
  HasOneWaterSystem({
    this.idWaterSystem,
    this.name,
  });

  int idWaterSystem;
  String name;

  factory HasOneWaterSystem.fromJson(Map<String, dynamic> json) =>
      HasOneWaterSystem(
        idWaterSystem:
            json["idWaterSystem"] == null ? null : json["idWaterSystem"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idWaterSystem": idWaterSystem == null ? null : idWaterSystem,
        "name": name == null ? null : name,
      };
}
