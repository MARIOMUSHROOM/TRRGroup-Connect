// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) =>
    ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) =>
    json.encode(data.toJson());

class ReportListModel {
  ReportListModel({
    this.totalPlot,
    this.reportData,
    this.yearStart,
    this.yearEnd,
  });

  int totalPlot;
  List<ReportDatum> reportData;
  String yearStart;
  String yearEnd;

  factory ReportListModel.fromJson(Map<String, dynamic> json) =>
      ReportListModel(
        totalPlot: json["totalPlot"] == null ? null : json["totalPlot"],
        reportData: json["reportData"] == null
            ? null
            : List<ReportDatum>.from(
                json["reportData"].map((x) => ReportDatum.fromJson(x))),
        yearStart: json["yearStart"] == null ? null : json["yearStart"],
        yearEnd: json["yearEnd"] == null ? null : json["yearEnd"],
      );

  Map<String, dynamic> toJson() => {
        "totalPlot": totalPlot == null ? null : totalPlot,
        "reportData": reportData == null
            ? null
            : List<dynamic>.from(reportData.map((x) => x.toJson())),
        "yearStart": yearStart == null ? null : yearStart,
        "yearEnd": yearEnd == null ? null : yearEnd,
      };
}

class ReportDatum {
  ReportDatum({
    this.idSuccessYear,
    this.plot,
  });

  int idSuccessYear;
  int plot;

  factory ReportDatum.fromJson(Map<String, dynamic> json) => ReportDatum(
        idSuccessYear:
            json["idSuccessYear"] == null ? null : json["idSuccessYear"],
        plot: json["plot"] == null ? null : json["plot"],
      );

  Map<String, dynamic> toJson() => {
        "idSuccessYear": idSuccessYear == null ? null : idSuccessYear,
        "plot": plot == null ? null : plot,
      };
}
