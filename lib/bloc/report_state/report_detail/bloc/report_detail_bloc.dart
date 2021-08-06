import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/activity/model/chemical_spray_plant.dart';
import 'package:ai_flutter/home/activity/model/cut_plant_model.dart';
import 'package:ai_flutter/home/activity/model/manure_plant.dart';
import 'package:ai_flutter/home/activity/model/seed_plant_model.dart';
import 'package:ai_flutter/home/activity/model/set_plant_model.dart';
import 'package:ai_flutter/home/activity/model/ship_plant_model.dart';
import 'package:ai_flutter/home/activity/model/water_plant_model.dart';
import 'package:ai_flutter/home/activity/model/water_spray_plant_model.dart';
import 'package:ai_flutter/home/report/models/report_detail_model.dart';
import 'package:ai_flutter/provider/report_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'report_detail_event.dart';
part 'report_detail_state.dart';

class ReportDetailBloc extends Bloc<ReportDetailEvent, ReportDetailState> {
  ReportDetailBloc() : super(ReportDetailInitial());
  ReportDetailModel reportDetail;
  List<dynamic> scrollList;
  int idSuccess;

  bool hasMore;
  int offsetStart;
  int offsetEnd;
  @override
  Stream<ReportDetailState> mapEventToState(
    ReportDetailEvent event,
  ) async* {
    if (event is LoadReportDetailData) {
      idSuccess = event.idSuccess;
      offsetStart = 0;
      offsetEnd = 5;
      reportDetail = new ReportDetailModel();
      scrollList = [];
      yield* _connectAPI();
    } else if (event is UpdateOffsetReportDetailData) {
      offsetStart = offsetStart + 5;
      offsetEnd = offsetEnd + 5;
      reportDetail = new ReportDetailModel();
      yield* _updateOffsetWithConnectAPI();
    }
  }

  Stream<ReportDetailState> _updateOffsetWithConnectAPI() async* {
    yield ReportDetailLazyLoading();
    try {
      print("in");
      var rs =
          await ReportAPI().getReportData(idSuccess, offsetStart, offsetEnd);
      var jsonRes = json.decode(rs.body);
      if (jsonRes.isNotEmpty) {
        ReportDetailModel jsonList = ReportDetailModel.fromJson(jsonRes);
        hasMore = jsonList.hasMore;
        print(hasMore);
        if (hasMore) {
          for (var i = 0; i < jsonList.data.length; i++) {
            int activityTypeNumber = jsonList.data[i]["idActivity"];
            var model = await mapModel(jsonList.data[i], activityTypeNumber);
            scrollList.add(model);
          }
          reportDetail.data = scrollList;
          yield ReportDetailLoaded();
        } else {
          yield ReportDetailLazyLoaded();
          await Future.delayed(Duration(seconds: 2));
          yield ReportDetailLoaded();
        }
      } else {
        yield ReportDetailNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield ReportDetailError(e.toString());
    }
  }

  Stream<ReportDetailState> _connectAPI() async* {
    yield ReportDetailLoading();
    try {
      print("in");
      var rs =
          await ReportAPI().getReportData(idSuccess, offsetStart, offsetEnd);
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      if (jsonRes.isNotEmpty) {
        print("jsonRes");
        print(jsonRes);
        ReportDetailModel jsonList = ReportDetailModel.fromJson(jsonRes);
        hasMore = jsonList.hasMore;
        reportDetail.hasMore = jsonList.hasMore;
        reportDetail.totalAmount = jsonList.totalAmount;
        if (jsonList.data.isNotEmpty) {
          for (var i = 0; i < jsonList.data.length; i++) {
            int activityTypeNumber = jsonList.data[i]["idActivity"];
            var model = await mapModel(jsonList.data[i], activityTypeNumber);
            scrollList.add(model);
          }
          reportDetail.data = scrollList;
          yield ReportDetailLoaded();
        } else {
          yield ReportDetailNoData();
        }
      } else {
        yield ReportDetailNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield ReportDetailError(e.toString());
    }
  }

  mapModel(var data, int type) {
    var model;
    switch (type) {
      case 1:
        model = SetPlantModel.fromJson(data);
        break;
      case 2:
        model = SeedPlantModel.fromJson(data);
        break;
      case 3:
        model = WaterPlantModel.fromJson(data);
        break;
      case 4:
        model = WaterSprayPlantModel.fromJson(data);
        break;
      case 5:
        model = ChemicalSprayPlantModel.fromJson(data);
        break;
      case 6:
        model = ManurePlantModel.fromJson(data);
        break;
      case 7:
        model = CutPlantModel.fromJson(data);
        break;
      case 8:
        model = ShipPlantModel.fromJson(data);
        break;
      default:
    }
    return model;
  }
}
