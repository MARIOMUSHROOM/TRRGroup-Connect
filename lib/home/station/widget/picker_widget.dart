import 'dart:convert';

import 'package:ai_flutter/home/station/model/plot_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerWidget extends StatefulWidget {
  final List<StationDetail> data;
  final StationDetail selectedData;
  final ValueChanged<StationDetail> valueChanged;
  PickerWidget(
      {Key key,
      @required this.data,
      @required this.selectedData,
      @required this.valueChanged})
      : super(key: key);
  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  int initialItem = 0;
  List<Widget> widgetList = [];
  var scrollController = FixedExtentScrollController();
  setWidget() {
    Widget allPlot = Container(
      // color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "แปลงทั้งหมด",
        style: TextStyle(),
        textAlign: TextAlign.center,
      ),
    );
    widgetList.add(allPlot);
    for (var i = 0; i < widget.data.length; i++) {
      Widget next = Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          "แปลงที่ " + widget.data[i].plotNo.toString(),
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
      widgetList.add(next);
    }

    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data[i] == widget.selectedData) {
        initialItem = i;
      }
    }
    scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  void initState() {
    setWidget();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              if (initialItem == 0) {
                print("0");
                widget.valueChanged(null);
              } else {
                widget.valueChanged(widget.data[initialItem - 1]);
              }
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: (value) {
                setState(() {
                  initialItem = value;
                });
              },
              children: widgetList,
              // children: widget.data.map(
              //   (e) {
              //     return Container(
              //       // color: Colors.red,
              //       width: double.infinity,
              //       height: double.infinity,
              //       alignment: Alignment.center,
              //       child: Text(
              //         "แปลงที่ " + e.plotNo.toString(),
              //         style: TextStyle(),
              //         textAlign: TextAlign.center,
              //       ),
              //     );
              //   },
              // ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
