import 'dart:convert';

import 'package:ai_flutter/bloc/activity_state/chemicalspray_plant/bloc/chemical_spray_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/cut_plant/bloc/cut_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/manure_plant/bloc/manure_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/seed_plant/bloc/seed_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/set_plant/bloc/set_plant_bloc_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/ship_plant/bloc/ship_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/success_plant/bloc/success_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/water_plant/bloc/water_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/waterspray_plant/bloc/water_spray_plant_bloc.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/new_plant_info_page.dart';
import 'package:ai_flutter/home/activity/old_plant_info_page.dart';
import 'package:ai_flutter/home/activity/setting_mix_type_page.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/station/model/group_year_model.dart';
import 'package:ai_flutter/home/station/model/plot_list_model.dart';
import 'package:ai_flutter/provider/plot_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPlotPage extends StatefulWidget {
  SelectPlotPage(this.typeSelected, {Key key}) : super(key: key);
  String typeSelected;
  @override
  _SelectPlotPageState createState() => _SelectPlotPageState();
}

class _SelectPlotPageState extends State<SelectPlotPage> {
  PlotListModel plotListModel;

  List<StationDetail> plotList = [];
  List<StationDetail> plotListSelected = [];
  StationDetail plotSelected;
  String plotSelectedText;
  bool errorAPI = false;

  GroupYearModel groupYear;
  List<LastCurrentYear> yearList;
  LastCurrentYear yearSelected;

  TextEditingController searchController = TextEditingController();
  List<StationDetail> _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    print(text);
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    plotList.forEach((e) {
      if (e.plotNo.toString().contains(text)) _searchResult.add(e);
    });
    setState(() {});
  }

  _getYearFromAPI() async {
    try {
      var rsYear = await PlotAPI().getGroupYear();
      var jsonYearRes = json.decode(rsYear.body);
      setState(() {
        groupYear = GroupYearModel.fromJson(jsonYearRes);
        List dataForReversed = groupYear.data;
        yearList = dataForReversed.reversed.toList();
        yearSelected = yearList[0];
      });
    } catch (e) {
      setState(() {
        errorAPI = true;
      });
    }
  }

  _getPlotFromAPI() async {
    try {
      var rs = await PlotAPI().plotUser(yearSelected.value);
      var jsonRes = json.decode(rs.body);
      print(jsonRes);
      setState(() {
        plotListModel = PlotListModel.fromJson(jsonRes);
        plotList = plotListModel.data;
      });
    } catch (e) {
      setState(() {
        errorAPI = true;
      });
    }
  }

  List<PlotDetail> _selectedResult = new List();
  void selectedData() {
    _selectedResult = new List();
    for (var i = 0; i < plotListSelected.length; i++) {
      PlotDetail onlyStation = new PlotDetail();
      onlyStation.plot_index = i;
      onlyStation.plot_id = plotListSelected[i].plotNo;
      onlyStation.plot_name = "แปลงที่ ${plotListSelected[i].plotNo}";
      setState(() {
        _selectedResult.add(onlyStation);
      });
    }
  }

  void callInitialBlocAndNavigatorPush(MaterialPageRoute route) {
    BlocProvider.of<SetPlantBlocBloc>(context).add(LoadSetPlantInitial());
    BlocProvider.of<SeedPlantBloc>(context).add(LoadSeedPlantInitial());
    BlocProvider.of<WaterPlantBloc>(context).add(LoadWaterPlantInitial());
    BlocProvider.of<WaterSprayPlantBloc>(context)
        .add(LoadWaterSprayPlantInitial());
    BlocProvider.of<ChemicalSprayPlantBloc>(context)
        .add(LoadChemicalSprayPlantInitial());
    BlocProvider.of<ManurePlantBloc>(context).add(LoadManurePlantInitial());
    BlocProvider.of<CutPlantBloc>(context).add(LoadCutPlantInitial());
    BlocProvider.of<ShipPlantBloc>(context).add(LoadShipPlantInitial());
    BlocProvider.of<SuccessPlantBloc>(context).add(LoadSuccessPlantInitial());
    Navigator.push(context, route);
  }

  initData() async {
    await _getYearFromAPI();
    await _getPlotFromAPI();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBarWidget(
          appBar: AppBar(),
          titleText: 'แปลงทั้งหมดของคุณ',
        ),
        body: SingleChildScrollView(
          child: Center(
            child: errorAPI
                ? Center(
                    child: Text("การเชื่อมต่อมีปัญหา กรุณาลองใหม่อีกครั้ง"))
                : Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        // color: Colors.grey[200],
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.text,
                            controller: searchController,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "ชื่อแปลง",
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            onChanged: (value) {
                              onSearchTextChanged(value);
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              // width: 100,
                              constraints: BoxConstraints(minWidth: 80),
                              padding: EdgeInsets.all(8),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(5),
                              //   color: Colors.white,
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey.withOpacity(0.5),
                              //       spreadRadius: 2,
                              //       blurRadius: 5,
                              //       offset: Offset(0, 3), // changes position of shadow
                              //     ),
                              //   ],
                              // ),
                              child: MaterialButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return YearPickerWidget(
                                        data: yearList,
                                        selectedData: yearSelected,
                                        valueChanged: (value) async {
                                          print(value);
                                          setState(() {
                                            yearSelected = value;
                                          });
                                          await _getPlotFromAPI();
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(yearSelected == null
                                        ? '-'
                                        : yearSelected.text.toString()),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.red[100],
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "*สามารถเลือกแปลงได้มากกว่า 1 แปลง เพื่อบันทึกกิจกรรม",
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      _searchResult.length != 0 ||
                              searchController.text.isNotEmpty
                          ? searchListView()
                          : resultListView(),
                      // resultListView(),
                    ],
                  ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          height: 60,
          child: RawMaterialButton(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            fillColor: Colors.green,
            onPressed: () {
              selectedData();
              // print(selectedFarmList);
              // print(_selectedResult);
              if (_selectedResult.isNotEmpty) {
                InputActivityForm inputActivityForm = new InputActivityForm();
                inputActivityForm.activity_type = widget.typeSelected;
                inputActivityForm.plot_detail = _selectedResult;
                print(_selectedResult[0].plot_index);
                switch (widget.typeSelected) {
                  case "อ้อยปลูกใหม่":
                    // inputActivityForm.activity_type = widget.typeSelected;
                    // inputActivityForm.station_detail = _selectedResult;
                    callInitialBlocAndNavigatorPush(MaterialPageRoute(
                        builder: (context) =>
                            NewPlantInputPage(inputActivityForm)));
                    break;
                  case "อ้อยตอ":
                    callInitialBlocAndNavigatorPush(MaterialPageRoute(
                        builder: (context) =>
                            OldPlantInputPage(inputActivityForm)));

                    break;
                  case "แปลงผสม":
                    callInitialBlocAndNavigatorPush(MaterialPageRoute(
                        builder: (context) =>
                            SettingMixTypePage(inputActivityForm)));

                    break;
                  default:
                }
              } else {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ข้อมูลไม่ถูกต้อง'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('กรุณาเลือกรายการตามที่กำหนด'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('ปิด'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
                child: Text(
              "ตกลง",
              style: TextStyle(
                color: Colors.white,
                // fontSize: 20,
              ),
            )),
            constraints: BoxConstraints.tightFor(
              width: double.infinity,
              height: 56.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget resultListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: plotList.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Row(
                children: [
                  Container(
                    height: 30,
                    width: 5,
                    decoration: BoxDecoration(
                      color: kGoldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(plotList[index].plotNo.toString()),
                ],
              ),
              value: plotListSelected.contains(plotList[index]),
              activeColor: plotListSelected.contains(plotList[index])
                  ? Colors.green
                  : Colors.grey,
              onChanged: (value) {
                if (plotListSelected.contains(plotList[index])) {
                  setState(() {
                    plotListSelected.remove(plotList[index]);
                  });
                } else {
                  setState(() {
                    plotListSelected.add(plotList[index]);
                  });
                }
              },
            ),
            Container(
              height: 0.5,
              child: Divider(),
            ),
          ],
        );
      },
    );
  }

  ListView searchListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Row(
                children: [
                  Container(
                    height: 30,
                    width: 5,
                    decoration: BoxDecoration(
                      color: kGoldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(_searchResult[index].plotNo.toString()),
                ],
              ),
              value: plotListSelected.contains(_searchResult[index]),
              activeColor: plotListSelected.contains(_searchResult[index])
                  ? Colors.green
                  : Colors.grey,
              onChanged: (value) {
                if (plotListSelected.contains(_searchResult[index])) {
                  setState(() {
                    plotListSelected.remove(_searchResult[index]);
                  });
                } else {
                  setState(() {
                    plotListSelected.add(_searchResult[index]);
                  });
                }
              },
            ),
            Container(
              height: 0.5,
              child: Divider(),
            ),
          ],
        );
      },
    );
  }
}

class YearPickerWidget extends StatefulWidget {
  final List<LastCurrentYear> data;
  final LastCurrentYear selectedData;
  final ValueChanged<LastCurrentYear> valueChanged;
  YearPickerWidget(
      {Key key,
      @required this.data,
      @required this.selectedData,
      @required this.valueChanged})
      : super(key: key);
  @override
  _YearPickerWidgetState createState() => _YearPickerWidgetState();
}

class _YearPickerWidgetState extends State<YearPickerWidget> {
  int initialItem = 0;
  List<Widget> dataList = [];
  var scrollController = FixedExtentScrollController();
  setWidget() {
    for (var i = 0; i < widget.data.length; i++) {
      Widget next = Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          widget.data[i].text.toString(),
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
      dataList.add(next);
    }

    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data[i] == widget.selectedData) {
        initialItem = i;
      }
    }
    scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  void initState() {
    setWidget();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              widget.valueChanged(widget.data[initialItem]);
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 50,
              scrollController: scrollController,
              onSelectedItemChanged: (value) {
                setState(() {
                  initialItem = value;
                });
              },
              children: dataList,
            ),
          ),
        ),
      ),
    );
  }
}
