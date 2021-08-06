import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ListViewTimeLineWidget extends StatelessWidget {
  const ListViewTimeLineWidget({
    Key key,
    @required this.data,
    this.onEditClick,
    this.onDeleteClick,
  }) : super(key: key);
  final List<PlantHistory> data;
  final ValueChanged<int> onEditClick;
  final ValueChanged<int> onDeleteClick;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        List<String> onlyData = data[index].content;
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
                  data[index].farmName == null ? "-" : data[index].farmName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data[index].date == null ? "-" : data[index].date,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  data[index].time == null ? "-" : data[index].time,
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
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data[index].stationArea == null ||
                                data[index].stationArea == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].stationArea,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    child: Divider(),
                                  ),
                                ],
                              ),
                        Text(
                          data[index].title == null ? "-" : data[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Divider(),
                        // Text(data[index].time == null ? "-" : data[index].time),
                        onlyData == null
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: onlyData
                                    .map((textStyle) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 0.5,
                                            child: Divider(),
                                          ),
                                          Text(" - $textStyle"),
                                        ],
                                      );
                                    })
                                    .toList()
                                    .cast<Widget>(),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PopupMenuButton(
                      onSelected: (result) {
                        if (result == 0) {
                          print("แก้ไข");
                          onEditClick(index);
                        } else if (result == 1) {
                          print("ลบ");
                          onDeleteClick(index);
                        }
                      },
                      itemBuilder: (context) {
                        var list = List<PopupMenuEntry<Object>>();
                        list.add(
                          PopupMenuItem(
                            child: Text("แก้ไข"),
                            value: 0,
                          ),
                        );
                        list.add(
                          PopupMenuItem(
                            child: Text(
                              "ลบ",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            value: 1,
                          ),
                        );
                        return list;
                      },
                      icon: Icon(Icons.more_vert),
                    ),
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
