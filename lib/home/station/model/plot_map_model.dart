// To parse this JSON data, do
//
//     final plotMapModel = plotMapModelFromJson(jsonString);

import 'dart:convert';

PlotMapModel plotMapModelFromJson(String str) =>
    PlotMapModel.fromJson(json.decode(str));

String plotMapModelToJson(PlotMapModel data) => json.encode(data.toJson());

class PlotMapModel {
  PlotMapModel({
    this.result,
    this.plots,
  });

  int result;
  List<Plot> plots;

  factory PlotMapModel.fromJson(Map<String, dynamic> json) => PlotMapModel(
        result: json["result"] == null ? null : json["result"],
        plots: json["plots"] == null
            ? null
            : List<Plot>.from(json["plots"].map((x) => Plot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "plots": plots == null
            ? null
            : List<dynamic>.from(plots.map((x) => x.toJson())),
      };
}

class Plot {
  Plot({
    this.plotNo,
    this.coOrPoints,
    this.center,
  });

  int plotNo;
  List<List<double>> coOrPoints;
  List<double> center;

  factory Plot.fromJson(Map<String, dynamic> json) => Plot(
        plotNo: json["plot_no"] == null ? null : json["plot_no"],
        coOrPoints: json["co_or_points"] == null
            ? null
            : List<List<double>>.from(json["co_or_points"]
                .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        center: json["center"] == null
            ? null
            : List<double>.from(json["center"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "plot_no": plotNo == null ? null : plotNo,
        "co_or_points": coOrPoints == null
            ? null
            : List<dynamic>.from(
                coOrPoints.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "center":
            center == null ? null : List<dynamic>.from(center.map((x) => x)),
      };
}
