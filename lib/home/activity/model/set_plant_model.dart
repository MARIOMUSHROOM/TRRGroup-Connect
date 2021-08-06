// To parse this JSON data, do
//
//     final setPlantModel = setPlantModelFromJson(jsonString);

import 'dart:convert';

SetPlantModel setPlantModelFromJson(String str) =>
    SetPlantModel.fromJson(json.decode(str));

String setPlantModelToJson(SetPlantModel data) => json.encode(data.toJson());

class SetPlantModel {
  SetPlantModel({
    this.idActivityProcess,
    this.plot,
    this.idSoilType,
    this.idSoilDetail,
    this.soilDesc,
    this.no,
    this.idHybrid,
    this.fuelPrice,
    this.fuelAmount,
    this.tractorCost,
    this.laborCost,
    this.date,
    this.successStatus,
    this.title,
    this.data,
    this.dateFormat,
    this.timeFormat,
    this.topic,
    this.hasOneSoilType,
    this.hasOneSoilDetail,
  });

  int idActivityProcess;
  String plot;
  int idSoilType;
  int idSoilDetail;
  dynamic soilDesc;
  dynamic no;
  int idHybrid;
  double fuelPrice;
  double fuelAmount;
  double tractorCost;
  double laborCost;
  DateTime date;
  int successStatus;
  List<String> title;
  List<Datum> data;
  String dateFormat;
  String timeFormat;
  String topic;
  HasOneSoilType hasOneSoilType;
  HasOneSoilDetail hasOneSoilDetail;

  factory SetPlantModel.fromJson(Map<String, dynamic> json) => SetPlantModel(
        idActivityProcess: json["idActivityProcess"] == null
            ? null
            : json["idActivityProcess"],
        plot: json["plot"] == null ? null : json["plot"],
        idSoilType: json["idSoilType"] == null ? null : json["idSoilType"],
        idSoilDetail:
            json["idSoilDetail"] == null ? null : json["idSoilDetail"],
        soilDesc: json["soilDesc"],
        no: json["no"],
        idHybrid: json["idHybrid"] == null ? null : json["idHybrid"],
        fuelPrice:
            json["fuelPrice"] == null ? null : json["fuelPrice"].toDouble(),
        fuelAmount:
            json["fuelAmount"] == null ? null : json["fuelAmount"].toDouble(),
        tractorCost:
            json["tractorCost"] == null ? null : json["tractorCost"].toDouble(),
        laborCost:
            json["laborCost"] == null ? null : json["laborCost"].toDouble(),
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
        hasOneSoilType: json["has_one_soil_type"] == null
            ? null
            : HasOneSoilType.fromJson(json["has_one_soil_type"]),
        hasOneSoilDetail: json["has_one_soil_detail"] == null
            ? null
            : HasOneSoilDetail.fromJson(json["has_one_soil_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "idActivityProcess":
            idActivityProcess == null ? null : idActivityProcess,
        "plot": plot == null ? null : plot,
        "idSoilType": idSoilType == null ? null : idSoilType,
        "idSoilDetail": idSoilDetail == null ? null : idSoilDetail,
        "soilDesc": soilDesc,
        "no": no,
        "idHybrid": idHybrid == null ? null : idHybrid,
        "fuelPrice": fuelPrice == null ? null : fuelPrice,
        "fuelAmount": fuelAmount == null ? null : fuelAmount,
        "tractorCost": tractorCost == null ? null : tractorCost,
        "laborCost": laborCost == null ? null : laborCost,
        "date": date == null ? null : date.toIso8601String(),
        "successStatus": successStatus == null ? null : successStatus,
        "title": title == null ? null : List<dynamic>.from(title.map((x) => x)),
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "date_format": dateFormat == null ? null : dateFormat,
        "time_format": timeFormat == null ? null : timeFormat,
        "topic": topic == null ? null : topic,
        "has_one_soil_type":
            hasOneSoilType == null ? null : hasOneSoilType.toJson(),
        "has_one_soil_detail":
            hasOneSoilDetail == null ? null : hasOneSoilDetail.toJson(),
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

class HasOneSoilDetail {
  HasOneSoilDetail({
    this.idSoilDetail,
    this.idSoilType,
    this.name,
  });

  int idSoilDetail;
  int idSoilType;
  String name;

  factory HasOneSoilDetail.fromJson(Map<String, dynamic> json) =>
      HasOneSoilDetail(
        idSoilDetail:
            json["idSoilDetail"] == null ? null : json["idSoilDetail"],
        idSoilType: json["idSoilType"] == null ? null : json["idSoilType"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idSoilDetail": idSoilDetail == null ? null : idSoilDetail,
        "idSoilType": idSoilType == null ? null : idSoilType,
        "name": name == null ? null : name,
      };
}

class HasOneSoilType {
  HasOneSoilType({
    this.idSoilType,
    this.name,
  });

  int idSoilType;
  String name;

  factory HasOneSoilType.fromJson(Map<String, dynamic> json) => HasOneSoilType(
        idSoilType: json["idSoilType"] == null ? null : json["idSoilType"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idSoilType": idSoilType == null ? null : idSoilType,
        "name": name == null ? null : name,
      };
}
