import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;
import '../../../basic/pages/trr_basic_page.dart';
import '../../../basic/models/trr_object.dart';
import '../widgets/ccs_detail_widget.dart';

import '../models/ccs_detail_model.dart';

// ignore: must_be_immutable
class CcsHomePage extends TrrBasicPageStatefulWidget {
  CcsDetailList ccsDataList = dummyCcsDetailList();

  CcsHomePage({Key key, @required TrrData dataObj}) : super(key: key, dataObj: dataObj);

  @override
  _CcsHomePageState createState() => _CcsHomePageState();
}

class _CcsHomePageState extends TrrBasicPageState<CcsHomePage> {
  // DateTime dateNow = DateTime.now();
  DateTime _dateNow = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cons.kPageBackgroundColor,
        appBar: AppBar(
          title: Text('CCS รายวัน', style: TextStyle(fontSize: 26)),
          backgroundColor: cons.kSolidBlueColor,
        ),
        body: _ccsHomePageUI(),
      ),
    );
  }

  Widget _ccsHomePageUI() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _selectMonth(),
              _selectCalendar(),
              _ccsHeader(),
              _ccsList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ccsList() {
    return Container(
      color: cons.kPageBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // height: 600,
      height: dvHeight * 0.72,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.ccsDataList.ccsItems.length,
        itemBuilder: (context, index) {
          return CcsDetailItemWidget(ccsData: widget.ccsDataList.ccsItems[index]);
        },
      ),
    );
  }

  Widget _ccsHeader() {
    return Container(
      color: cons.kPageBackgroundColor,
      child: Container(
        width: dvWidth,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Text('แสดงข้อมูล CCS รายวัน', style: TextStyle(fontSize: 28)),
      ),
    );
  }

  Widget _selectMonth() {
    String curMonth = DateFormat('MMMM yyyy').format(_dateNow.toLocal());
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: cons.kGoldColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  curMonth,
                  // this.currAgricultureYearItem.agricultureYearCaption,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Image(image: AssetImage('assets/images/ccs/calendar.png'), width: 20, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectCalendar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        firstDay: DateTime(_dateNow.year - 20),
        lastDay: _dateNow,
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
        ),
      ),
    );
    // height: dvHeight * 0.6,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               // _selectDate(context);
    //             },
    //           ),
    //         ],
    //       ),
    //       TableCalendar(
    //         firstDay: DateTime(_dateNow.year - 20),
    //         lastDay: _dateNow,
    //         focusedDay: _focusedDay,
    //         calendarFormat: CalendarFormat.month,
    //         headerStyle: HeaderStyle(
    //           formatButtonVisible: false,
    //         ),
    //         // selectedDayPredicate: (day) {
    //         //   return isSameDay(_focusedDay, day);
    //         // },
    //         // onDaySelected: (selectedDay, focusedDay) {
    //         //   if (!isSameDay(_focusedDay, selectedDay)) {
    //         //     setState(() {
    //         //       _focusedDay = focusedDay;
    //         //     });
    //         //   }
    //         // },
    //       ),
    //     ],
    //   ),
    // );
  }
}
