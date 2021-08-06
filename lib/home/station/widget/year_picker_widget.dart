import 'dart:convert';

import 'package:ai_flutter/home/station/model/group_year_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearPickerWidget extends StatefulWidget {
  final List<LastCurrentYear> data;
  final LastCurrentYear selectedData;
  final ValueChanged<LastCurrentYear> valueChanged;
  YearPickerWidget(
      {Key key,
      @required this.data,
      @required this.selectedData,
      @required this.valueChanged})
      : super(key: key);
  @override
  _YearPickerWidgetState createState() => _YearPickerWidgetState();
}

class _YearPickerWidgetState extends State<YearPickerWidget> {
  // int cupertinoSelected = 0;
  int initialItem = 0;
  List<Widget> dataList = [];
  var scrollController = FixedExtentScrollController();
  setWidget() {
    // Widget allPlot = Container(
    //   // color: Colors.red,
    //   width: double.infinity,
    //   height: double.infinity,
    //   alignment: Alignment.center,
    //   child: Text(
    //     widget.selectedData.toString(),
    //     style: TextStyle(),
    //     textAlign: TextAlign.center,
    //   ),
    // );
    // dataList.add(allPlot);
    for (var i = 0; i < widget.data.length; i++) {
      Widget next = Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          widget.data[i].text.toString(),
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
      dataList.add(next);
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
              widget.valueChanged(widget.data[initialItem]);
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 50,
              scrollController: scrollController,
              onSelectedItemChanged: (value) {
                setState(() {
                  initialItem = value;
                });
              },
              children: dataList,
            ),
          ),
        ),
      ),
    );
  }
}
