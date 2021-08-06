// To parse this JSON data, do
//
//     final chemicalSprayPlantModel = chemicalSprayPlantModelFromJson(jsonString);

import 'dart:convert';

ChemicalSprayPlantModel chemicalSprayPlantModelFromJson(String str) =>
    ChemicalSprayPlantModel.fromJson(json.decode(str));

String chemicalSprayPlantModelToJson(ChemicalSprayPlantModel data) =>
    json.encode(data.toJson());

class ChemicalSprayPlantModel {
  ChemicalSprayPlantModel({
    this.idActivityProcess,
    this.plot,
    this.no,
    this.idHybrid,
    this.idSprayType,
    this.idProductName,
    this.productName,
    this.sprayDesc,
    this.chemicalCost,
    this.contractCost,
    this.laborCost,
    this.fuelPrice,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneSprayType,
    this.hasOneSprayProduct,
  });

  int idActivityProcess;
  String plot;
  int no;
  dynamic idHybrid;
  int idSprayType;
  int idProductName;
  String productName;
  dynamic sprayDesc;
  double chemicalCost;
  double contractCost;
  double laborCost;
  double fuelPrice;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  dynamic topic;
  HasOneSprayType hasOneSprayType;
  HasOneSprayProduct hasOneSprayProduct;

  factory ChemicalSprayPlantModel.fromJson(Map<String, dynamic> json) =>
      ChemicalSprayPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        no: json["no"] == null ? null : json["no"],
        idHybrid: json["idHybrid"],
        idSprayType: json["idSprayType"] == null ? null : json["idSprayType"],
        idProductName:
            json["idProductName"] == null ? null : json["idProductName"],
        productName: json["productName"] == null ? null : json["productName"],
        sprayDesc: json["sprayDesc"],
        chemicalCost: json["chemicalCost"] == null
            ? null
            : json["chemicalCost"].toDouble(),
        contractCost: json["contractCost"] == null
            ? null
            : json["contractCost"].toDouble(),
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
        hasOneSprayType: json["has_one_spray_type"] == null
            ? null
            : HasOneSprayType.fromJson(json["has_one_spray_type"]),
        hasOneSprayProduct: json["has_one_spray_product"] == null
            ? null
            : HasOneSprayProduct.fromJson(json["has_one_spray_product"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "no": no == null ? null : no,
        "idHybrid": idHybrid,
        "idSprayType": idSprayType == null ? null : idSprayType,
        "idProductName": idProductName == null ? null : idProductName,
        "productName": productName == null ? null : productName,
        "sprayDesc": sprayDesc,
        "chemicalCost": chemicalCost == null ? null : chemicalCost,
        "contractCost": contractCost == null ? null : contractCost,
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
        "has_one_spray_type":
            hasOneSprayType == null ? null : hasOneSprayType.toJson(),
        "has_one_spray_product":
            hasOneSprayProduct == null ? null : hasOneSprayProduct.toJson(),
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

class HasOneSprayProduct {
  HasOneSprayProduct({
    this.idProductName,
    this.name,
  });

  int idProductName;
  String name;

  factory HasOneSprayProduct.fromJson(Map<String, dynamic> json) =>
      HasOneSprayProduct(
        idProductName:
            json["idProductName"] == null ? null : json["idProductName"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idProductName": idProductName == null ? null : idProductName,
        "name": name == null ? null : name,
      };
}

class HasOneSprayType {
  HasOneSprayType({
    this.idSprayType,
    this.name,
  });

  int idSprayType;
  String name;

  factory HasOneSprayType.fromJson(Map<String, dynamic> json) =>
      HasOneSprayType(
        idSprayType: json["idSprayType"] == null ? null : json["idSprayType"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idSprayType": idSprayType == null ? null : idSprayType,
        "name": name == null ? null : name,
      };
}
