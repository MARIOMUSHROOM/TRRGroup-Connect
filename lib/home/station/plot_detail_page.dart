import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/station/model/local_model.dart';
import 'package:ai_flutter/home/station/model/plot_list_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlotDetailPage extends StatefulWidget {
  PlotDetailPage(this.stationReport);
  StationDetail stationReport;
  @override
  _PlotDetailPageState createState() =>
      _PlotDetailPageState(this.stationReport);
}

class _PlotDetailPageState extends State<PlotDetailPage> {
  _PlotDetailPageState(this.stationReport);
  StationDetail stationReport;

  List<Polygon> _polygonList = [];
  List<LatLng> latlngSegment = List();
  // GoogleMapController controller;
  List<Set<Polyline>> polylineList = new List();
  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      // StationReport stationOnly = new StationReport();
      // stationOnly = widget.stationReport;
      latlngSegment = new List();
      for (var j = 0; j < stationReport.coOrPoints.length; j++) {
        double lat = stationReport.coOrPoints[j][1];
        double lng = stationReport.coOrPoints[j][0];
        LatLng position = new LatLng(lat, lng);
        latlngSegment.add(position);
      }
      _polygonList.add(
        Polygon(
          polygonId: PolygonId("1"),
          points: latlngSegment,
          visible: true,
          strokeColor: Colors.blue,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.15),
        ),
      );
      // latlngSegment1.clear();
      print("polygon : ${_polygonList.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'แปลงของฉัน',
      //     textAlign: TextAlign.center,
      //     style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: 'แปลงของฉัน',
        actionOn: false,
        // onPressed: () async {
        //   await submitData();
        // },
      ),
      backgroundColor: kblueBackgoundColor,
      body: SingleChildScrollView(
        child: Container(
          color: kblueBackgoundColor,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                // color: Colors.red,
                padding: EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: GoogleMap(
                    //that needs a list<Polyline>
                    // polylines: _polyLineList.toSet(),
                    polygons: _polygonList.toSet(),
                    // polygons: polygonOnly,
                    // polygons: polyList[index],
                    onMapCreated: _onMapCreated,
                    scrollGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          stationReport.center[1], stationReport.center[0]),
                      zoom: 15.0,
                    ),
                    mapType: MapType.satellite,
                  ),
                  // child: Text("image"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                // color: Colors.green,
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TitleText(
                              text: stationReport.measuringPoint.toString(),
                            ),
                            ContentText(
                              text: "จุดวัดน้ำฝน",
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: VerticalDivider(
                          width: 5,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TitleTextWithBit(
                              widget: widget,
                              content: stationReport.distance.toString(),
                              bit: " กิโลเมตร",
                            ),
                            ContentText(
                              text: "ระยะห่างจากแปลง",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                // color: Colors.green,
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "ปริมาณน้ำฝนสะสม",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        // height: 100,
                        // // color: Colors.green,
                        // padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TitleTextWithBit(
                                    widget: widget,
                                    content: widget
                                        .stationReport.lastYearCumulativeRain
                                        .toString(),
                                    bit: " mm",
                                  ),
                                  ContentText(
                                    text: "ปีที่แล้ว",
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(
                                width: 5,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TitleTextWithBit(
                                    widget: widget,
                                    content: stationReport
                                        .currYearCumulativeRain
                                        .toString(),
                                    bit: " mm",
                                  ),
                                  ContentText(
                                    text: "ปีปัจจุบัน",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleTextWithBit extends StatelessWidget {
  TitleTextWithBit({
    Key key,
    @required this.widget,
    @required this.content,
    @required this.bit,
  }) : super(key: key);

  final PlotDetailPage widget;
  String content;
  String bit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleText(
          text: content,
        ),
        TitleText(
          text: bit,
        ),
        // Text(widget.stationReport.distance.toString()),
        // Text(" กิโลเมตร"),
      ],
    );
  }
}

class ContentText extends StatelessWidget {
  ContentText({
    Key key,
    @required this.text,
  }) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  TitleText({
    Key key,
    @required this.text,
  }) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
