// To parse this JSON data, do
//
//     final manurePlantModel = manurePlantModelFromJson(jsonString);

import 'dart:convert';

ManurePlantModel manurePlantModelFromJson(String str) =>
    ManurePlantModel.fromJson(json.decode(str));

String manurePlantModelToJson(ManurePlantModel data) =>
    json.encode(data.toJson());

class ManurePlantModel {
  ManurePlantModel({
    this.idActivityProcess,
    this.plot,
    this.no,
    this.idHybrid,
    this.idFertilizerType,
    this.recipe,
    this.recipeAmount,
    this.sackPrice,
    this.machineCost,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneFertilizerType,
  });

  int idActivityProcess;
  String plot;
  int no;
  dynamic idHybrid;
  int idFertilizerType;
  String recipe;
  double recipeAmount;
  double sackPrice;
  double machineCost;
  double laborCost;
  double fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  dynamic topic;
  HasOneFertilizerType hasOneFertilizerType;

  factory ManurePlantModel.fromJson(Map<String, dynamic> json) =>
      ManurePlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        no: json["no"] == null ? null : json["no"],
        idHybrid: json["idHybrid"],
        idFertilizerType:
            json["idFertilizerType"] == null ? null : json["idFertilizerType"],
        recipe: json["recipe"] == null ? null : json["recipe"],
        recipeAmount: json["recipeAmount"] == null
            ? null
            : json["recipeAmount"].toDouble(),
        sackPrice:
            json["sackPrice"] == null ? null : json["sackPrice"].toDouble(),
        machineCost:
            json["machineCost"] == null ? null : json["machineCost"].toDouble(),
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
        hasOneFertilizerType: json["has_one_fertilizer_type"] == null
            ? null
            : HasOneFertilizerType.fromJson(json["has_one_fertilizer_type"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "no": no == null ? null : no,
        "idHybrid": idHybrid,
        "idFertilizerType": idFertilizerType == null ? null : idFertilizerType,
        "recipe": recipe == null ? null : recipe,
        "recipeAmount": recipeAmount == null ? null : recipeAmount,
        "sackPrice": sackPrice == null ? null : sackPrice,
        "machineCost": machineCost == null ? null : machineCost,
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
        "has_one_fertilizer_type":
            hasOneFertilizerType == null ? null : hasOneFertilizerType.toJson(),
      };
}

class Datum {
  Datum({
    this.name,
    this.value,
    this.unit,
  });

  String name;
  dynamic value;
  String unit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        value: json["value"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value,
        "unit": unit == null ? null : unit,
      };
}

class HasOneFertilizerType {
  HasOneFertilizerType({
    this.idFertilizerType,
    this.name,
  });

  int idFertilizerType;
  String name;

  factory HasOneFertilizerType.fromJson(Map<String, dynamic> json) =>
      HasOneFertilizerType(
        idFertilizerType:
            json["idFertilizerType"] == null ? null : json["idFertilizerType"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idFertilizerType": idFertilizerType == null ? null : idFertilizerType,
        "name": name == null ? null : name,
      };
}
