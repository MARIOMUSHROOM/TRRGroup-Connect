import 'package:ai_flutter/home/station/model/local_model.dart';

List<StationReport> stationList = [station1, station2, station3, station4];

StationReport station1 = new StationReport(
  year_period_str: "63/64",
  plot_no: "แปลงที่ 1",
  area_size: 19,
  sugarcane_age: 3,
  sugarcane_type: "ขอนแก่น 1",
  product_per_rai: 45,
  distance: 7.7,
  curr_year_cumulative_rain: 969.7,
  last_year_cumulative_rain: 585.7,
  plot_detail: plotDetail1,
);
PlotDetail plotDetail1 = new PlotDetail(
  center_lat: 13.500809,
  center_lng: 100.065716,
  co_or_point: positionPointList1,
);
List<PositionPoint> positionPointList1 = [
  PositionPoint(13.500809, 100.065716),
  PositionPoint(13.499114, 100.066456),
  PositionPoint(13.498206, 100.066917),
  PositionPoint(13.497841, 100.066670),
  PositionPoint(13.497319, 100.066660),
  PositionPoint(13.496860, 100.064085),
  PositionPoint(13.500345, 100.062540),
  PositionPoint(13.500809, 100.065716),
];

StationReport station2 = new StationReport(
  year_period_str: "63/64",
  plot_no: "แปลงที่ 2",
  area_size: 10,
  sugarcane_age: 3,
  sugarcane_type: "ขอนแก่น 4",
  product_per_rai: 45,
  distance: 7,
  curr_year_cumulative_rain: 300.5,
  last_year_cumulative_rain: 254.0,
  plot_detail: plotDetail2,
);
PlotDetail plotDetail2 = new PlotDetail(
  center_lat: 13.501012,
  center_lng: 100.065855,
  co_or_point: positionPointList2,
);
List<PositionPoint> positionPointList2 = [
  PositionPoint(13.501012, 100.065855),
  PositionPoint(13.501429, 100.065812),
  PositionPoint(13.501857, 100.065587),
  PositionPoint(13.502181, 100.065104),
  PositionPoint(13.501742, 100.061939),
  PositionPoint(13.500543, 100.062508),
  PositionPoint(13.501012, 100.065855),
];

StationReport station3 = new StationReport(
  year_period_str: "63/64",
  plot_no: "แปลงที่ 3",
  area_size: 40,
  sugarcane_age: 3,
  sugarcane_type: "ขอนแก่น 5",
  product_per_rai: 45,
  distance: 5,
  curr_year_cumulative_rain: 801.0,
  last_year_cumulative_rain: 568.5,
  plot_detail: plotDetail3,
);
PlotDetail plotDetail3 = new PlotDetail(
  center_lat: 13.503182,
  center_lng: 100.064331,
  co_or_point: positionPointList3,
);
List<PositionPoint> positionPointList3 = [
  PositionPoint(13.503182, 100.064331),
  PositionPoint(13.504517, 100.067443),
  PositionPoint(13.503234, 100.067861),
  PositionPoint(13.502327, 100.065469),
  PositionPoint(13.502765, 100.064879),
  PositionPoint(13.503182, 100.064331),
];

StationReport station4 = new StationReport(
  year_period_str: "63/64",
  plot_no: "แปลงที่ 4",
  area_size: 10,
  sugarcane_age: 3,
  sugarcane_type: "ขอนแก่น 2",
  product_per_rai: 35,
  distance: 1,
  curr_year_cumulative_rain: 452.5,
  last_year_cumulative_rain: 856.7,
  plot_detail: plotDetail4,
);
PlotDetail plotDetail4 = new PlotDetail(
  center_lat: 13.501033,
  center_lng: 100.066703,
  co_or_point: positionPointList4,
);
List<PositionPoint> positionPointList4 = [
  PositionPoint(13.501033, 100.066703),
  PositionPoint(13.501607, 100.068902),
  PositionPoint(13.500908, 100.069009),
  PositionPoint(13.500209, 100.067014),
  PositionPoint(13.501033, 100.066703),
];
