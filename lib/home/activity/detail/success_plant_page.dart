import 'dart:convert';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/bloc/activity_state/success_plant/bloc/success_plant_bloc.dart';
import 'package:ai_flutter/home/activity/test/test_data.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SuccessPlantPage extends StatefulWidget {
  SuccessPlantPage(this._inputActivityForm, this.activityText);
  InputActivityForm _inputActivityForm;
  String activityText;
  @override
  _SuccessPlantPageState createState() =>
      _SuccessPlantPageState(this._inputActivityForm, this.activityText);
}

class _SuccessPlantPageState extends State<SuccessPlantPage> {
  _SuccessPlantPageState(this._inputActivityForm, this.activityText);
  InputActivityForm _inputActivityForm;
  String activityText;

  var concatenate = StringBuffer();
  initData() {
    _inputActivityForm.plot_detail.forEach((item) {
      concatenate.write(item.plot_name + ", ");
    });
    _inputActivityForm.activity_step = activityText;
  }

  String dropdownStartDate = "1 ธ.ค. 2563";
  String dropdownEndDate = "31 ธ.ค. 2564";
  String dropdownFarm;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);

    await Future.delayed(Duration(seconds: 2));
    _successPlantBloc.add(
      LoadSuccessPlantData(_inputActivityForm),
    );
    print("refresh");
    return null;
  }

  Future<void> submitData(BuildContext context) async {
    print(_inputActivityForm.activity_type);
    try {
      String station = stationSelectedtoString(_inputActivityForm.plot_detail);
      int sugarcraneIndex =
          sugarCaneTypeChange(_inputActivityForm.activity_type);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Container(
                width: 200,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("กำลังบันทึก..."),
                  ],
                ),
              ),
            );
          });
      var response = await ActivityAPI().saveSuccessProcess(
        idUser: 1,
        plot: station,
        year: "63/64",
        idSugarcraneType: sugarcraneIndex,
        status: "1",
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // var res = json.decode(response.body);
        // print(res);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  width: 200,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("บันทึกสำเร็จ"),
                    ],
                  ),
                ),
              );
            });
        await Future.delayed(Duration(milliseconds: 2000)).then((_) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }
      // Navigator.of(context).pop();
    } catch (e) {
      print("error: $e");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 1)).then((_) {
            Navigator.pop(context);
          });
          return AlertDialog(
            content: Container(
              width: 180,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ทำรายการไม่สำเร็จ"),
                  Text("กรุณาลองใหม่อีกครั้ง..."),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  SuccessPlantBloc _successPlantBloc;
  @override
  Widget build(BuildContext context) {
    _successPlantBloc = BlocProvider.of<SuccessPlantBloc>(context);
    return BlocBuilder<SuccessPlantBloc, SuccessPlantState>(
      builder: (context, state) {
        if (state is SuccessPlantInitial) {
          _successPlantBloc.add(
            LoadSuccessPlantData(_inputActivityForm),
          );
        } else if (state is SuccessPlantNoData) {
          return Column(
            children: [
              Container(
                // height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: _successPlantBloc.title == null
                    ? Text("กำลังโหลดข้อมูล")
                    : Text(_successPlantBloc.title),
              ),
              Text("ไม่มีข้อมูล"),
            ],
          );
        } else if (state is SuccessPlantError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: 50,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: _successPlantBloc.title == null
                      ? Text("กำลังโหลดข้อมูล")
                      : Text(_successPlantBloc.title),
                ),
                Text(
                  "ไม่สามารถทำรายการได้ กรุณาลองใหม่อีกครั้ง : ",
                  maxLines: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _successPlantBloc.add(
                      LoadSuccessPlantData(_inputActivityForm),
                    );
                  },
                  color: Colors.grey,
                  child: Text("โหลดอีกครั้ง"),
                ),
              ],
            ),
          );
        } else if (state is SuccessPlantLoaded) {
          return Scaffold(
            body: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // height: 50,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        _successPlantBloc.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              _successPlantBloc.activityProcessList.length,
                          itemBuilder: (context, index) {
                            ActivityProcess only =
                                _successPlantBloc.activityProcessList[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            only.title.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          Text(
                                            only.date.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: VerticalDivider(
                                        // color: Colors.red,
                                        width: 20,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Container(
                                        constraints:
                                            BoxConstraints(minHeight: 60),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Text(only.content),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 180,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              height: 180,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "คุณแน่ใจหรือไม่ที่จะยืนยันการเสร็จสิ้นของกิจกรรมทั้งหมดใน ปี 62/63",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 15,
                      bottom: 15,
                    ),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'คำอธิบาย',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '1. ระบบจะทำการบันทึกกิจกรรมทั้งหมดในปี XX/XX',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          '2. ระบบจะทำการรีเซ็ตกิจกรรมทั้งหมด เพื่อเริ่มต้นกิจกรรมใหม่ในปีต่อไป',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 120,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // border: Border.all(
                                                //   color: Colors.blueAccent,
                                                // ),
                                              ),
                                              child: FlatButton(
                                                child: const Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: FlatButton(
                                                child: const Text(
                                                  'ตกลง',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await submitData(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // actions: <Widget>[

                              // ],
                            ),
                          );
                        },
                        child: Text(
                          "เสร็จสิ้นกิจกรรมทั้งหมด",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
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
      },
    );
  }
}
