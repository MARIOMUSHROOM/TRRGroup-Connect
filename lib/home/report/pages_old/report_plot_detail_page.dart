import 'package:flutter/material.dart';
import '../models/report_activity_model.dart';
import '../report_utils.dart' as rputil;
import '../report_const.dart' as rpcons;
import '../widgets/report_plot_activity_timeline_list_widget.dart';

class ReportPlotDetailPage extends StatefulWidget {
  final ReportPlotItem plotData;
  ReportPlotDetailPage({Key key, @required this.plotData}) : super(key: key);
  @override
  _ReportPlotDetailPageState createState() => _ReportPlotDetailPageState();
}

class _ReportPlotDetailPageState extends State<ReportPlotDetailPage> {
  @override
  Widget build(BuildContext context) {
    return _reportPlotDetailPageUI();
  }

  Widget _reportPlotDetailPageUI() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _plotDetailHeader(),
          ReportPlotActivityTimeLineListWidget(
              dateActivityList: widget.plotData.activityDateList),
          _plotSummaryFooter(),
        ],
      ),
    );
  }

  Widget _plotDetailHeader() {
    // print(widget.plotData.activityDateList.dateItems.length);
    return Container(
      // height: 50,
      alignment: Alignment.center,
      // padding: EdgeInsets.only(top: 10, left: 20),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Text(
          '${widget.plotData.plotName} ${widget.plotData.plotTypeName} ในปี '),
    );
  }

  Widget _plotSummaryFooter() {
    var volume = widget.plotData.sugarcaneVolume;
    var sumStr =
        volume.toStringAsFixed(volume.truncateToDouble() == volume ? 0 : 2);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: rpcons.kSummaryBgColor,
        height: 70,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ปริมาณอ้อยที่ได้ทั้งหมด', style: TextStyle(fontSize: 24)),
              Text('$sumStr ตัน', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
