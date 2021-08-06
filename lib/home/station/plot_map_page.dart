import 'dart:convert';

import 'package:ai_flutter/bloc/plot_state/plot_map/bloc/plot_map_bloc.dart';
import 'package:ai_flutter/home/station/model/local_model.dart';
import 'package:ai_flutter/home/station/model/plot_map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlotMapPage extends StatelessWidget {
  PlotMapPage({Key key}) : super(key: key);
  // List<Polygon> _polygonList = [];
  // List<Polygon> _cameraPolygonList = [];
  // List<LatLng> latlngSegment = List();
  // List<LatLng> cameraLatlngSegment = List();
  // // GoogleMapController controller;
  // List<Set<Polyline>> polylineList = new List();
  // setPolyLine() {
  //   print(data.plots.length);
  //   for (var i = 0; i < data.plots.length; i++) {
  //     // StationReport stationOnly = new StationReport();
  //     // stationOnly = stationList[i];
  //     latlngSegment = new List();
  //     print(data.plots[i]);
  //     for (var j = 0; j < data.plots[i].coOrPoints.length; j++) {
  //       // print(data.plots[i].point[j][0]);
  //       print(
  //           "${data.plots[i].coOrPoints[j][1]},${data.plots[i].coOrPoints[j][0]}");
  //       double lat = data.plots[i].coOrPoints[j][1];
  //       double lng = data.plots[i].coOrPoints[j][0];
  //       LatLng position = new LatLng(lat, lng);
  //       LatLng cameraPosition =
  //           new LatLng(data.plots[i].center[1], data.plots[i].center[0]);
  //       latlngSegment.add(position);
  //       cameraLatlngSegment.add(cameraPosition);
  //     }
  //     _polygonList.add(
  //       Polygon(
  //         polygonId: PolygonId("$i"),
  //         points: latlngSegment,
  //         visible: true,
  //         strokeColor: Colors.blue,
  //         strokeWidth: 2,
  //         fillColor: Colors.blue.withOpacity(0.15),
  //       ),
  //     );
  //     _cameraPolygonList.add(
  //       Polygon(
  //         polygonId: PolygonId("$i"),
  //         points: cameraLatlngSegment,
  //         visible: true,
  //         strokeColor: Colors.blue,
  //         strokeWidth: 2,
  //         fillColor: Colors.blue.withOpacity(0.15),
  //       ),
  //     );
  //     // latlngSegment1.clear();
  //     print("polygon : ${_polygonList.length}");
  //     print(i);
  //   }
  // }

  // LatLng center;
  // LatLng centroid(List<LatLng> points) {
  //   print(points);
  //   List<double> centroid = [0.0, 0.0];
  //   for (int i = 0; i < points.length; i++) {
  //     centroid[0] += points[i].latitude;
  //     centroid[1] += points[i].longitude;
  //   }
  //   int totalPoints = points.length;
  //   centroid[0] = centroid[0] / totalPoints;
  //   centroid[1] = centroid[1] / totalPoints;
  //   print(centroid[0]);
  //   print(centroid[1]);
  //   return LatLng(centroid[0], centroid[1]);
  // }

  // List<StationReport> stationList;
  PlotMapModel data;
  PlotMapBloc _plotMapBloc;
  @override
  Widget build(BuildContext context) {
    _plotMapBloc = BlocProvider.of<PlotMapBloc>(context);
    return BlocBuilder<PlotMapBloc, PlotMapState>(
      builder: (context, state) {
        Widget googleMapWidget;
        if (state is PlotMapInitial) {
          googleMapWidget = SizedBox();
          _plotMapBloc.add(LoadPlotMapInitial(6364));
        } else if (state is PlotMapError) {
          googleMapWidget = Center(
              child: Text(
            "การเชื่อมต่อมีปัญหา กรุณาลองใหม่อีกครั้งในภายหลัง",
            textAlign: TextAlign.center,
          ));
        } else if (state is PlotMapNoData) {
          googleMapWidget = Center(
              child: Text(
            "ไม่มีข้อมูล",
            textAlign: TextAlign.center,
          ));
        } else if (state is PlotMapLoaded) {
          // data = state.stationList;
          // setPolyLine();
          // center = centroid(cameraLatlngSegment);
          googleMapWidget = Container(
            padding: EdgeInsets.all(10),
            child: GoogleMap(
              polygons: _plotMapBloc.polygonList.toSet(),
              scrollGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(_plotMapBloc.cameraLatlngSegment[0].latitude,
                    _plotMapBloc.cameraLatlngSegment[1].longitude),
                zoom: 15.0,
              ),
              mapType: MapType.satellite,
            ),
          );
        }
        return Scaffold(
          body: googleMapWidget,
        );
      },
    );
  }
}
