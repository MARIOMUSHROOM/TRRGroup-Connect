// To parse this JSON data, do
//
//     final waterSprayPlantModel = waterSprayPlantModelFromJson(jsonString);

import 'dart:convert';

WaterSprayPlantModel waterSprayPlantModelFromJson(String str) =>
    WaterSprayPlantModel.fromJson(json.decode(str));

String waterSprayPlantModelToJson(WaterSprayPlantModel data) =>
    json.encode(data.toJson());

class WaterSprayPlantModel {
  WaterSprayPlantModel({
    this.idActivityProcess,
    this.plot,
    this.no,
    this.idHybrid,
    this.idUrea,
    this.recipeAmount,
    this.ureaWeight,
    this.waterWeight,
    this.ureaPrice,
    this.otherRecipe,
    this.otherRecipeAmount,
    this.sprayCost,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneUrea,
  });

  int idActivityProcess;
  String plot;
  int no;
  dynamic idHybrid;
  int idUrea;
  int recipeAmount;
  double ureaWeight;
  double waterWeight;
  double ureaPrice;
  String otherRecipe;
  int otherRecipeAmount;
  double sprayCost;
  double laborCost;
  double fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  dynamic topic;
  HasOneUrea hasOneUrea;

  factory WaterSprayPlantModel.fromJson(Map<String, dynamic> json) =>
      WaterSprayPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        no: json["no"] == null ? null : json["no"],
        idHybrid: json["idHybrid"],
        idUrea: json["idUrea"] == null ? null : json["idUrea"],
        recipeAmount:
            json["recipeAmount"] == null ? null : json["recipeAmount"],
        ureaWeight:
            json["ureaWeight"] == null ? null : json["ureaWeight"].toDouble(),
        waterWeight:
            json["waterWeight"] == null ? null : json["waterWeight"].toDouble(),
        ureaPrice:
            json["ureaPrice"] == null ? null : json["ureaPrice"].toDouble(),
        otherRecipe: json["otherRecipe"] == null ? null : json["otherRecipe"],
        otherRecipeAmount: json["otherRecipeAmount"] == null
            ? null
            : json["otherRecipeAmount"],
        sprayCost:
            json["sprayCost"] == null ? null : json["sprayCost"].toDouble(),
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
        hasOneUrea: json["has_one_urea"] == null
            ? null
            : HasOneUrea.fromJson(json["has_one_urea"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "no": no == null ? null : no,
        "idHybrid": idHybrid,
        "idUrea": idUrea == null ? null : idUrea,
        "recipeAmount": recipeAmount == null ? null : recipeAmount,
        "ureaWeight": ureaWeight == null ? null : ureaWeight,
        "waterWeight": waterWeight == null ? null : waterWeight,
        "ureaPrice": ureaPrice == null ? null : ureaPrice,
        "otherRecipe": otherRecipe == null ? null : otherRecipe,
        "otherRecipeAmount":
            otherRecipeAmount == null ? null : otherRecipeAmount,
        "sprayCost": sprayCost == null ? null : sprayCost,
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
        "has_one_urea": hasOneUrea == null ? null : hasOneUrea.toJson(),
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

class HasOneUrea {
  HasOneUrea({
    this.idUrea,
    this.name,
  });

  int idUrea;
  String name;

  factory HasOneUrea.fromJson(Map<String, dynamic> json) => HasOneUrea(
        idUrea: json["idUrea"] == null ? null : json["idUrea"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idUrea": idUrea == null ? null : idUrea,
        "name": name == null ? null : name,
      };
}
