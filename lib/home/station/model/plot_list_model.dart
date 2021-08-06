// To parse this JSON data, do
//
//     final plotListModel = plotListModelFromJson(jsonString);

import 'dart:convert';

PlotListModel plotListModelFromJson(String str) =>
    PlotListModel.fromJson(json.decode(str));

String plotListModelToJson(PlotListModel data) => json.encode(data.toJson());

class PlotListModel {
  PlotListModel({
    this.result,
    this.data,
  });

  int result;
  List<StationDetail> data;

  factory PlotListModel.fromJson(Map<String, dynamic> json) => PlotListModel(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null
            ? null
            : List<StationDetail>.from(
                json["data"].map((x) => StationDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StationDetail {
  StationDetail({
    this.yearPeriodStr,
    this.plotNo,
    this.areaSize,
    this.sugarcaneAge,
    this.sugarcaneType,
    this.productPerRai,
    this.measuringPoint,
    this.distance,
    this.lastYearCumulativeRain,
    this.currYearCumulativeRain,
    this.coOrPoints,
    this.center,
  });

  int yearPeriodStr;
  int plotNo;
  double areaSize;
  double sugarcaneAge;
  String sugarcaneType;
  double productPerRai;
  String measuringPoint;
  double distance;
  double lastYearCumulativeRain;
  double currYearCumulativeRain;
  List<List<double>> coOrPoints;
  List<double> center;

  factory StationDetail.fromJson(Map<String, dynamic> json) => StationDetail(
        yearPeriodStr:
            json["year_period_str"] == null ? null : json["year_period_str"],
        plotNo: json["plot_no"] == null ? null : json["plot_no"],
        areaSize:
            json["area_size"] == null ? null : json["area_size"].toDouble(),
        sugarcaneAge: json["sugarcane_age"] == null
            ? null
            : json["sugarcane_age"].toDouble(),
        sugarcaneType:
            json["sugarcane_type"] == null ? null : json["sugarcane_type"],
        productPerRai: json["product_per_rai"] == null
            ? null
            : json["product_per_rai"].toDouble(),
        measuringPoint:
            json["measuring_point"] == null ? null : json["measuring_point"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        lastYearCumulativeRain: json["last_year_cumulative_rain"] == null
            ? null
            : json["last_year_cumulative_rain"].toDouble(),
        currYearCumulativeRain: json["curr_year_cumulative_rain"] == null
            ? null
            : json["curr_year_cumulative_rain"].toDouble(),
        coOrPoints: json["co_or_points"] == null
            ? null
            : List<List<double>>.from(json["co_or_points"]
                .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        center: json["center"] == null
            ? null
            : List<double>.from(json["center"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "year_period_str": yearPeriodStr == null ? null : yearPeriodStr,
        "plot_no": plotNo == null ? null : plotNo,
        "area_size": areaSize == null ? null : areaSize,
        "sugarcane_age": sugarcaneAge == null ? null : sugarcaneAge,
        "sugarcane_type": sugarcaneType == null ? null : sugarcaneType,
        "product_per_rai": productPerRai == null ? null : productPerRai,
        "measuring_point": measuringPoint == null ? null : measuringPoint,
        "distance": distance == null ? null : distance,
        "last_year_cumulative_rain":
            lastYearCumulativeRain == null ? null : lastYearCumulativeRain,
        "curr_year_cumulative_rain":
            currYearCumulativeRain == null ? null : currYearCumulativeRain,
        "co_or_points": coOrPoints == null
            ? null
            : List<dynamic>.from(
                coOrPoints.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "center":
            center == null ? null : List<dynamic>.from(center.map((x) => x)),
      };
}
