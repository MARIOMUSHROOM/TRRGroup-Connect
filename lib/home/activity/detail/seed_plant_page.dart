import 'dart:convert';

import 'package:ai_flutter/bloc/activity_state/seed_plant/bloc/seed_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/set_plant/bloc/set_plant_bloc_bloc.dart';
import 'package:ai_flutter/home/activity/detail/input_seed_plant_page.dart';
import 'package:ai_flutter/home/activity/model/seed_plant_model.dart';
import 'package:ai_flutter/home/activity/test/test_data.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/widget/activity_add_button_widget.dart';
import 'package:ai_flutter/home/activity/widget/pick_time.dart';
import 'package:ai_flutter/home/activity/widget/time_line_widget.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SeedPlantPage extends StatelessWidget {
  SeedPlantPage(this._inputActivityForm, this.activityText);
  InputActivityForm _inputActivityForm;
  String activityText;
  String title;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    _seedPlantBloc.add(
      LoadSeedPlantData(_inputActivityForm),
    );
    print("refresh");
    return null;
  }

  Future<void> editButton(BuildContext context, var value) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(seconds: 2)).then((_) {
              Navigator.pop(context);
            });
            return AlertDialog(
              content: Container(
                width: 180,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("กำลังทำรายการ..."),
                  ],
                ),
              ),
            );
          });
      var rs =
          await ActivityAPI().getGrowData(_seedPlantBloc.historyList[value].id);
      var jsonRes = json.decode(rs.body);
      SeedPlantModel seedPlantEdit = SeedPlantModel.fromJson(jsonRes[0]);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InputSeedPlantPage(
            _inputActivityForm,
            activityText,
            seedPlantEdit,
          ),
        ),
      );
    } catch (e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(seconds: 2)).then((_) {
              Navigator.pop(context);
            });
            return AlertDialog(
              content: Container(
                width: 180,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ไม่สามารถทำรายการได้"),
                    Text("กรุณาลองใหม่อีกครั้ง..."),
                  ],
                ),
              ),
            );
          });
    }
  }

  SeedPlantBloc _seedPlantBloc;
  @override
  Widget build(BuildContext context) {
    _seedPlantBloc = BlocProvider.of<SeedPlantBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<SeedPlantBloc, SeedPlantState>(
                builder: (context, state) {
                  Widget widgetBox = SizedBox();
                  if (state is SeedPlantInitial) {
                    _seedPlantBloc.add(
                      LoadSeedPlantData(_inputActivityForm),
                    );
                  } else if (state is SeedPlantLoaded) {
                    title = _seedPlantBloc.title + " / $activityText";
                    widgetBox = Column(
                      children: [
                        ListViewTimeLineWidget(
                          data: _seedPlantBloc.historyList,
                          onEditClick: (value) async {
                            await editButton(context, value);
                          },
                          onDeleteClick: (value) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("ยืนยันการลบรายการ"),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          _seedPlantBloc.add(DeleteSeedPlant(
                                              _seedPlantBloc
                                                  .historyList[value].id));
                                          Navigator.pop(context);
                                        },
                                        color: Colors.red,
                                        child: Text(
                                          "ลบรายการ",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.grey[200],
                                          child: Text("ยกเลิก")),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    );
                  } else if (state is SeedPlantNoData) {
                    widgetBox = Column(
                      children: [
                        Text("ไม่มีข้อมูล"),
                      ],
                    );
                  } else if (state is SeedPlantError) {
                    widgetBox = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "ไม่สามารถทำรายการได้ กรุณาลองใหม่อีกครั้ง : ",
                            maxLines: 10,
                          ),
                          FlatButton(
                            onPressed: () {
                              _seedPlantBloc.add(
                                LoadSeedPlantData(_inputActivityForm),
                              );
                            },
                            color: Colors.grey,
                            child: Text("โหลดอีกครั้ง"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is SeedPlantLoading) {
                    widgetBox = Column(
                      children: [
                        Center(
                          child: new Container(
                            height: 50,
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        ),
                        new Center(child: Text("Loading...")),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Container(
                        // height: 50,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: title == null
                            ? Text(
                                "กำลังโหลดข้อมูล",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _seedPlantBloc.startDate == null
                              ? SizedBox()
                              : PickTime(
                                  startDate: _seedPlantBloc.startDate,
                                  endDate: _seedPlantBloc.endDate,
                                  focusedStartDay: (value) {
                                    _seedPlantBloc
                                        .add(UpdateSeedPlantStartDate(value));
                                  },
                                  focusedLastDay: (value) {
                                    print(value);
                                    _seedPlantBloc
                                        .add(UpdateSeedPlantEndDate(value));
                                  },
                                ),
                          _seedPlantBloc.stationSelect == null
                              ? SizedBox()
                              : Container(
                                  height: 40,
                                  width: 100,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton<PlotDetail>(
                                    value: _seedPlantBloc.stationSelect,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: GoogleFonts.kanit(
                                        textStyle:
                                            TextStyle(color: Colors.black)),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (PlotDetail newValue) {
                                      _seedPlantBloc.add(
                                          UpdateSeedPlantStation(newValue));
                                    },
                                    items: _seedPlantBloc.stationList
                                        .map<DropdownMenuItem<PlotDetail>>(
                                            (PlotDetail value) {
                                      return DropdownMenuItem<PlotDetail>(
                                        value: value,
                                        child: Text(
                                          value.plot_name,
                                          style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widgetBox
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ActivityAddButtonWidget(
        inputActivityForm: _inputActivityForm,
        activityText: activityText,
        onPressed: () {
          print(activityText);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InputSeedPlantPage(
                      _inputActivityForm, activityText, null)));
        },
      ),
    );
  }
}
