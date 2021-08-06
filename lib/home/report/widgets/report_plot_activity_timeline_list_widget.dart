import 'package:flutter/material.dart';
import '../models/report_activity_model.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../report_utils.dart' as rputil;
import '../report_const.dart' as rpcons;
import '../../../global_utils.dart' as util;

class ReportPlotActivityTimeLineListWidget extends StatefulWidget {
  final ReportActivityDateList dateActivityList;

  ReportPlotActivityTimeLineListWidget(
      {Key key, @required this.dateActivityList})
      : super(key: key);

  @override
  _ReportPlotActivityTimeLineListWidgetState createState() =>
      _ReportPlotActivityTimeLineListWidgetState();
}

class _ReportPlotActivityTimeLineListWidgetState
    extends State<ReportPlotActivityTimeLineListWidget> {
  static bool isAlreadyBuilded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _ReportPlotActivityTimeLineListWidgetState.isAlreadyBuilded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: rpcons.kSummaryBgColor,
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: widget.dateActivityList.dateItems.length,
          itemBuilder: (ctx, id) {
            var dateItem = widget.dateActivityList.dateItems[id];
            String actTime =
                DateFormat('h:mm').format(dateItem.activityDateTime);
            // String actDay = DateFormat('dd').format(dateItem.activityDateTime);
            // String actMonth = DateFormat('MMM').format(dateItem.activityDateTime);
            int actYear = dateItem.activityDateTime.year + 543;
            DateTime actDate = DateTime(actYear,
                dateItem.activityDateTime.month, dateItem.activityDateTime.day);
            return TimelineTile(
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                color: rpcons.kGoldColor,
                indicator: Icon(Icons.check_circle, color: rpcons.kGoldColor),
                indicatorXY: 0,
                // padding: EdgeInsets.only(top: 4),
              ),
              beforeLineStyle:
                  LineStyle(thickness: 0.8, color: rpcons.kGoldColor),
              afterLineStyle:
                  (id < widget.dateActivityList.dateItems.length - 1)
                      ? LineStyle(thickness: 0.5, color: rpcons.kGoldColor)
                      : LineStyle(color: Colors.transparent),
              lineXY: 0.22,
              startChild: util.horizontalAnimation(
                Container(
                  margin: EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateFormat('dd MMM yyyy', 'th').format(actDate)}',
                          style: TextStyle(fontSize: 16)),
                      Text('$actTime น.', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                aMilliseconds: 600,
                aStartPosition: -50,
                // aIsAnimated: !_ReportPlotActivityTimeLineListWidgetState.isAlreadyBuilded,
              ),
              endChild: util.horizontalAnimation(
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            dateItem.activityList.activityItems.map((actItem) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // Heading activity
                                child: Text(actItem.label,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              Divider(
                                  thickness: 0.6,
                                  color: rpcons.kSummaryBgColor),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: actItem.detailList.detailItems
                                      .map((dItem) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${dItem.detailDescription}',
                                            style: TextStyle(
                                                fontSize: 18, height: 0.5)),
                                        if (dItem !=
                                            actItem.detailList.detailItems.last)
                                          Divider(
                                              thickness: 0.6,
                                              color: rpcons.kSummaryBgColor)
                                        else
                                          SizedBox(height: 5),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                aMilliseconds: 850,
                // aIsAnimated: !_ReportPlotActivityTimeLineListWidgetState.isAlreadyBuilded,
              ),
            );
          },
        ),
      ),
    );
  }
}
