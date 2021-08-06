import 'dart:convert';

ExpenseInfo expenseInfoFromJson(String str) =>
    ExpenseInfo.fromJson(json.decode(str));

String expenseInfoToJson(ExpenseInfo data) => json.encode(data.toJson());

class ExpenseInfo {
  ExpenseInfo({
    this.expensesCost,
    this.soilTotal,
    this.sugarcraneTotal,
    this.chemicalTotal,
    this.weightTotal,
    this.transportTotal,
    this.laborTotal,
    this.data,
  });

  String expensesCost;
  String soilTotal;
  String sugarcraneTotal;
  String chemicalTotal;
  String weightTotal;
  String transportTotal;
  String laborTotal;
  List<ExpenseInfoDetail> data;

  factory ExpenseInfo.fromJson(Map<String, dynamic> json) => ExpenseInfo(
        expensesCost:
            json["expensesCost"] == null ? null : json["expensesCost"],
        soilTotal: json["soilTotal"] == null ? null : json["soilTotal"],
        sugarcraneTotal:
            json["sugarcraneTotal"] == null ? null : json["sugarcraneTotal"],
        chemicalTotal:
            json["chemicalTotal"] == null ? null : json["chemicalTotal"],
        weightTotal: json["weightTotal"] == null ? null : json["weightTotal"],
        transportTotal:
            json["transportTotal"] == null ? null : json["transportTotal"],
        laborTotal: json["laborTotal"] == null ? null : json["laborTotal"],
        data: json["data"] == null
            ? null
            : List<ExpenseInfoDetail>.from(
                json["data"].map((x) => ExpenseInfoDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expensesCost": expensesCost == null ? null : expensesCost,
        "soilTotal": soilTotal == null ? null : soilTotal,
        "sugarcraneTotal": sugarcraneTotal == null ? null : sugarcraneTotal,
        "chemicalTotal": chemicalTotal == null ? null : chemicalTotal,
        "weightTotal": weightTotal == null ? null : weightTotal,
        "transportTotal": transportTotal == null ? null : transportTotal,
        "laborTotal": laborTotal == null ? null : laborTotal,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ExpenseInfoDetail {
  ExpenseInfoDetail({
    this.name,
    this.value,
  });

  String name;
  dynamic value;

  factory ExpenseInfoDetail.fromJson(Map<String, dynamic> json) =>
      ExpenseInfoDetail(
        name: json["name"] == null ? null : json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value,
      };
}
