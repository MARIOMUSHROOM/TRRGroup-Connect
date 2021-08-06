import 'package:ai_flutter/bloc/plot_state/function/check_null.dart';
import 'package:ai_flutter/bloc/plot_state/plot_list/bloc/plot_list_bloc.dart';
import 'package:ai_flutter/bloc/plot_state/plot_map/bloc/plot_map_bloc.dart';
import 'package:ai_flutter/home/station/model/group_year_model.dart';
import 'package:ai_flutter/home/station/model/plot_list_model.dart';
import 'package:ai_flutter/home/station/plot_detail_page.dart';
import 'package:ai_flutter/home/station/utils/colors.dart';
import 'package:ai_flutter/home/station/widget/picker_widget.dart';
import 'package:ai_flutter/home/station/widget/year_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PlotListPage extends StatelessWidget {
  PlotListPage({Key key}) : super(key: key);
  Widget plotListWidget = SizedBox();
  Widget titleListWidget = SizedBox();
  List<LastCurrentYear> yearList = [];

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    _plotListBloc.add(LoadPlotListInitial());
    print("refresh");
    return null;
  }

  PlotListBloc _plotListBloc;
  @override
  Widget build(BuildContext context) {
    _plotListBloc = BlocProvider.of<PlotListBloc>(context);
    return BlocBuilder<PlotListBloc, PlotListState>(
      builder: (context, state) {
        if (state is PlotListInitial) {
          plotListWidget = SizedBox();
          titleListWidget = SizedBox();
          _plotListBloc.add(LoadPlotListInitial());
        } else if (state is PlotListLoading) {
          plotListWidget = Column(
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
        } else if (state is PlotListError) {
          plotListWidget = Column(
            children: [
              Center(
                  child: Text(
                "การเชื่อมต่อมีปัญหา กรุณาลองใหม่อีกครั้งในภายหลัง",
                textAlign: TextAlign.center,
              )),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  onPressed: () {
                    _plotListBloc.add(LoadPlotListInitial());
                  },
                  child: Text("โหลดใหม่"),
                ),
              ),
            ],
          );
        } else if (state is PlotListNoData) {
          plotListWidget = Center(
              child: Text(
            "ไม่มีข้อมูล",
            textAlign: TextAlign.center,
          ));
        } else if (state is PlotYearListLoaded) {
          yearList = _plotListBloc.yearList;
          BlocProvider.of<PlotMapBloc>(context)
              .add(LoadPlotMapInitial(_plotListBloc.yearSelected.value));
        } else if (state is PlotListLoaded) {
          plotListWidget = Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _plotListBloc.showResult.length,
              itemBuilder: (context, index) {
                // StationReport only = stationList[index];
                StationDetail only = _plotListBloc.showResult[index];
                List yearSplit = only.yearPeriodStr.toString().split('');
                String yearString =
                    "${yearSplit[0]}${yearSplit[1]}/${yearSplit[2]}${yearSplit[3]}";
                // print("in view");
                // print(only.toJson());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlotDetailPage(only)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => first_learn()));
                      },
                      title: Container(
                        height: 120,
                        // color: Colors.red,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 110,
                                width: 80,
                                decoration: new BoxDecoration(
                                  // color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/station/ICON-M.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                // color: Colors.green,
                                padding: EdgeInsets.only(left: 10),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ปี $yearString",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RowData(
                                        leading: "แปลง : ",
                                        content: checkNull(only.plotNo),
                                        textColor: Colors.grey,
                                      ),
                                      RowData(
                                        leading: "พื้นที่ : ",
                                        content:
                                            only.areaSize.toStringAsFixed(0),
                                        bit: " ไร่",
                                        textColor: Colors.grey,
                                      ),
                                      RowData(
                                        leading: "อายุอ้อย : ",
                                        content: checkNull(only.sugarcaneAge),
                                        bit: " ปี",
                                        textColor: Colors.grey,
                                      ),
                                      RowData(
                                        leading: "พันธุ์อ้อย : ",
                                        content: checkNull(only.sugarcaneType),
                                        textColor: Colors.grey,
                                      ),
                                      RowData(
                                        leading: "ผลผลิตตัน/ไร่ : ",
                                        content: checkNull(only.productPerRai),
                                        bit: " ตัน",
                                        textColor: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Scaffold(
          backgroundColor: kblueBackgoundColor,
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          // width: 100,
                          constraints: BoxConstraints(minWidth: 100),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return YearPickerWidget(
                                    data: _plotListBloc.yearList,
                                    selectedData: _plotListBloc.yearSelected,
                                    valueChanged: (value) {
                                      print(value);
                                      _plotListBloc
                                          .add(UpdatePlotListYear(value));
                                      // BlocProvider.of<PlotMapBloc>(context)
                                      //     .add(LoadPlotMapInitial(value.value));
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(_plotListBloc.yearSelected == null
                                    ? '-'
                                    : _plotListBloc.yearSelected.text
                                        .toString()),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          // width: 100,
                          constraints: BoxConstraints(minWidth: 100),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    List<StationDetail> only =
                                        _plotListBloc.plotList;
                                    only.sort(
                                        (a, b) => a.plotNo.compareTo(b.plotNo));
                                    return PickerWidget(
                                      data: only,
                                      selectedData: _plotListBloc.plotSelected,
                                      valueChanged: (value) {
                                        if (value == null) {
                                          _plotListBloc
                                              .add(ClearSortPlotList());
                                        } else {
                                          print(value.plotNo);
                                          _plotListBloc
                                              .add(SortPlotList(value));
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text(_plotListBloc.plotSelectedText
                                      .toString()),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  plotListWidget,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RowData extends StatelessWidget {
  RowData({
    Key key,
    @required this.leading,
    @required this.content,
    this.bit,
    this.textColor = Colors.black,
  }) : super(key: key);

  String leading;
  String content;
  String bit;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          leading,
          style: TextStyle(
            color: textColor,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            color: textColor,
          ),
        ),
        Text(
          bit == null ? "" : bit,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
