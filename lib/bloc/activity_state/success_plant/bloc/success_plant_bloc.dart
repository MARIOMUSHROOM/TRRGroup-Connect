import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'success_plant_event.dart';
part 'success_plant_state.dart';

class SuccessPlantBloc extends Bloc<SuccessPlantEvent, SuccessPlantState> {
  SuccessPlantBloc() : super(SuccessPlantInitial());
  InputActivityForm inputActivityForm;
  String title;
  int sugarCaneType;
  List<ActivityProcess> activityProcessList;
  PlotDetail stationSelect;
  List<PlotDetail> stationList;

  @override
  Stream<SuccessPlantState> mapEventToState(
    SuccessPlantEvent event,
  ) async* {
    if (event is LoadSuccessPlantInitial) {
      yield SuccessPlantInitial();
    } else if (event is LoadSuccessPlantData) {
      _mapLoadSuccessPlantState(event);
      yield* _connectAPI();
    }
  }

  _mapLoadSuccessPlantState(LoadSuccessPlantData event) {
    var concatenate = StringBuffer();
    inputActivityForm = event.inputActivityForm;
    inputActivityForm.plot_detail.forEach((item) {
      concatenate.write(item.plot_name + ", ");
    });

    // stationSelect = inputActivityForm.plot_detail[0];
    stationList = inputActivityForm.plot_detail;
    title = "กิจกรรมทั้งหมด ${concatenate.toString()} ";
  }

  Stream<SuccessPlantState> _connectAPI() async* {
    yield SuccessPlantLoading();
    try {
      //cut
      var concatenatePlotList = StringBuffer();
      inputActivityForm.plot_detail.forEach((item) {
        concatenatePlotList.write(item.plot_id.toString() + "_");
      });
      sugarCaneType = sugarCaneTypeChange(inputActivityForm.activity_type);
      var rs = await ActivityAPI().getLastView(
        "63_64",
        sugarCaneType.toString(),
        concatenatePlotList.toString(),
      );
      var jsonRes = json.decode(rs.body);
      print("jsonRes");
      print(jsonRes);
      if (jsonRes.isNotEmpty) {
        activityProcessList = new List();
        for (var i = 0; i < jsonRes.length; i++) {
          ActivityProcess only = new ActivityProcess();
          only.title = jsonRes[i]["plot_value"];
          only.content = jsonRes[i]["activity_value"];
          only.date = jsonRes[i]["date_value"];
          activityProcessList.add(only);
        }
        yield SuccessPlantLoaded();
      } else {
        yield SuccessPlantNoData();
      }
    } catch (e) {
      yield SuccessPlantError(e.toString());
    }
  }
}
