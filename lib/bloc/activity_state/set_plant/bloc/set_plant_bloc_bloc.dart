import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/models/index.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';

part 'set_plant_bloc_event.dart';
part 'set_plant_bloc_state.dart';

class SetPlantBlocBloc extends Bloc<SetPlantBlocEvent, SetPlantBlocState> {
  SetPlantBlocBloc() : super(SetPlantInitial());
  InputActivityForm inputActivityForm;
  String title;
  DateTime startDate;
  DateTime endDate;
  PlotDetail stationSelect;
  List<PlotDetail> stationList;
  int sugarCaneType;
  List<PlantHistory> historyList;
  @override
  Stream<SetPlantBlocState> mapEventToState(
    SetPlantBlocEvent event,
  ) async* {
    if (event is LoadSetPlantInitial) {
      yield SetPlantInitial();
    } else if (event is LoadSetPlantData) {
      _mapLoadSetPlantBlocState(event);
      yield* _connectAPI();
    } else if (event is UpdateSetPlantStation) {
      stationSelect = event.stationSelected;
      yield* _connectAPI();
    } else if (event is UpdateSetPlantStartDate) {
      startDate = event.startDate;
      yield* _connectAPI();
    } else if (event is UpdateSetPlantEndDate) {
      endDate = event.endDate;
      yield* _connectAPI();
    } else if (event is DeleteSetPlant) {
      print(event.idActivity);
      var rs = await ActivityAPI().deleteActivityHistory(event.idActivity);
      var jsonRes = json.decode(rs.body);
      print("jsonRes");
      print(jsonRes);
      yield* _connectAPI();
    }
  }

  _mapLoadSetPlantBlocState(LoadSetPlantData event) {
    var concatenate = StringBuffer();
    inputActivityForm = event.inputActivityForm;
    inputActivityForm.plot_detail.forEach((item) {
      concatenate.write(item.plot_name + ", ");
    });
    title = "${concatenate.toString()}/ ${inputActivityForm.activity_type}";
    startDate = DateTime(DateTime.now().year - 1);
    endDate = DateTime.now();
    stationSelect = inputActivityForm.plot_detail[0];
    stationList = inputActivityForm.plot_detail;
  }

  Stream<SetPlantBlocState> _connectAPI() async* {
    yield SetPlantLoading();
    try {
      //cut
      String start = DateFormat('yyyy-MM-dd').format(startDate).toString();
      String last = DateFormat('yyyy-MM-dd').format(endDate).toString();
      sugarCaneType = sugarCaneTypeChange(inputActivityForm.activity_type);
      var rs = await ActivityAPI().getSoilView(
        "63_64",
        sugarCaneType.toString(),
        start,
        last,
        stationSelect.plot_id.toString(),
      );
      var jsonRes = json.decode(rs.body);
      print("jsonRes");
      print(jsonRes);
      jsonRes = jsonRes['data'];
      if (jsonRes.isNotEmpty) {
        historyList = new List();
        for (var i = 0; i < jsonRes.length; i++) {
          PlantHistory historyOnly = new PlantHistory();
          historyOnly.farmName = "แปลงที่ ${jsonRes[i]['plot']}";
          historyOnly.id = jsonRes[i]["idActivityProcess"];
          historyOnly.stationArea = checkNull(jsonRes[i]["topic"]);
          historyOnly.date = checkNull(jsonRes[i]["date_format"]);
          historyOnly.time = checkNull(jsonRes[i]["time_format"]);
          historyOnly.title = checkNull(jsonRes[i]["title"][0]);
          List<String> content = new List();
          for (var j = 0; j < jsonRes[i]["data"].length; j++) {
            String name = checkNull(jsonRes[i]["data"][j]['name']);
            String value = checkNull(jsonRes[i]["data"][j]['value']);
            String unit = checkNull(jsonRes[i]["data"][j]['unit']);
            String contentText = "$name $value $unit";
            content.add(contentText);
          }
          print(content);
          historyOnly.content = content;
          historyList.add(historyOnly);
        }
        print(historyList[0].date);
        print("success");
        yield SetPlantLoaded();
      } else {
        yield SetPlantNoData();
      }
    } catch (e) {
      yield SetPlantError(e.toString());
    }
  }
}
