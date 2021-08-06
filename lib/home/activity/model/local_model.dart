class SelectPlot {
  SelectPlot();
  int plotNumber;
  String plotName;
  bool select;
  int status;
}

// class SelectActivity {
//   SelectActivity();
//   List<SelectFarm> farmList;
//   String activityText;
// }

class PlantHistory {
  PlantHistory(
      {this.farmName,
      this.stationArea,
      this.time,
      this.date,
      this.title,
      this.content});
  int id;
  String farmName;
  String stationArea;
  String time;
  String date;
  String title;
  List<String> content;
}

class PlotDetail {
  PlotDetail();
  int plot_index;
  int plot_id; // แปลงที่ 1 แบบ int = "1"
  String plot_name; // แปลงที่ 1 แบบ text = "แปลงที่ 1"
  double new_plant_area;
  double old_plant_area;
  Map<String, dynamic> toJson() => {
        'plot_index': plot_index,
        'plot_id': plot_id,
        'plot_name': plot_name,
        'new_plant_area': new_plant_area,
        'old_plant_area': old_plant_area,
      };
}

class InputActivityForm {
  InputActivityForm();
  String activity_type;
  List<PlotDetail> plot_detail;
  String activity_step;
  Map input_detail;
  List<Map> mix_step_detail;

  Map<String, dynamic> toJson() => {
        'activity_type': activity_type,
        'plot_detail': plot_detail,
        'activity_step': activity_step,
        'input_detail': input_detail,
        'mix_step_detail': mix_step_detail,
      };
}

class ActivityProcess {
  ActivityProcess({this.title, this.content, this.date});
  String title;
  // List<String> content;
  String content;
  String date;
}
