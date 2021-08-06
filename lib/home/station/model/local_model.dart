class StationReport {
  StationReport({
    this.year_period_str,
    this.plot_no,
    this.area_size,
    this.sugarcane_age,
    this.sugarcane_type,
    this.product_per_rai,
    this.distance,
    this.curr_year_cumulative_rain,
    this.last_year_cumulative_rain,
    this.plot_detail,
  });

  String year_period_str;
  String plot_no;
  double area_size;
  int sugarcane_age;
  String sugarcane_type;
  double product_per_rai;
  double distance;
  double last_year_cumulative_rain;
  double curr_year_cumulative_rain;
  PlotDetail plot_detail;
}

class PlotDetail {
  PlotDetail({this.center_lat, this.center_lng, this.co_or_point});
  double center_lat;
  double center_lng;
  List<PositionPoint> co_or_point;
}

class PositionPoint {
  PositionPoint(this.lat, this.lng);
  double lat;
  double lng;
}
