// import 'package:ai_flutter/bloc/plot_state/function/check_null.dart';
// import 'package:ai_flutter/bloc/plot_state/plot_list/bloc/plot_list_bloc.dart';
// import 'package:ai_flutter/bloc/plot_state/plot_map/bloc/plot_map_bloc.dart';
// import 'package:ai_flutter/home/activity/utils/colors.dart';
// import 'package:ai_flutter/home/activity/widget/pick_time.dart';
// import 'package:ai_flutter/home/station/model/group_year_model.dart';
// import 'package:ai_flutter/home/station/model/plot_list_model.dart';
// import 'package:ai_flutter/home/station/model/local_model.dart';
// import 'package:ai_flutter/home/station/plot_detail_page.dart';
// import 'package:ai_flutter/home/station/widget/custom_year_picker.dart';
// import 'package:ai_flutter/home/station/widget/picker_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PlotListPage extends StatelessWidget {
//   PlotListPage({Key key}) : super(key: key);
//   int startYear = (DateTime.now().year + 543) - 1;
//   int lastYear = DateTime.now().year + 543;
//   // String dropdownFarm;

//   // List<Polygon> _polygonList = [];
//   // List<LatLng> latlngSegment = List();
//   // // plotListWidgetController controller;
//   // Set<Polygon> polygonOnly = {};
//   // List polyList = new List();
//   // void _onMapCreated(plotListWidgetController controllerParam) {
//   //   setState(() {
//   //     // controller = controllerParam;
//   //     for (var i = 0; i < stationList.length; i++) {
//   //       StationReport stationOnly = new StationReport();
//   //       stationOnly = stationList[i];
//   //       latlngSegment = new List();
//   //       for (var j = 0; j < stationOnly.plot_detail.co_or_point.length; j++) {
//   //         double lat = stationOnly.plot_detail.co_or_point[j].lat;
//   //         double lng = stationOnly.plot_detail.co_or_point[j].lng;
//   //         LatLng position = new LatLng(lat, lng);
//   //         latlngSegment.add(position);
//   //       }
//   //       _polygonList.add(
//   //         Polygon(
//   //           polygonId: PolygonId("$i"),
//   //           points: latlngSegment,
//   //           visible: true,
//   //           strokeColor: Colors.blue,
//   //           strokeWidth: 2,
//   //           fillColor: Colors.blue.withOpacity(0.15),
//   //         ),
//   //       );
//   //       polygonOnly.add(Polygon(
//   //         polygonId: PolygonId("$i"),
//   //         points: latlngSegment,
//   //         visible: true,
//   //         strokeColor: Colors.blue,
//   //         strokeWidth: 2,
//   //         fillColor: Colors.blue.withOpacity(0.15),
//   //       ));
//   //       polyList.insert(i, polygonOnly);
//   //       // latlngSegment1.clear();
//   //       // print("polygon : ${_polygonList[i]}");
//   //       print("polygon : ${_polygonList.length}");
//   //       print(i);
//   //     }
//   //   });
//   // }

//   var refreshKey = GlobalKey<RefreshIndicatorState>();
//   Future<Null> refreshList() async {
//     refreshKey.currentState?.show(atTop: true);
//     await Future.delayed(Duration(seconds: 2));
//     plotListBloc.add(LoadPlotListInitial());
//     print("refresh");
//     return null;
//   }

//   Widget plotListWidget = SizedBox();
//   Widget titleListWidget = SizedBox();
//   List<LastCurrentYear> yearList = [];
//   List<StationDetail> normalData = [];
//   // List<StationDetail> sortData;
//   PlotListBloc plotListBloc;
//   @override
//   Widget build(BuildContext context) {
//     plotListBloc = BlocProvider.of<PlotListBloc>(context);
//     return BlocBuilder<PlotListBloc, PlotListState>(
//       builder: (context, state) {
//         if (state is PlotListInitial) {
//           plotListWidget = SizedBox();
//           titleListWidget = SizedBox();
//           plotListBloc.add(LoadPlotListInitial());
//         } else if (state is PlotListLoading) {
//           plotListWidget = Column(
//             children: [
//               Center(
//                 child: new Container(
//                   height: 50,
//                   width: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(),
//                     ],
//                   ),
//                 ),
//               ),
//               new Center(child: Text("Loading...")),
//             ],
//           );
//         } else if (state is PlotListError) {
//           plotListWidget = Column(
//             children: [
//               Center(
//                   child: Text(
//                 "การเชื่อมต่อมีปัญหา กรุณาลองใหม่อีกครั้งในภายหลัง",
//                 textAlign: TextAlign.center,
//               )),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: FlatButton(
//                   onPressed: () {
//                     plotListBloc.add(LoadPlotListInitial());
//                   },
//                   child: Text("โหลดใหม่"),
//                 ),
//               ),
//             ],
//           );
//         } else if (state is PlotListNoData) {
//           plotListWidget = Center(
//               child: Text(
//             "ไม่มีข้อมูล",
//             textAlign: TextAlign.center,
//           ));
//         } else if (state is PlotYearListLoaded) {
//           yearList = plotListBloc.yearList;
//         } else if (state is PlotListLoaded) {
//           normalData = plotListBloc.stationDetailList;
//           // sortData = plotListBloc.stationDetailList;
//           // sortData.sort((a, b) => a.plotNo.compareTo(b.plotNo));
//           yearList = plotListBloc.yearList;
//           plotListWidget = Container(
//             padding: EdgeInsets.all(8),
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: normalData.length,
//               itemBuilder: (context, index) {
//                 // StationReport only = stationList[index];
//                 StationDetail only = normalData[index];
//                 List yearSplit = only.yearPeriodStr.toString().split('');
//                 String yearString =
//                     "${yearSplit[0]}${yearSplit[1]}/${yearSplit[2]}${yearSplit[3]}";
//                 print("in view");
//                 print(only.toJson());
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 140,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     alignment: Alignment.center,
//                     child: ListTile(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => PlotDetailPage(only)));
//                       },
//                       title: Container(
//                         height: 120,
//                         // color: Colors.red,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 4,
//                               child: Container(
//                                 height: 110,
//                                 width: 80,
//                                 decoration: new BoxDecoration(
//                                   // color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(10),
//                                   image: new DecorationImage(
//                                     image: new ExactAssetImage(
//                                         'assets/images/station/ICON-M.png'),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 7,
//                               child: Container(
//                                 // color: Colors.green,
//                                 padding: EdgeInsets.only(left: 10),
//                                 child: FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "ปี $yearString",
//                                         style: TextStyle(
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       RowData(
//                                         leading: "แปลง : ",
//                                         content: checkNull(only.plotNo),
//                                         textColor: Colors.grey,
//                                       ),
//                                       RowData(
//                                         leading: "พื้นที่ : ",
//                                         content:
//                                             only.areaSize.toStringAsFixed(0),
//                                         bit: " ไร่",
//                                         textColor: Colors.grey,
//                                       ),
//                                       RowData(
//                                         leading: "อายุอ้อย : ",
//                                         content: checkNull(only.sugarcaneAge),
//                                         bit: " ปี",
//                                         textColor: Colors.grey,
//                                       ),
//                                       RowData(
//                                         leading: "พันธุ์อ้อย : ",
//                                         content: checkNull(only.sugarcaneType),
//                                         textColor: Colors.grey,
//                                       ),
//                                       RowData(
//                                         leading: "ผลผลิตตัน/ไร่ : ",
//                                         content: checkNull(only.productPerRai),
//                                         bit: " ตัน",
//                                         textColor: Colors.grey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(child: Icon(Icons.keyboard_arrow_right))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return Scaffold(
//           backgroundColor: kblueBackgoundColor,
//           body: RefreshIndicator(
//             key: refreshKey,
//             onRefresh: refreshList,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Container(
//                   //   padding: EdgeInsets.only(
//                   //     top: 8,
//                   //     left: 15,
//                   //     right: 15,
//                   //   ),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //     children: [
//                   //       // PickTime(
//                   //       //   startDate: DateTime.now(),
//                   //       //   endDate: DateTime.now(),
//                   //       //   focusedStartDay: (value) {},
//                   //       //   focusedLastDay: (value) {
//                   //       //     print(value);
//                   //       //   },
//                   //       // ),
//                   //       Container(
//                   //         height: 40,
//                   //         width: 100,
//                   //         padding: EdgeInsets.all(8),
//                   //         decoration: BoxDecoration(
//                   //           borderRadius: BorderRadius.circular(5),
//                   //           color: Colors.white,
//                   //           boxShadow: [
//                   //             BoxShadow(
//                   //               color: Colors.grey.withOpacity(0.5),
//                   //               spreadRadius: 2,
//                   //               blurRadius: 5,
//                   //               offset:
//                   //                   Offset(0, 3), // changes position of shadow
//                   //             ),
//                   //           ],
//                   //         ),
//                   //         child: DropdownButton<String>(
//                   //           value: dropdownFarm,
//                   //           icon: const Icon(Icons.arrow_drop_down),
//                   //           iconSize: 24,
//                   //           elevation: 16,
//                   //           style: GoogleFonts.kanit(
//                   //               textStyle: TextStyle(color: Colors.black)),
//                   //           underline: Container(
//                   //             height: 2,
//                   //             color: Colors.transparent,
//                   //           ),
//                   //           onChanged: (String newValue) {
//                   //             print(newValue);
//                   //             // setState(() {
//                   //             //   dropdownFarm = newValue;
//                   //             // });
//                   //           },
//                   //           items: [
//                   //             "แปลงที่ 1",
//                   //             "แปลงที่ 2",
//                   //             "แปลงที่ 3",
//                   //           ].map<DropdownMenuItem<String>>((value) {
//                   //             return DropdownMenuItem<String>(
//                   //               value: value,
//                   //               child: Text(
//                   //                 value,
//                   //                 style: GoogleFonts.kanit(
//                   //                   textStyle: TextStyle(color: Colors.black),
//                   //                 ),
//                   //                 textAlign: TextAlign.center,
//                   //               ),
//                   //             );
//                   //           }).toList(),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   // titleListWidget,
//                   Container(
//                     padding: EdgeInsets.only(
//                       top: 8,
//                       left: 15,
//                       right: 15,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // PickTime(
//                         //   startDate: DateTime.now(),
//                         //   endDate: DateTime.now(),
//                         //   focusedStartDay: (value) {},
//                         //   focusedLastDay: (value) {
//                         //     print(value);
//                         //   },
//                         // ),
//                         Container(
//                           height: 40,
//                           // width: 100,
//                           constraints: BoxConstraints(minWidth: 100),
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: DropdownButton<LastCurrentYear>(
//                             value: plotListBloc.yearSelected,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             iconSize: 24,
//                             elevation: 16,
//                             style: GoogleFonts.kanit(
//                                 textStyle: TextStyle(color: Colors.black)),
//                             underline: Container(
//                               height: 2,
//                               color: Colors.transparent,
//                             ),
//                             onChanged: (LastCurrentYear newValue) {
//                               print(newValue);
//                               plotListBloc.add(UpdatePlotListYear(newValue));
//                               BlocProvider.of<PlotMapBloc>(context)
//                                   .add(LoadPlotMapInitial(newValue.value));
//                             },
//                             items: yearList
//                                 .map<DropdownMenuItem<LastCurrentYear>>(
//                                     (value) {
//                               return DropdownMenuItem<LastCurrentYear>(
//                                 value: value,
//                                 child: Text(
//                                   value.text,
//                                   style: GoogleFonts.kanit(
//                                     textStyle: TextStyle(color: Colors.black),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         // Container(
//                         //   height: 40,
//                         //   // width: 100,
//                         //   constraints: BoxConstraints(minWidth: 100),
//                         //   padding: EdgeInsets.all(8),
//                         //   decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(5),
//                         //     color: Colors.white,
//                         //     boxShadow: [
//                         //       BoxShadow(
//                         //         color: Colors.grey.withOpacity(0.5),
//                         //         spreadRadius: 2,
//                         //         blurRadius: 5,
//                         //         offset:
//                         //             Offset(0, 3), // changes position of shadow
//                         //       ),
//                         //     ],
//                         //   ),
//                         //   child: MaterialButton(
//                         //       onPressed: () {
//                         //         showDialog(
//                         //           context: context,
//                         //           barrierDismissible: true,
//                         //           builder: (BuildContext context) {
//                         //             return PickerWidget(
//                         //               data: sortData,
//                         //               valueChanged: (value) {
//                         //                 print(value);
//                         //                 plotListBloc
//                         //                     .add(SortPlotList(value, sortData));
//                         //               },
//                         //             );
//                         //           },
//                         //         );
//                         //       },
//                         //       child: Row(
//                         //         children: [
//                         //           Text("แปลงทั้งหมด "),
//                         //           Icon(Icons.arrow_drop_down),
//                         //         ],
//                         //       )),
//                         // )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0),
//                     child: Text(
//                       "แปลงอ้อยของฉัน",
//                     ),
//                   ),
//                   plotListWidget
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // var _selectedAgeIndex = 0;
//   // var scrollController = FixedExtentScrollController();
//   // var dropDownPickerItemHeight = 50.0;
//   // testPicker(BuildContext context) {
//   //   return CupertinoPicker(
//   //     key: Key("Age Picker"),
//   //     scrollController: scrollController,
//   //     itemExtent: dropDownPickerItemHeight,
//   //     backgroundColor: Theme.of(context).canvasColor,
//   //     onSelectedItemChanged: (int index) {},
//   //     children: List<Widget>.generate(sortData.length, (int index) {
//   //       return Center(
//   //         child: Text('${sortData[index].plotNo}'),
//   //       );
//   //     }),
//   //   );
//   // }
// }

// class RowData extends StatelessWidget {
//   RowData({
//     Key key,
//     @required this.leading,
//     @required this.content,
//     this.bit,
//     this.textColor = Colors.black,
//   }) : super(key: key);

//   String leading;
//   String content;
//   String bit;
//   Color textColor;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           leading,
//           style: TextStyle(
//             color: textColor,
//           ),
//         ),
//         Text(
//           content,
//           style: TextStyle(
//             color: textColor,
//           ),
//         ),
//         Text(
//           bit == null ? "" : bit,
//           style: TextStyle(
//             color: textColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
