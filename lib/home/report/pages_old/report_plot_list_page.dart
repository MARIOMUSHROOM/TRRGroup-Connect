import 'package:flutter/material.dart';
import '../../../base_class/pages/ai_base_page.dart';
import '../report_utils.dart' as rputil;
import '../report_const.dart' as rpcons;
import '../models/report_activity_model.dart';
import '../models/agriculture_year_model.dart';
import 'package:intl/intl.dart';
import '../../../global_utils.dart' as util;

class ReportPlotListPage extends AiBaseStatefulWidget {
  // final List<ReportPlotItem> userPlotList;
  final ReportPlotList userPlotList;
  final rputil.NotifyOnReportPlotItemTapCallBack onPlotTap;
  final AgricultureYearList agYearList;

  ReportPlotListPage({
    Key key,
    @required this.userPlotList,
    @required this.agYearList,
    @required this.onPlotTap,
  }) : super(key: key);

  @override
  _ReportPlotListPageState createState() => _ReportPlotListPageState();
}

class _ReportPlotListPageState extends AiBaseState<ReportPlotListPage> {
  int initThaiYear = DateTime.now().year + 543;
  AgricultureYearItem currAgricultureYearItem;
  int animDelay = 0;

  @override
  void initState() {
    super.initState();
    currAgricultureYearItem = widget.agYearList.itemByYear(initThaiYear);
  }

  @override
  Widget build(BuildContext context) {
    return _reportPlotListPageUI();
  }

  Widget _reportPlotListPageUI() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _searchTextField(),
          _selectAgricultureYear(),
          _selectCaption(),
          Divider(thickness: 1, color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemCount: widget.userPlotList.plotItems.length,
              itemBuilder: (ctx, index) {
                // animDelay += 1;
                return util.horizontalAnimation(
                  ReportPlotItemWidget(
                    plotItem: widget.userPlotList.plotItems[index],
                    onPlotItemTap: widget.onPlotTap,
                  ),
                  aMilliseconds: 200 + animDelay,
                  aStartPosition: 400,
                );
              },
            ),
          ),
          _allPlotSummary(),
        ],
      ),
    );
  }

  Widget _selectAgricultureYear() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: rpcons.kGoldColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  this.currAgricultureYearItem.agricultureYearCaption,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Image(
                      image: AssetImage('assets/images/report/calendar.png'),
                      width: 20,
                      fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectCaption() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Text('เลือกแปลงที่ต้องการ', style: TextStyle(fontSize: 24)),
    );
  }

  Widget _allPlotSummary() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        height: 70,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: rpcons.kSummaryBgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ปริมาณอ้อยรวมทั้งหมดทุกแปลง',
                  style: TextStyle(fontSize: 24)),
              Text(
                  '${NumberFormat('###.##').format(widget.userPlotList.productSummary)} ตัน',
                  style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _searchTextField() {
  //   return Container(
  //     height: 50,
  //     padding: EdgeInsets.only(top: 10, left: 20, right: 20),
  //     child: TextField(
  //       autocorrect: false,
  //       style: rputil.ggKanit(TextStyle(color: Colors.black)),
  //       onSubmitted: (_input) {
  //         setState(() {});
  //       },
  //       decoration: InputDecoration(
  //         filled: true,
  //         fillColor: Colors.grey[300],
  //         prefixIcon: Icon(Icons.search, color: Colors.black),
  //         labelStyle: TextStyle(color: Colors.black),
  //         labelText: 'ค้นหา',
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide.none,
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           // borderSide: BorderSide(color: Colors.grey),
  //           borderSide: BorderSide.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class ReportPlotItemWidget extends StatelessWidget {
  final ReportPlotItem plotItem;
  final rputil.NotifyOnReportPlotItemTapCallBack onPlotItemTap;
  ReportPlotItemWidget({Key key, this.plotItem, this.onPlotItemTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Material(
            child: InkWell(
              onTap: () => onPlotItemTap(plotItem),
              child: Ink(
                child: Container(
                  height: 32,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        child: VerticalDivider(
                            thickness: 5, color: rpcons.kGoldColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          plotItem.plotName,
                          // style: rputil.ggKanit(TextStyle(fontSize: 20, color: Colors.black54)),
                          style:
                              TextStyle(fontSize: 24, color: Colors.grey[600]),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(Icons.keyboard_arrow_right_outlined,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.black54),
        ],
      ),
    );
  }
}
