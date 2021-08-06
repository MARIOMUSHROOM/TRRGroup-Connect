import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/station/model/group_year_model.dart';
import 'package:ai_flutter/home/station/model/local_model.dart';
import 'package:ai_flutter/home/station/model/plot_list_model.dart';
import 'package:ai_flutter/provider/plot_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ai_flutter/home/station/test/test_data.dart';

part 'plot_list_event.dart';
part 'plot_list_state.dart';

class PlotListBloc extends Bloc<PlotListEvent, PlotListState> {
  PlotListBloc() : super(PlotListInitial());
  PlotListModel plotListModel;
  List<StationDetail> defaultResult = [];
  List<StationDetail> searchResult = [];
  List<StationDetail> showResult = [];

  List<StationDetail> plotList = [];
  StationDetail plotSelected;
  String plotSelectedText;

  GroupYearModel groupYear;
  List<LastCurrentYear> yearList;
  LastCurrentYear yearSelected;
  @override
  Stream<PlotListState> mapEventToState(
    PlotListEvent event,
  ) async* {
    if (event is LoadPlotListInitial) {
      print("in LoadPlotListInitial");
      yield PlotListLoading();
      try {
        // groupYear = null;
        // yearList = null;
        // yearSelected = null;
        plotSelectedText = "แปลงทั้งหมด";
        await _connectYearAPI();
        if (yearSelected == null) {
          yearSelected = yearList[0];
        }
        yield PlotYearListLoaded();
        await _connectDataAPI();
        await Future.delayed(Duration(seconds: 1));
        if (plotListModel.result == 1) {
          print(plotListModel.data);
          defaultResult = plotListModel.data;
          showResult = defaultResult;
          plotList = defaultResult;
          // plotList.sort((a, b) => a.plotNo.compareTo(b.plotNo));
          await Future.delayed(Duration(seconds: 1));
          yield PlotListLoaded();
        } else {
          yield PlotListNoData();
        }
      } catch (e) {
        yield PlotListError(e.toString());
      }
    } else if (event is UpdatePlotListYear) {
      yield PlotListLoading();
      try {
        yearSelected = event.selectedYear;
        plotSelectedText = "แปลงทั้งหมด";
        await _connectDataAPI();
        await Future.delayed(Duration(seconds: 2));
        yield PlotYearListLoaded();
        if (plotListModel.result == 1) {
          print(plotListModel.data);
          defaultResult = plotListModel.data;
          showResult = defaultResult;
          plotList = defaultResult;
          // plotList.sort((a, b) => a.plotNo.compareTo(b.plotNo));
          await Future.delayed(Duration(seconds: 1));
          yield PlotListLoaded();
        } else {
          yield PlotListNoData();
        }
      } catch (e) {
        yield PlotListError(e.toString());
      }
    } else if (event is SortPlotList) {
      searchResult.clear();
      defaultResult.forEach((e) {
        if (identical(e, event.sortData)) {
          print("incheck same object");
          print(e.plotNo);
          print(event.sortData.plotNo);
          plotSelectedText = "แปลงที่ ${e.plotNo}";
          searchResult.add(e);
        }
      });
      showResult = [];
      showResult = searchResult;
      yield PlotListLoaded();
    } else if (event is ClearSortPlotList) {
      searchResult.clear();
      plotSelectedText = "แปลงทั้งหมด";
      showResult = defaultResult;
      yield PlotListLoaded();
    }
  }

  _connectYearAPI() async {
    var rsYear = await PlotAPI().getGroupYear();
    var jsonYearRes = json.decode(rsYear.body);
    groupYear = GroupYearModel.fromJson(jsonYearRes);
    List dataForReversed = groupYear.data;
    yearList = dataForReversed.reversed.toList();
  }

  _connectDataAPI() async {
    var rs = await PlotAPI().plotUser(yearSelected.value);
    var jsonRes = json.decode(rs.body);
    plotListModel = PlotListModel.fromJson(jsonRes);
  }
}
