import 'package:flutter/material.dart';
import '../models/sugarcane_queue_model.dart';
import '../models/sugarcane_type_truck_model.dart';
import '../queue_const.dart' as qcons;
import '../queue_utils.dart' as qutil;
import '../../../global_const.dart' as cons;

class CourtYardWidget extends StatelessWidget {
  final String label;
  final SugarcaneQueueModel sugarcaneQueue;
  final qcons.CourtYardType courtyardType;
  CourtYardWidget(this.label, this.sugarcaneQueue, this.courtyardType);
  @override
  Widget build(BuildContext context) {
    var summary = 0;
    List<SugarcaneTypeTruckModel> list;

    switch (this.courtyardType) {
      case qcons.CourtYardType.Internal:
        summary = sugarcaneQueue.internalCourtTruckSummary;
        list = sugarcaneQueue.internalCourtYard;
        break;
      case qcons.CourtYardType.External:
        summary = sugarcaneQueue.externalCourtTruckSummary;
        list = sugarcaneQueue.externalCourtYard;
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.only(left: 20, top: 5),
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: qutil.queueBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            child: Text('$label : $summary คัน', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            alignment: Alignment.centerLeft,
          ),
          _courtYardTruckRow(list),
        ],
      ),
    );
  }

  Widget _courtYardTruckRow(List<SugarcaneTypeTruckModel> aCourtYardTruckList) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      // height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _courtYardTruckSummary(aCourtYardTruckList),
      ),
    );
  }

  List<Widget> _courtYardTruckSummary(List<SugarcaneTypeTruckModel> aCourtYardTruckList) {
    var result = <Widget>[];
    aCourtYardTruckList.map((item) {
      result.add(Container(
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_courtYardTruckSumItem(item)],
          )));
      result.add(
        Container(
          child: (item != aCourtYardTruckList.last)
              ? Container(alignment: Alignment.topCenter, height: 50, child: VerticalDivider(color: Colors.grey))
              : Container(),
        ),
      );
    }).toList();
    return result;
  }

  Widget _courtYardTruckSumItem(SugarcaneTypeTruckModel aCourtYardTruck) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: cons.kPageBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image(image: AssetImage(aCourtYardTruck.iconImage), height: 30, fit: BoxFit.contain),
        ),
        Text('${aCourtYardTruck.sugarCaneTypeName}', style: TextStyle(fontSize: 16, color: qcons.kBlueColor)),
        Text('${aCourtYardTruck.truckCount} คัน', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: qcons.kBlueColor, height: 0.9)),
      ],
    );
  }
}
