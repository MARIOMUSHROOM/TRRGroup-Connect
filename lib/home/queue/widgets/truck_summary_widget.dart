import 'package:flutter/material.dart';
import '../queue_utils.dart' as qutil;
import '../queue_const.dart' as qcons;

class TruckSummaryWidget extends StatelessWidget {
  final int truckCount;
  final String truckImage;
  final String label;

  TruckSummaryWidget(this.truckCount, this.truckImage, this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: qutil.queueBoxDecoration,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(truckImage, color: qcons.kGoldColor, height: 70),
            ),
            Text(label, style: TextStyle(fontSize: 19, height: 0.8)),
            Text(
              '$truckCount คัน',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: qcons.kBlueColor),
            ),
          ],
        ),
      ),
    );
  }
}
