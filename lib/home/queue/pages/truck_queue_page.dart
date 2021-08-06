import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../queue_const.dart' as qcons;
// import '../queue_utils.dart' as qutil;
import '../../../global_const.dart' as cons;
import '../models/truck_queue_model.dart';
import '../../../global_utils.dart' as util;
import 'package:intl/date_symbol_data_local.dart';

class TruckQueuePage extends StatefulWidget {
  final List<TruckQueueModel> truckQueueList;

  TruckQueuePage({Key key, this.truckQueueList}) : super(key: key);

  @override
  _TruckQueuePageState createState() => _TruckQueuePageState();
}

class _TruckQueuePageState extends State<TruckQueuePage> {
  /* Properties */
  DateTime beginDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  BuildContext pageContext;
  Theme _calendarTheme(Widget child) {
    return Theme(
      child: child,
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: qcons.kGoldColor,
          surface: qcons.kGoldColor,
        ),
      ),
    );
  }

  Future selectBeginDate() async {
    final initialDate = this.beginDate;
    final selectedDate = await showDatePicker(
      context: pageContext,
      initialDate: initialDate,
      firstDate: DateTime(beginDate.year - 20),
      lastDate: DateTime(endDate.year + 1),
      locale: const Locale('th', 'TH'),
      builder: (BuildContext context, Widget child) {
        return _calendarTheme(child);
      },
    );
    if (selectedDate == null) return;

    setState(() {
      this.beginDate = selectedDate;
    });
  }

  Future selectEndDate() async {
    final initialDate = this.endDate;
    final selectedDate = await showDatePicker(
      context: pageContext,
      initialDate: initialDate,
      firstDate: DateTime(beginDate.year - 20),
      lastDate: DateTime(endDate.year + 1),
      locale: const Locale('th', 'TH'),
      builder: (BuildContext context, Widget child) {
        return _calendarTheme(child);
      },
    );
    if (selectedDate == null) return;

    setState(() {
      this.endDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    return truckQueuePageUI();
  }

  int animMilliSec = 400;

  Widget truckQueuePageUI() {
    return util.verticalAnimation(
      Container(
        color: cons.kPageBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            periodDateRow(),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 6),
                child: ListView.builder(
                    itemCount: widget.truckQueueList.length,
                    itemBuilder: (_context, _id) {
                      return TruckQueueDetailItemWidget(truckQueue: widget.truckQueueList[_id], animMilliSec: animMilliSec);
                    }),
              ),
            )
          ],
        ),
      ),
      aMilliseconds: 500,
    );
  }

  Widget periodDateRow() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DateDisplayWidget(displayDate: beginDate, onTapSelectDate: selectBeginDate),
          SizedBox(
            height: 25,
            child: Text('ถึง', style: TextStyle(color: cons.kGoldColor, fontSize: 20)),
          ),
          DateDisplayWidget(displayDate: endDate, onTapSelectDate: selectEndDate),
        ],
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------
class DateDisplayWidget extends StatelessWidget {
  final DateTime displayDate;
  final Function onTapSelectDate;
  // final BuildContext extContext;
  DateDisplayWidget({Key key, this.displayDate, this.onTapSelectDate}) : super(key: key);

  // Future pickDate(BuildContext context) async {
  //   final initialDate = displayDate;
  //   final newDate = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     locale: const Locale("th", "TH"),
  //     firstDate: DateTime(DateTime.now().year - 50),
  //     lastDate: DateTime(DateTime.now().year + 50),
  //   );
  //   if (newDate == null) return;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: cons.kGoldColor,
      ),
      child: Material(
        child: Builder(
          builder: (ctx) => InkWell(
            onTap: onTapSelectDate,
            // onTap: () => pickDate(ctx),
            child: Ink(
              color: qcons.kGoldColor,
              child: Container(
                // margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dateText(displayDate),
                    SizedBox(width: 6),
                    dropdownSign(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dateText(DateTime aDisplayDate) {
    String langCode = 'th'; //Localizations.localeOf(aContext).languageCode;
    String formatDate = DateFormat('d MMMM yyyy', langCode).format(aDisplayDate);
    return Text(
      formatDate,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget dropdownSign() {
    return Container(
      child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
    );
  }
}

//----------------------------------------------------------------------------------------------
class TruckQueueDetailItemWidget extends StatelessWidget {
  final TruckQueueModel truckQueue;
  final int animMilliSec;
  TruckQueueDetailItemWidget({Key key, this.truckQueue, this.animMilliSec = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return util.horizontalAnimation(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ทะเบียนรถ : ${truckQueue.truckRegistration}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[600], height: 0.9),
                ),
                Divider(thickness: 0.2, color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: truckQueue.queueDetailList.map((item) {
                          var date = DateFormat('วันที่ : dd/mm/yyyy  เวลา hh:mm น.').format(item.queueDateTime);
                          return Container(
                            child: Text(
                              'รับคิว $date',
                              style: TextStyle(fontSize: 20, color: qcons.kBlueColor, height: 0.9),
                            ),
                          );
                        }).toList()
                          ..add(
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'น้ำหนักสุทธิ : ${truckQueue.netWeight} ตัน',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: qcons.kBlueColor, height: 0.9),
                              ),
                            ),
                          ),
                      ),
                    ),
                    Expanded(child: Container(height: 50, child: VerticalDivider(color: Colors.grey))),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'ค่า CCS',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: qcons.kBlueColor, height: 0.8),
                          ),
                          Text(
                            '${truckQueue.ccsValue}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: qcons.kBlueColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      aMilliseconds: animMilliSec,
    );
  }
}
