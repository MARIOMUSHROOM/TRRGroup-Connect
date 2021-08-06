// To parse this JSON data, do
//
//     final reportDetailModel = reportDetailModelFromJson(jsonString);

import 'dart:convert';

ReportDetailModel reportDetailModelFromJson(String str) =>
    ReportDetailModel.fromJson(json.decode(str));

String reportDetailModelToJson(ReportDetailModel data) =>
    json.encode(data.toJson());

class ReportDetailModel {
  ReportDetailModel({
    this.totalAmount,
    this.data,
    this.hasMore,
  });

  int totalAmount;
  List<dynamic> data;
  bool hasMore;

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) =>
      ReportDetailModel(
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        data: json["data"] == null
            ? null
            : List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["hasMore"] == null ? null : json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount == null ? null : totalAmount,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "hasMore": hasMore == null ? null : hasMore,
      };
}
