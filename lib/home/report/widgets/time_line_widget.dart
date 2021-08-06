import 'package:ai_flutter/bloc/report_state/function/check_null.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/report/models/report_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ListViewTimeLineWidget extends StatelessWidget {
  const ListViewTimeLineWidget({
    Key key,
    @required this.data,
    this.onEditClick,
    this.onDeleteClick,
  }) : super(key: key);
  final List<dynamic> data;
  final ValueChanged<int> onEditClick;
  final ValueChanged<int> onDeleteClick;
  @override
  Widget build(BuildContext context) {
    // print(data.length);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          indicatorStyle: IndicatorStyle(
            // color: index == 0 ? kGoldColor : Colors.transparent,
            indicator: Container(
              decoration: BoxDecoration(
                color: index == 0 ? kGoldColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: kGoldColor),
              ),
            ),
            indicatorXY: 0.08,
            // padding: EdgeInsets.only(top: 4),
          ),
          beforeLineStyle: LineStyle(
            // thickness: 0.8,
            color: kGoldColor,
          ),
          startChild: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index] == null || data[index].dateFormat == null
                      ? " "
                      : data[index].dateFormat,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  data[index] == null || data[index].timeFormat == null
                      ? " "
                      : data[index].timeFormat,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          endChild: Container(
            padding: EdgeInsets.all(8),
            constraints: BoxConstraints(
              minHeight: 120,
            ),
            // height: 50,
            child: Container(
              padding: EdgeInsets.all(8),
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
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index] == null || data[index].title[0] == null
                            ? " "
                            : data[index].title[0],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Divider(),
                      data[index] == null || data[index].data == null
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: data[index]
                                  .data
                                  .map((textStyle) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 0.5,
                                          child: Divider(),
                                        ),
                                        Row(
                                          children: [
                                            Text("- "),
                                            Text(
                                              checkNull(textStyle.name),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              checkNull(textStyle.value),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              checkNull(textStyle.unit),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  })
                                  .toList()
                                  .cast<Widget>(),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
