import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../models/sugarcane_queue_model.dart';
import '../queue_const.dart' as qcons;
import '../queue_utils.dart' as qutil;
import '../widgets/truck_summary_widget.dart';
import '../widgets/court_yard_widget.dart';
import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;

class SugarcaneQueuePage extends StatelessWidget {
  final SugarcaneQueueModel sugarcaneQueue;

  SugarcaneQueuePage({Key key, @required this.sugarcaneQueue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _sugarcaneQueuePageUI();
  }

  Widget _sugarcaneQueuePageUI() {
    return util.verticalAnimation(
      Container(
        color: cons.kPageBackgroundColor,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _sugarcaneQueueDetail(),
            _truckRow(sugarcaneQueue),
            CourtYardWidget('ลานนอก', sugarcaneQueue, qcons.CourtYardType.External),
            CourtYardWidget('ลานใน', sugarcaneQueue, qcons.CourtYardType.Internal),
          ],
        ),
      ),
      aMilliseconds: 500,
    );
  }

  Widget _sugarcaneQueueDetail() {
    var date = DateFormat('วันที่ dd/mm/yyyy เวลา hh:mm น.').format(sugarcaneQueue.queueDateTime);
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: qutil.queueBoxDecoration,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'คิวอ้อย',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 5, child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.av_timer_outlined, color: qcons.kBlueColor, size: 18),
                SizedBox(width: 5),
                Text('$date', style: TextStyle(color: qcons.kBlueColor, fontSize: 20)),
              ],
            ),
            SizedBox(height: 5, child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined, color: qcons.kBlueColor, size: 18),
                SizedBox(width: 5),
                Text(sugarcaneQueue.factoryName, style: TextStyle(color: qcons.kBlueColor, fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _truckRow(SugarcaneQueueModel aSugarcaneQueue) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TruckSummaryWidget(
              aSugarcaneQueue.workingTruckCount,
              'assets/images/queue/working_truck.png',
              'จำนวนรถที่ออกทั้งหมด/วัน',
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TruckSummaryWidget(
              aSugarcaneQueue.overallTruckCount,
              'assets/images/queue/truck.png',
              'จำนวนรถทั้งหมด/วัน',
            ),
          ),
        ],
      ),
    );
  }
}
