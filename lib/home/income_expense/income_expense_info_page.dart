import 'dart:math';

import 'package:ai_flutter/bloc/income_expense_state/income_expense_info/bloc/income_expense_info_bloc.dart';
import 'package:ai_flutter/global_const.dart';
import 'package:ai_flutter/home/income_expense/function.dart';
import 'package:ai_flutter/home/income_expense/model/expense_income_info_model.dart';
import 'package:ai_flutter/home/income_expense/widget/border_decoration_custom.dart';
import 'package:ai_flutter/home/income_expense/widget/custom_year_picker.dart';
import 'package:ai_flutter/home/income_expense/widget/column_text_data_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeExpenseInfoPage extends StatefulWidget {
  const IncomeExpenseInfoPage({Key key}) : super(key: key);

  @override
  _IncomeExpenseInfoPageState createState() => _IncomeExpenseInfoPageState();
}

class _IncomeExpenseInfoPageState extends State<IncomeExpenseInfoPage> {
  final Color leftBarColor = Colors.green;
  final Color rightBarColor = Colors.blue;
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  setChartInit() {
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 55, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  double maxValueChart;
  setNewChart(List<GraphDatum> data) {
    List<BarChartGroupData> dataList = new List();
    List<double> checkMaxList = new List();
    for (var i = 0; i < data.length; i++) {
      dataList.add(makeGroupData(
          i, data[i].expensesCost.toDouble(), data[i].inComeCost.toDouble()));
      checkMaxList.add(data[i].expensesCost.toDouble());
      checkMaxList.add(data[i].inComeCost.toDouble());
    }
    maxValueChart = checkMaxList.reduce(max).toDouble();
    // final barGroup1 = makeGroupData(0, 5, 12);
    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 55, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    // ];

    rawBarGroups = dataList;

    showingBarGroups = rawBarGroups;
  }

  @override
  void initState() {
    super.initState();
    setChartInit();
  }

  String selectedYear;
  final formatCurrency =
      new NumberFormat.currency(customPattern: '###,###,###');
  int touchedIndex = -1;
  Widget widgetBox = SizedBox();
  ExpenseIncomeInfo expenseIncome;
  double _height;
  double _width;
  IncomeExpenseInfoBloc _incomeExpenseInfoBloc;
  @override
  Widget build(BuildContext context) {
    _incomeExpenseInfoBloc = BlocProvider.of<IncomeExpenseInfoBloc>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return BlocBuilder<IncomeExpenseInfoBloc, IncomeExpenseInfoState>(
      builder: (context, state) {
        if (state is IncomeExpenseInfoInitial) {
          _incomeExpenseInfoBloc.add(LoadIncomeExpenseInitial());
        } else if (state is IncomeExpenseNoData) {
          widgetBox = Column(
            children: [
              Text("ไม่มีข้อมูล"),
            ],
          );
        } else if (state is IncomeExpenseError) {
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
                    _incomeExpenseInfoBloc.add(LoadIncomeExpenseInitial());
                  },
                  color: Colors.grey,
                  child: Text("โหลดอีกครั้ง"),
                ),
              ],
            ),
          );
        } else if (state is IncomeExpenseLoading) {
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
        } else if (state is IncomeExpenseLoaded) {
          expenseIncome = _incomeExpenseInfoBloc.expenseIncomeInfo;

          /// ตั้งค่ากราฟแท่ง
          setNewChart(expenseIncome.graphData);
          //
          widgetBox = Column(
            children: [
              Container(
                // height: 300,
                decoration: BorderDecorationCustom.shadow(),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "ยอดคงเหลือ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                parseNumber(expenseIncome.totalBalance),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " บาท",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "รายได้จากค่าอ้อยทั้งหมด",
                                      textAlign: TextAlign.start,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          parseNumber(
                                              expenseIncome.totalIncomeCost),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " บาท",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "รายจ่ายสะสมทั้งหมด",
                                      textAlign: TextAlign.start,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          parseNumber(
                                              expenseIncome.totalExpensesCost),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " บาท",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 200,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse) {
                                            setState(() {
                                              final desiredTouch =
                                                  pieTouchResponse.touchInput
                                                          is! PointerExitEvent &&
                                                      pieTouchResponse
                                                              .touchInput
                                                          is! PointerUpEvent;
                                              if (desiredTouch &&
                                                  pieTouchResponse
                                                          .touchedSection !=
                                                      null) {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSection
                                                    .touchedSectionIndex;
                                              } else {
                                                touchedIndex = -1;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 40,
                                          sections: showingSections()),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextColorWidget(
                                        text: "รายจ่าย",
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 5),
                                      TextColorWidget(
                                        text: "รายรับ",
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                // height: 80,
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: BorderDecorationCustom.shadow(),
                child: MaterialButton(
                  onPressed: () async {
                    // await showPicker();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text(
                      //   _incomeExpenseInfoBloc.expenseIncomeInfo.yearData[0]
                      //       .toString(),
                      //   style: TextStyle(
                      //     color: kGoldColor,
                      //   ),
                      // ),
                      Container(
                        height: 40,
                        width: 100,
                        // padding: EdgeInsets.all(8),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(5),
                        //   color: Colors.white,
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5),
                        //       spreadRadius: 2,
                        //       blurRadius: 5,
                        //       offset:
                        //           Offset(0, 3), // changes position of shadow
                        //     ),
                        //   ],
                        // ),
                        child: DropdownButton<String>(
                          value: _incomeExpenseInfoBloc.selectedYearFormAPI,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black)),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String newValue) {
                            _incomeExpenseInfoBloc
                                .add(UpdateYearIncomeExpense(newValue));
                          },
                          items: _incomeExpenseInfoBloc
                              .expenseIncomeInfo.yearData
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black),
                                  color: kGoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Text(_incomeExpenseInfoBloc.selectedYear),
                      SizedBox(width: 10),
                      Image(
                        image: AssetImage('assets/images/profile/calendar.png'),
                        color: kGoldColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                // height: 300,
                decoration: BorderDecorationCustom.shadow(),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "รายรับรายจ่ายทั้งหมด",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              // color: Colors.red,
                              height: _height * 0.3,
                              width: _width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    // const SizedBox(
                                    //   height: 38,
                                    // ),
                                    Expanded(
                                      child: BarChart(
                                        BarChartData(
                                          maxY: maxValueChart,
                                          gridData: FlGridData(
                                            show: true,
                                            checkToShowHorizontalLine:
                                                (double value) {
                                              for (int i = 0;
                                                  i < maxValueChart;) {
                                                i += 20000;
                                                value = i.toDouble();
                                                return value == i;
                                              }
                                            },
                                            getDrawingHorizontalLine: (value) =>
                                                FlLine(
                                              color: Colors.grey,
                                              strokeWidth: 1,
                                            ),
                                          ),
                                          barTouchData: BarTouchData(
                                              touchTooltipData:
                                                  BarTouchTooltipData(
                                                tooltipBgColor: Colors.grey,
                                                getTooltipItem:
                                                    (_a, _b, _c, _d) => null,
                                              ),
                                              touchCallback: (response) {}),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            leftTitles: SideTitles(
                                              showTitles: true,
                                              getTextStyles: (value) =>
                                                  const TextStyle(
                                                color: Color(0xff7589a2),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8,
                                              ),
                                              margin: 10,
                                              reservedSize: 10,
                                              getTitles: (value) {
                                                // double scale =
                                                //     maxValueChart / 10;
                                                // int offSet =
                                                //     (maxValueChart / 10).ceil();
                                                // print("offset");
                                                // print(offSet);
                                                // print("value");
                                                // print(value);
                                                for (var i = 0;
                                                    i <= maxValueChart;) {
                                                  if (value == i) {
                                                    return parseThousandNumber(
                                                        i);
                                                  }
                                                  i += 20000;
                                                }
                                                return '';
                                              },
                                            ),
                                            bottomTitles: SideTitles(
                                              showTitles: true,
                                              getTextStyles: (value) =>
                                                  const TextStyle(
                                                      color: Color(0xff7589a2),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 8),
                                              margin: 10,
                                              reservedSize: 10,
                                              getTitles: (double value) {
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return 'ปี ${expenseIncome.graphData[0].year}';
                                                  case 1:
                                                    return 'ปี ${expenseIncome.graphData[1].year}';
                                                  case 2:
                                                    return 'ปี ${expenseIncome.graphData[2].year}';
                                                  case 3:
                                                    return 'ปี ${expenseIncome.graphData[3].year}';
                                                  case 4:
                                                    return 'ปี ${expenseIncome.graphData[4].year}';

                                                  default:
                                                    return '';
                                                }
                                              },
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                              border: Border(
                                            top: BorderSide.none,
                                            right: BorderSide.none,
                                            left: BorderSide(width: 1),
                                            bottom: BorderSide(width: 1),
                                          )),
                                          groupsSpace: 10,
                                          barGroups: showingBarGroups,
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 12,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextColorWidget(
                                  text: "รายจ่าย",
                                  color: Colors.green,
                                ),
                                SizedBox(width: 5),
                                TextColorWidget(
                                  text: "รายรับ",
                                  color: Colors.blue,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BorderDecorationCustom.shadow(),
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ColumnTextData(
                        title: parseNumber(expenseIncome.plotSpace),
                        content: "พื้นที่เพาะปลูก",
                        bit: " ไร่",
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: ColumnTextData(
                        title: parseNumber(expenseIncome.expensesCost),
                        // title: parseNumber(77777777),
                        content: "ค่าใช้จ่าย",
                        bit: " บาท",
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: ColumnTextData(
                        title: parseNumber(expenseIncome.averageCost),
                        // title: parseNumber(null),
                        content: "ค่าใช้จ่ายเฉลี่ย",
                        bit: " บาท/ไร่",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                // height: 300,
                decoration: BorderDecorationCustom.shadow(),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("รายจ่ายจากการปลูกอ้อย"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                      pieTouchData: PieTouchData(
                                          touchCallback: (pieTouchResponse) {
                                        setState(() {
                                          final desiredTouch =
                                              pieTouchResponse.touchInput
                                                      is! PointerExitEvent &&
                                                  pieTouchResponse.touchInput
                                                      is! PointerUpEvent;
                                          if (desiredTouch &&
                                              pieTouchResponse.touchedSection !=
                                                  null) {
                                            touchedIndex = pieTouchResponse
                                                .touchedSection
                                                .touchedSectionIndex;
                                          } else {
                                            touchedIndex = -1;
                                          }
                                        });
                                      }),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 40,
                                      sections: showingSectionsTwo()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextColorWidget(
                                text: "ค่าไถและเตรียมดิน",
                                color: Colors.green[100],
                              ),
                              SizedBox(width: 5),
                              TextColorWidget(
                                text: "ค่าพันธุ์อ้อย",
                                color: Colors.blue[100],
                              ),
                              SizedBox(width: 5),
                              TextColorWidget(
                                text: "ค่าสารกำจัดแมลง",
                                color: Colors.orange[100],
                              ),
                              SizedBox(width: 5),
                              TextColorWidget(
                                text: "ค่าน้ำหนัก",
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5),
                              TextColorWidget(
                                text: "ค่าขนส่ง",
                                color: Colors.red[100],
                              ),
                              SizedBox(width: 5),
                              TextColorWidget(
                                text: "ค่าแรงงาน",
                                color: Colors.purple[100],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return ListView(
          padding: EdgeInsets.all(8),
          children: [
            widgetBox,
          ],
        );
      },
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;
        double income = expenseIncome.totalIncomeCost.toDouble();
        double expense = expenseIncome.totalExpensesCost.toDouble();
        final double size = isTouched ? 50 : 40;
        switch (i) {
          case 0:
            return PieChartSectionData(
              // รายรับ
              color: Colors.blue,
              value: income,
              title: '',
              radius: size,
              titleStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              // รายจ่าย
              color: Colors.green,
              value: expense,
              title: '',
              radius: size,
              titleStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }

  List<PieChartSectionData> showingSectionsTwo() {
    return List.generate(
      6,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;
        final double size = isTouched ? 50 : 40;
        final double fontsize = 10;
        switch (i) {
          case 0:
            return PieChartSectionData(
              // ค่าพันธุ์อ้อย
              color: Colors.blue[100],
              value: expenseIncome.pricePercent,
              title: '${expenseIncome.pricePercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              // ค่าขนส่ง
              color: Colors.red[100],
              value: expenseIncome.transportPercent,
              title: '${expenseIncome.transportPercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              // ค่าน้ำหนัก
              color: Colors.blue,
              value: expenseIncome.growerPercent,
              title: '${expenseIncome.growerPercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 3:
            return PieChartSectionData(
              // ไถและเตรียมดิน
              color: Colors.green[100],
              value: expenseIncome.tractorPercent,
              title: '${expenseIncome.tractorPercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 4:
            return PieChartSectionData(
              // ค่าแรงงาน
              color: Colors.purple[100],
              value: expenseIncome.laborPercent,
              title: '${expenseIncome.laborPercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 5:
            return PieChartSectionData(
              // ค่าฉีดสารกำจัดแมลง
              color: Colors.orange[100],
              value: expenseIncome.sprayPercent,
              title: '${expenseIncome.sprayPercent.toStringAsFixed(2)} %',
              radius: size,
              titleStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1,
          colors: [leftBarColor],
          width: width,
        ),
        BarChartRodData(
          y: y2,
          colors: [rightBarColor],
          width: width,
        ),
      ],
    );
  }

  showPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomYearPickerWidget(
            startTime: (value) {},
            lastTime: (value) {},
          );
        });
  }
}

class TextColorWidget extends StatelessWidget {
  TextColorWidget({
    Key key,
    @required this.text,
    @required this.color,
  }) : super(key: key);
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
