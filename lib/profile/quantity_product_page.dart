import 'package:ai_flutter/profile/test/test_data.dart';
import 'package:ai_flutter/profile/test/test_model.dart';
import 'package:ai_flutter/profile/widget/custom_year_picker.dart';
import 'package:ai_flutter/profile/widget/row_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global_const.dart' as cons;
import '../global_utils.dart' as util;
import '../basic/pages/trr_basic_page.dart';

class QuantityProductPage extends TrrBasicPageStatefulWidget {
  @override
  _QuantityProductPageState createState() => _QuantityProductPageState();
}

class _QuantityProductPageState extends TrrBasicPageState<QuantityProductPage> {
  int startYear = (DateTime.now().year + 543) - 1;
  int lastYear = DateTime.now().year + 543;

  List<ProductReport> sortResult = [];

  onSortChanged() async {
    print("in onSortChanged");
    sortResult.clear();
    for (var i = 0; i < productReportList.length; i++) {
      int year = productReportList[i].date.year + 543;
      print("in for");
      if (year <= lastYear && year >= startYear) {
        print("in if");
        setState(() {
          sortResult.add(productReportList[i]);
        });
      }
    }
    setState(() {});
    print("out onSortChanged");
  }

  showPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomYearPickerWidget(
            startTime: (value) {
              setState(() {
                startYear = value;
                onSortChanged();
                print("out");
              });
            },
            lastTime: (value) {
              setState(() {
                lastYear = value;
                onSortChanged();
              });
            },
          );
        });
  }

  int animMilliSec = 500;

  @override
  Widget internalBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cons.kSolidBlueColor,
        title: Text('ปริมาณผลผลิต', textAlign: TextAlign.center, style: TextStyle(fontSize: 26)),
        centerTitle: true,
      ),

      body: Container(
        color: cons.kPageBackgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await showPicker();
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder(), primary: cons.kGoldColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$startYear/$lastYear"),
                        SizedBox(width: 10),
                        Image(image: AssetImage('assets/images/profile/calendar.png')),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(child: Image(image: AssetImage('assets/images/profile/arrow_left.png'))),
                        SizedBox(width: 10),
                        GestureDetector(child: Image(image: AssetImage('assets/images/profile/arrow_right.png'))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  (sortResult.isNotEmpty)
                      ? Container(
                          color: cons.kPageBackgroundColor,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sortResult.length,
                            itemBuilder: (context, index) {
                              int yearThai = sortResult[index].date.year + 543;
                              animMilliSec += 200;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10), // Frame padding
                                child: util.horizontalAnimation(
                                  Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: FittedBox(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${yearThai - 1}/$yearThai", style: TextStyle(fontSize: 20)),
                                                  RowData(
                                                    leading: "ผลผลิต : ",
                                                    content: sortResult[index].product_real.toString(),
                                                    bit: " ตัน",
                                                  ),
                                                  RowData(
                                                    leading: "สัญญาอ้อย : ",
                                                    content: sortResult[index].product_ref.toString(),
                                                    bit: " ตัน",
                                                  ),
                                                  RowData(
                                                    leading: "จำนวนแปลง : ",
                                                    content: sortResult[index].station_total.toString(),
                                                    bit: " แปลง",
                                                  ),
                                                  RowData(
                                                    leading: "พื้นที่ทั้งหมด : ",
                                                    content: sortResult[index].area_total.toString(),
                                                    bit: " ไร่",
                                                  ),
                                                  RowData(
                                                    leading: "พื้นที่เข้าร่วมโครงการ BONSUCRO : ",
                                                    content: sortResult[index].area_bonsucro.toString(),
                                                    bit: " ไร่",
                                                  ),
                                                  RowData(
                                                    leading: "พื้นที่เข้าร่วมโครงการ GETS FARMING : ",
                                                    content: sortResult[index].area_gets.toString(),
                                                    bit: " ตัน",
                                                  ),
                                                  RowData(
                                                    leading: "ประมาณการณ์ผลผลิต : ",
                                                    content: sortResult[index].estimate_product.toString(),
                                                    bit: " ตัน/ไร่",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(height: 80, child: VerticalDivider(thickness: 0.5, color: Colors.grey)),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("ค่า CSS เฉลี่ย",
                                                    style: TextStyle(color: cons.kBlueColor, fontSize: 20, fontWeight: FontWeight.bold)),
                                                Text(sortResult[index].css_mean.toString(),
                                                    style: TextStyle(color: cons.kBlueColor, fontSize: 20, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  aMilliseconds: animMilliSec,
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          height: dvHeight * 0.7,
                          child: Align(child: Text('ไม่พบข้อมูลปีที่เลือก')),
                        ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         padding: EdgeInsets.symmetric(horizontal: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.max,
      //           children: [
      //             ElevatedButton(
      //               onPressed: () async {
      //                 await showPicker();
      //               },
      //               style: ElevatedButton.styleFrom(shape: StadiumBorder(), primary: cons.kGoldColor),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Text("$startYear/$lastYear"),
      //                   SizedBox(width: 10),
      //                   Image(image: AssetImage('assets/images/profile/calendar.png')),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               child: Row(
      //                 children: [
      //                   GestureDetector(child: Image(image: AssetImage('assets/images/profile/arrow_left.png'))),
      //                   SizedBox(width: 10),
      //                   GestureDetector(child: Image(image: AssetImage('assets/images/profile/arrow_right.png'))),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       (sortResult.isNotEmpty)
      //           ? Container(
      //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      //               child: ListView.builder(
      //                 physics: NeverScrollableScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemCount: sortResult.length,
      //                 itemBuilder: (context, index) {
      //                   int yearThai = sortResult[index].date.year + 543;
      //                   return Padding(
      //                     padding: const EdgeInsets.only(bottom: 10), // Frame padding
      //                     child: Card(
      //                       elevation: 3,
      //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(10),
      //                         child: Row(
      //                           children: [
      //                             Expanded(
      //                               flex: 8,
      //                               child: FittedBox(
      //                                 child: Column(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text("${yearThai - 1}/$yearThai", style: TextStyle(fontSize: 20)),
      //                                     RowData(
      //                                       leading: "ผลผลิต : ",
      //                                       content: sortResult[index].product_real.toString(),
      //                                       bit: " ตัน",
      //                                     ),
      //                                     RowData(
      //                                       leading: "สัญญาอ้อย : ",
      //                                       content: sortResult[index].product_ref.toString(),
      //                                       bit: " ตัน",
      //                                     ),
      //                                     RowData(
      //                                       leading: "จำนวนแปลง : ",
      //                                       content: sortResult[index].station_total.toString(),
      //                                       bit: " แปลง",
      //                                     ),
      //                                     RowData(
      //                                       leading: "พื้นที่ทั้งหมด : ",
      //                                       content: sortResult[index].area_total.toString(),
      //                                       bit: " ไร่",
      //                                     ),
      //                                     RowData(
      //                                       leading: "พื้นที่เข้าร่วมโครงการ BONSUCRO : ",
      //                                       content: sortResult[index].area_bonsucro.toString(),
      //                                       bit: " ไร่",
      //                                     ),
      //                                     RowData(
      //                                       leading: "พื้นที่เข้าร่วมโครงการ GETS FARMING : ",
      //                                       content: sortResult[index].area_gets.toString(),
      //                                       bit: " ตัน",
      //                                     ),
      //                                     RowData(
      //                                       leading: "ประมาณการณ์ผลผลิต : ",
      //                                       content: sortResult[index].estimate_product.toString(),
      //                                       bit: " ตัน/ไร่",
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(height: 80, child: VerticalDivider(thickness: 0.5, color: Colors.grey)),
      //                             Expanded(
      //                               flex: 3,
      //                               child: Column(
      //                                 mainAxisAlignment: MainAxisAlignment.center,
      //                                 children: [
      //                                   Text("ค่า CSS เฉลี่ย", style: TextStyle(color: cons.kBlueColor, fontSize: 20, fontWeight: FontWeight.bold)),
      //                                   Text(sortResult[index].css_mean.toString(),
      //                                       style: TextStyle(color: cons.kBlueColor, fontSize: 20, fontWeight: FontWeight.bold)),
      //                                 ],
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             )
      //           : Align(
      //               child: Text('ไม่พบข้อมูลปีที่เลือก'),
      //               alignment: Alignment.center,
      //             ),
      //     ],
      //   ),
      // ),
    );
  }
}

/*
            Container(
              padding: EdgeInsets.all(8),
              child: sortResult.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sortResult.length,
                      itemBuilder: (context, index) {
                        int yearThai = sortResult[index].date.year + 543;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${yearThai - 1}/$yearThai"),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RowData(
                                              leading: "ผลผลิต : ",
                                              content: sortResult[index].product_real.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "สัญญาอ้อย : ",
                                              content: sortResult[index].product_ref.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "จำนวนแปลง : ",
                                              content: sortResult[index].station_total.toString(),
                                              bit: " แปลง",
                                            ),
                                            RowData(
                                              leading: "พื้นที่ทั้งหมด : ",
                                              content: sortResult[index].area_total.toString(),
                                              bit: " ไร่",
                                            ),
                                            RowData(
                                              leading: "พื้นที่เข้าร่วมโครงการ BONSUCRO : ",
                                              content: sortResult[index].area_bonsucro.toString(),
                                              bit: " ไร่",
                                            ),
                                            RowData(
                                              leading: "พื้นที่เข้าร่วมโครงการ GETS FARMING : ",
                                              content: sortResult[index].area_gets.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "ประมาณการณ์ผลผลิต : ",
                                              content: sortResult[index].estimate_product.toString(),
                                              bit: " ตัน/ไร่",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("ค่า CSS เฉลี่ย", style: TextStyle(color: cons.kBlueColor)),
                                            Text(sortResult[index].css_mean.toString(), style: TextStyle(color: cons.kBlueColor)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productReportList.length,
                      itemBuilder: (context, index) {
                        int yearThai = productReportList[index].date.year + 543;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${yearThai - 1}/$yearThai"),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RowData(
                                              leading: "ผลผลิต : ",
                                              content: productReportList[index].product_real.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "สัญญาอ้อย : ",
                                              content: productReportList[index].product_ref.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "จำนวนแปลง : ",
                                              content: productReportList[index].station_total.toString(),
                                              bit: " แปลง",
                                            ),
                                            RowData(
                                              leading: "พื้นที่ทั้งหมด : ",
                                              content: productReportList[index].area_total.toString(),
                                              bit: " ไร่",
                                            ),
                                            RowData(
                                              leading: "พื้นที่เข้าร่วมโครงการ BONSUCRO : ",
                                              content: productReportList[index].area_bonsucro.toString(),
                                              bit: " ไร่",
                                            ),
                                            RowData(
                                              leading: "พื้นที่เข้าร่วมโครงการ GETS FARMING : ",
                                              content: productReportList[index].area_gets.toString(),
                                              bit: " ตัน",
                                            ),
                                            RowData(
                                              leading: "ประมาณการณ์ผลผลิต : ",
                                              content: productReportList[index].estimate_product.toString(),
                                              bit: " ตัน/ไร่",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("ค่า CSS เฉลี่ย"),
                                            Text(productReportList[index].css_mean.toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
            ),
            */
