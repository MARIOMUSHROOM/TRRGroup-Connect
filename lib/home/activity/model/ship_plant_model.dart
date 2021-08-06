// To parse this JSON data, do
//
//     final shipPlantModel = shipPlantModelFromJson(jsonString);

import 'dart:convert';

ShipPlantModel shipPlantModelFromJson(String str) =>
    ShipPlantModel.fromJson(json.decode(str));

String shipPlantModelToJson(ShipPlantModel data) => json.encode(data.toJson());

class ShipPlantModel {
  ShipPlantModel({
    this.idActivityProcess,
    this.idHybrid,
    this.plot,
    this.no,
    this.transportCost,
    this.laborCost,
    this.cutOffAmount,
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
  dynamic idHybrid;
  String plot;
  int no;
  double transportCost;
  double laborCost;
  double cutOffAmount;
  double fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  dynamic topic;
  dynamic hasOneCutOffType;
  dynamic hasOnePercentLeaves;
  dynamic hasOneSugarcraneCat;

  factory ShipPlantModel.fromJson(Map<String, dynamic> json) => ShipPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        idHybrid: json["idHybrid"],
        plot: json["plot"] == null ? null : json["plot"],
        no: json["no"] == null ? null : json["no"],
        transportCost: json["transportCost"] == null
            ? null
            : json["transportCost"].toDouble(),
        laborCost:
            json["laborCost"] == null ? null : json["laborCost"].toDouble(),
        cutOffAmount: json["cutOffAmount"] == null
            ? null
            : json["cutOffAmount"].toDouble(),
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
        hasOneCutOffType: json["has_one_cut_off_type"],
        hasOnePercentLeaves: json["has_one_percent_leaves"],
        hasOneSugarcraneCat: json["has_one_sugarcrane_cat"],
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "idHybrid": idHybrid,
        "plot": plot == null ? null : plot,
        "no": no == null ? null : no,
        "transportCost": transportCost == null ? null : transportCost,
        "laborCost": laborCost == null ? null : laborCost,
        "cutOffAmount": cutOffAmount == null ? null : cutOffAmount,
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
        "has_one_cut_off_type": hasOneCutOffType,
        "has_one_percent_leaves": hasOnePercentLeaves,
        "has_one_sugarcrane_cat": hasOneSugarcraneCat,
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
