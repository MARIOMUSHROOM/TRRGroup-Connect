// To parse this JSON data, do
//
//     final seedPlantModel = seedPlantModelFromJson(jsonString);

import 'dart:convert';

List<SeedPlantModel> seedPlantModelFromJson(String str) =>
    List<SeedPlantModel>.from(
        json.decode(str).map((x) => SeedPlantModel.fromJson(x)));

String seedPlantModelToJson(List<SeedPlantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeedPlantModel {
  SeedPlantModel({
    this.idActivityProcess,
    this.plot,
    this.idGenre,
    this.genreDesc,
    this.no,
    this.idHybrid,
    this.grooveSpace,
    this.fdFertilizer,
    this.recipe,
    this.recipeAmount,
    this.cutOffCost,
    this.cutOffAmount,
    this.price,
    this.gougeCost,
    this.foundationCost,
    this.growerCost,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneGenre,
  });

  int idActivityProcess;
  String plot;
  int idGenre;
  String genreDesc;
  dynamic no;
  int idHybrid;
  int grooveSpace;
  int fdFertilizer;
  dynamic recipe;
  num recipeAmount;
  num cutOffCost;
  num cutOffAmount;
  num price;
  num gougeCost;
  num foundationCost;
  num growerCost;
  num laborCost;
  num fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  String topic;
  HasOneGenre hasOneGenre;

  factory SeedPlantModel.fromJson(Map<String, dynamic> json) => SeedPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        idGenre: json["idGenre"] == null ? null : json["idGenre"],
        genreDesc: json["genreDesc"] == null ? null : json["genreDesc"],
        no: json["no"],
        idHybrid: json["idHybrid"] == null ? null : json["idHybrid"],
        grooveSpace: json["grooveSpace"] == null ? null : json["grooveSpace"],
        fdFertilizer:
            json["fdFertilizer"] == null ? null : json["fdFertilizer"],
        recipe: json["recipe"],
        recipeAmount: json["recipeAmount"],
        cutOffCost: json["cutOffCost"] == null ? null : json["cutOffCost"],
        cutOffAmount:
            json["cutOffAmount"] == null ? null : json["cutOffAmount"],
        price: json["price"] == null ? null : json["price"],
        gougeCost: json["gougeCost"] == null ? null : json["gougeCost"],
        foundationCost:
            json["foundationCost"] == null ? null : json["foundationCost"],
        growerCost: json["growerCost"] == null ? null : json["growerCost"],
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
        hasOneGenre: json["has_one_genre"] == null
            ? null
            : HasOneGenre.fromJson(json["has_one_genre"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "idGenre": idGenre == null ? null : idGenre,
        "genreDesc": genreDesc == null ? null : genreDesc,
        "no": no,
        "idHybrid": idHybrid == null ? null : idHybrid,
        "grooveSpace": grooveSpace == null ? null : grooveSpace,
        "fdFertilizer": fdFertilizer == null ? null : fdFertilizer,
        "recipe": recipe,
        "recipeAmount": recipeAmount,
        "cutOffCost": cutOffCost == null ? null : cutOffCost,
        "cutOffAmount": cutOffAmount == null ? null : cutOffAmount,
        "price": price == null ? null : price,
        "gougeCost": gougeCost == null ? null : gougeCost,
        "foundationCost": foundationCost == null ? null : foundationCost,
        "growerCost": growerCost == null ? null : growerCost,
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
        "has_one_genre": hasOneGenre == null ? null : hasOneGenre.toJson(),
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

class HasOneGenre {
  HasOneGenre({
    this.idGenre,
    this.name,
  });

  int idGenre;
  String name;

  factory HasOneGenre.fromJson(Map<String, dynamic> json) => HasOneGenre(
        idGenre: json["idGenre"] == null ? null : json["idGenre"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idGenre": idGenre == null ? null : idGenre,
        "name": name == null ? null : name,
      };
}
