// import 'dart:convert';

// import 'package:ai_flutter/bloc/activity_state/chemicalspray_plant/bloc/chemical_spray_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/cut_plant/bloc/cut_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
// import 'package:ai_flutter/bloc/activity_state/manure_plant/bloc/manure_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/seed_plant/bloc/seed_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/set_plant/bloc/set_plant_bloc_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/ship_plant/bloc/ship_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/success_plant/bloc/success_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/water_plant/bloc/water_plant_bloc.dart';
// import 'package:ai_flutter/bloc/activity_state/waterspray_plant/bloc/water_spray_plant_bloc.dart';
// import 'package:ai_flutter/home/activity/new_plant_info_page.dart';
// import 'package:ai_flutter/home/activity/old_plant_info_page.dart';
// import 'package:ai_flutter/home/activity/setting_mix_type_page.dart';
// import 'package:ai_flutter/home/activity/model/local_model.dart';
// import 'package:ai_flutter/home/activity/utils/colors.dart';
// import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
// import 'package:ai_flutter/provider/activity_api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SelectPlotPage extends StatefulWidget {
//   SelectPlotPage(this.typeSelected);
//   String typeSelected;
//   @override
//   _SelectPlotPageState createState() => _SelectPlotPageState();
// }

// class _SelectPlotPageState extends State<SelectPlotPage> {
//   List<SelectPlot> selectedFarmList = new List();
//   List<SelectPlot> _searchResult = [];
//   List<PlotDetail> _selectedResult = new List();
//   TextEditingController searchController = TextEditingController();
//   InputActivityForm inputActivityForm = new InputActivityForm();
//   String yearSelected;
//   List<String> yearList = [];
//   bool isLoading = false;

//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     print(text);
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//     selectedFarmList.forEach((e) {
//       if (e.plotName.contains(text)) _searchResult.add(e);
//     });
//     setState(() {});
//   }

//   void selectedData() {
//     _selectedResult = new List();
//     for (var i = 0; i < selectedFarmList.length; i++) {
//       if (selectedFarmList[i].select) {
//         PlotDetail onlyStation = new PlotDetail();
//         onlyStation.plot_index = i;
//         onlyStation.plot_id = selectedFarmList[i].plotNumber;
//         onlyStation.plot_name = selectedFarmList[i].plotName;
//         setState(() {
//           _selectedResult.add(onlyStation);
//         });
//       }
//     }
//   }

//   Future<void> initData() async {
//     yearSelected = "63/64";
//     await loadYearFromAPI();
//     await loadPlotFromAPI("63_64");
//     // for (var i = 0; i < 15; i++) {
//     //   SelectPlot newSelect = new SelectPlot();
//     //   newSelect.farmName = "แปลงที่ $i";
//     //   newSelect.select = false;
//     //   newSelect.status = 0;
//     //   selectedFarmList.add(newSelect);
//     // }
//     print("initData");
//   }

//   Future<void> loadYearFromAPI() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       var rs = await ActivityAPI().getYearActivity();
//       var jsonRes = json.decode(rs.body);
//       if (jsonRes.isNotEmpty) {
//         print(jsonRes);
//         for (var i = 0; i < jsonRes.length; i++) {
//           String year = jsonRes[i]["year"];
//           setState(() {
//             yearList.add(year);
//             isLoading = false;
//           });
//         }
//       } else {
//         print("no data");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> loadPlotFromAPI(String year) async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       int sugarCaneType = sugarCaneTypeChange(widget.typeSelected);
//       // var rs = await ActivityAPI().getPlotActivity(year, sugarCaneType);
//       var rs = await ActivityAPI().getPlotActivity();
//       var jsonRes = json.decode(rs.body);
//       if (jsonRes.isNotEmpty) {
//         print(jsonRes);
//         selectedFarmList = new List();
//         for (var i = 0; i < jsonRes["data"].length; i++) {
//           SelectPlot newSelect = new SelectPlot();
//           int plot = jsonRes["data"][i]["plot_no"];
//           int status = 0;
//           // int status = jsonRes[i]["status"];
//           newSelect.plotName = "แปลงที่ $plot";
//           newSelect.plotNumber = plot;
//           newSelect.select = false;
//           newSelect.status = status;
//           setState(() {
//             selectedFarmList.add(newSelect);
//             isLoading = false;
//           });
//         }
//       } else {
//         print("no data");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void callInitialBlocAndNavigatorPush(MaterialPageRoute route) {
//     BlocProvider.of<SetPlantBlocBloc>(context).add(LoadSetPlantInitial());
//     BlocProvider.of<SeedPlantBloc>(context).add(LoadSeedPlantInitial());
//     BlocProvider.of<WaterPlantBloc>(context).add(LoadWaterPlantInitial());
//     BlocProvider.of<WaterSprayPlantBloc>(context)
//         .add(LoadWaterSprayPlantInitial());
//     BlocProvider.of<ChemicalSprayPlantBloc>(context)
//         .add(LoadChemicalSprayPlantInitial());
//     BlocProvider.of<ManurePlantBloc>(context).add(LoadManurePlantInitial());
//     BlocProvider.of<CutPlantBloc>(context).add(LoadCutPlantInitial());
//     BlocProvider.of<ShipPlantBloc>(context).add(LoadShipPlantInitial());
//     BlocProvider.of<SuccessPlantBloc>(context).add(LoadSuccessPlantInitial());
//     Navigator.push(context, route);
//   }

//   void initState() {
//     initData();
//     // loadYearFromAPI();
//     // loadPlotFromAPI();
//     super.initState();
//   }

//   @override
//   double _height;
//   double _width;
//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(new FocusNode());
//       },
//       child: Scaffold(
//         appBar: AppBarWidget(
//           appBar: AppBar(),
//           titleText: 'แปลงทั้งหมดของคุณ',
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 60,
//                     width: _width,
//                     // color: Colors.grey[200],
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       child: TextFormField(
//                         autofocus: false,
//                         style: TextStyle(
//                           fontSize: 15.0,
//                         ),
//                         keyboardType: TextInputType.text,
//                         controller: searchController,
//                         onEditingComplete: () =>
//                             FocusScope.of(context).nextFocus(),
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           hintText: "ชื่อแปลง",
//                           prefixIcon: Icon(Icons.search),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 0.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                         onChanged: (value) {
//                           onSearchTextChanged(value);
//                         },
//                       ),
//                     ),
//                   ),
//                   // Text(
//                   //   "ปี 63/64",
//                   //   style: TextStyle(
//                   //       // fontSize: 18,
//                   //       ),
//                   //   textAlign: TextAlign.start,
//                   // ),
//                   yearList.isEmpty
//                       ? SizedBox()
//                       : Container(
//                           height: 40,
//                           width: 100,
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
//                           child: DropdownButton<String>(
//                             value: yearSelected,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             iconSize: 24,
//                             elevation: 16,
//                             style: GoogleFonts.kanit(
//                                 textStyle: TextStyle(color: Colors.black)),
//                             underline: Container(
//                               height: 2,
//                               color: Colors.transparent,
//                             ),
//                             onChanged: (String newValue) {
//                               List newForm = newValue.split("/");
//                               print(newForm);
//                               loadPlotFromAPI("${newForm[0]}_${newForm[1]}");
//                             },
//                             items: yearList
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(
//                                   "ปี $value",
//                                   style: GoogleFonts.kanit(
//                                     textStyle: TextStyle(color: Colors.black),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                   SizedBox(height: 10),
//                   // Text(
//                   //   yearList[0],
//                   //   style: TextStyle(
//                   //       // fontSize: 18,
//                   //       ),
//                   //   textAlign: TextAlign.start,
//                   // ),
//                   Container(
//                     color: Colors.red[100],
//                     width: _width,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "*สามารถเลือกแปลงได้มากกว่า 1 แปลง เพื่อบันทึกกิจกรรม",
//                       style: TextStyle(
//                         // fontSize: 15,
//                         color: Colors.red,
//                       ),
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: isLoading
//                   ? Center(
//                       child: new Container(
//                         height: 50,
//                         width: 50,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(),
//                           ],
//                         ),
//                       ),
//                     )
//                   : _searchResult.length != 0 ||
//                           searchController.text.isNotEmpty
//                       ? searchListView()
//                       : resultListView(),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//           ],
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Container(
//           padding: EdgeInsets.all(8),
//           width: _width * 0.8,
//           height: 60,
//           child: RawMaterialButton(
//             elevation: 2.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: new BorderRadius.circular(8.0),
//             ),
//             fillColor: Colors.green,
//             onPressed: () {
//               selectedData();
//               // print(selectedFarmList);
//               // print(_selectedResult);
//               if (_selectedResult.isNotEmpty) {
//                 inputActivityForm.activity_type = widget.typeSelected;
//                 inputActivityForm.plot_detail = _selectedResult;
//                 print(_selectedResult[0].plot_index);
//                 switch (widget.typeSelected) {
//                   case "อ้อยปลูกใหม่":
//                     // inputActivityForm.activity_type = widget.typeSelected;
//                     // inputActivityForm.station_detail = _selectedResult;
//                     callInitialBlocAndNavigatorPush(MaterialPageRoute(
//                         builder: (context) =>
//                             NewPlantInputPage(inputActivityForm)));
//                     break;
//                   case "อ้อยตอ":
//                     callInitialBlocAndNavigatorPush(MaterialPageRoute(
//                         builder: (context) =>
//                             OldPlantInputPage(inputActivityForm)));

//                     break;
//                   case "แปลงผสม":
//                     callInitialBlocAndNavigatorPush(MaterialPageRoute(
//                         builder: (context) =>
//                             SettingMixTypePage(inputActivityForm)));

//                     break;
//                   default:
//                 }
//               } else {
//                 showDialog<void>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('ข้อมูลไม่ถูกต้อง'),
//                       content: SingleChildScrollView(
//                         child: ListBody(
//                           children: <Widget>[
//                             Text('กรุณาเลือกรายการตามที่กำหนด'),
//                           ],
//                         ),
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           child: Text('ปิด'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//             },
//             child: Container(
//                 child: Text(
//               "ตกลง",
//               style: TextStyle(
//                 color: Colors.white,
//                 // fontSize: 20,
//               ),
//             )),
//             constraints: BoxConstraints.tightFor(
//               width: _width,
//               height: 56.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   ListView resultListView() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: selectedFarmList.length,
//       itemBuilder: (context, index) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CheckboxListTile(
//               title: Row(
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 5,
//                     decoration: BoxDecoration(
//                       color: kGoldColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(selectedFarmList[index].plotName),
//                 ],
//               ),
//               value: selectedFarmList[index].status == 0
//                   ? selectedFarmList[index].select
//                   : true,
//               activeColor: selectedFarmList[index].status == 0
//                   ? Colors.green
//                   : Colors.grey,
//               onChanged: (bool value) {
//                 if (selectedFarmList[index].status == 0) {
//                   setState(() {
//                     selectedFarmList[index].select =
//                         !selectedFarmList[index].select;
//                   });
//                 }
//               },
//             ),
//             Container(
//               height: 0.5,
//               child: Divider(),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   ListView searchListView() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: _searchResult.length,
//       itemBuilder: (context, index) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CheckboxListTile(
//               title: Row(
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 5,
//                     decoration: BoxDecoration(
//                       color: kGoldColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(_searchResult[index].plotName),
//                 ],
//               ),
//               value: _searchResult[index].status == 0
//                   ? _searchResult[index].select
//                   : true,
//               activeColor:
//                   _searchResult[index].status == 0 ? Colors.green : Colors.grey,
//               onChanged: (bool value) {
//                 if (_searchResult[index].status == 0) {
//                   setState(() {
//                     _searchResult[index].select = !_searchResult[index].select;
//                   });
//                 }
//               },
//             ),
//             Divider(),
//           ],
//         );
//       },
//     );
//   }
// }
