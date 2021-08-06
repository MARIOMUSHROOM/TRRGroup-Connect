import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/station/model/local_model.dart';
import 'package:ai_flutter/home/station/model/plot_map_model.dart';
import 'package:ai_flutter/home/station/test/test_data.dart';
import 'package:ai_flutter/provider/plot_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'plot_map_event.dart';
part 'plot_map_state.dart';

class PlotMapBloc extends Bloc<PlotMapEvent, PlotMapState> {
  PlotMapBloc() : super(PlotMapInitial());
  List<StationReport> stationReportList;
  PlotMapModel plotMapModel;
  List<Plot> plotsList;

  List<Polygon> polygonList = [];
  List<Polygon> cameraPolygonList = [];
  List<LatLng> latlngSegment = List();
  List<LatLng> cameraLatlngSegment = List();
  @override
  Stream<PlotMapState> mapEventToState(
    PlotMapEvent event,
  ) async* {
    if (event is LoadPlotMapInitial) {
      print("in LoadPlotMapInitial");
      stationReportList = stationList;
      print("before connect");
      yield* _connectAPI(event.yearSelected);
      // yield PlotMapLoaded(stationReportList);
    }
  }

  Stream<PlotMapState> _connectAPI(int yearSelected) async* {
    yield PlotMapLoading();
    try {
      print("in");
      // var rs = await rootBundle.loadString('lib/bloc/plot_state/demo.json');
      var rs = await PlotAPI().plots(yearSelected);
      print("rs");
      print(rs);
      print("rsss");
      var jsonRes = json.decode(rs.body);
      print("jsonRes");
      print(jsonRes);
      if (jsonRes['result'] == 1) {
        print("success");
        print(jsonRes['plots']);
        plotMapModel = PlotMapModel.fromJson(jsonRes);
        if (plotMapModel.plots.isNotEmpty) {
          print("data");
          print(plotMapModel);
          await setPolyLine();
          yield PlotMapLoaded(plotMapModel);
        } else {
          yield PlotMapNoData();
        }
      } else {
        yield PlotMapNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield PlotMapError(e.toString());
    }
  }

  setPolyLine() {
    print(plotMapModel.plots.length);
    polygonList = [];
    cameraPolygonList = [];
    latlngSegment = List();
    cameraLatlngSegment = List();

    for (var i = 0; i < plotMapModel.plots.length; i++) {
      // StationReport stationOnly = new StationReport();
      // stationOnly = stationList[i];
      latlngSegment = new List();
      print(plotMapModel.plots[i]);
      for (var j = 0; j < plotMapModel.plots[i].coOrPoints.length; j++) {
        // print(data.plots[i].point[j][0]);
        print(
            "${plotMapModel.plots[i].coOrPoints[j][1]},${plotMapModel.plots[i].coOrPoints[j][0]}");
        double lat = plotMapModel.plots[i].coOrPoints[j][1];
        double lng = plotMapModel.plots[i].coOrPoints[j][0];
        LatLng position = new LatLng(lat, lng);
        LatLng cameraPosition = new LatLng(
            plotMapModel.plots[i].center[1], plotMapModel.plots[i].center[0]);
        latlngSegment.add(position);
        cameraLatlngSegment.add(cameraPosition);
      }
      polygonList.add(
        Polygon(
          polygonId: PolygonId("$i"),
          points: latlngSegment,
          visible: true,
          strokeColor: Colors.blue,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.15),
        ),
      );
      cameraPolygonList.add(
        Polygon(
          polygonId: PolygonId("$i"),
          points: cameraLatlngSegment,
          visible: true,
          strokeColor: Colors.blue,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.15),
        ),
      );
      // latlngSegment1.clear();
      // print("polygon : ${_polygonList.length}");
      print(i);
    }
  }
}
