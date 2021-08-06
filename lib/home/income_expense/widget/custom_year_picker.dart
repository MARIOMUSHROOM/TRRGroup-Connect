import 'package:ai_flutter/global_const.dart' as cons;
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomYearPickerWidget extends StatefulWidget {
  final ValueChanged<int> startTime;
  final ValueChanged<int> lastTime;
  CustomYearPickerWidget({Key key, this.startTime, this.lastTime})
      : super(key: key);
  @override
  _CustomYearPickerWidgetState createState() => _CustomYearPickerWidgetState();
}

class _CustomYearPickerWidgetState extends State<CustomYearPickerWidget> {
  int thaiFormYear = DateTime.now().year + 543;
  int startYearNew;
  int lastYearNew;

  validateData(int start, int last) {
    if (start > last) {
      setState(() {
        lastYearNew = start;
      });
    } else {
      setState(() {
        startYearNew = start;
        lastYearNew = last;
      });
    }
  }

  setData() {
    startYearNew = thaiFormYear - 1;
    lastYearNew = thaiFormYear - 1;
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 300,
          width: 380,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: cons.kGoldColor,
                  borderRadius: BorderRadius.circular(5),
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
                        child: Text(
                      "ปี $startYearNew",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "ปี $lastYearNew",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: NumberPicker(
                        selectedTextStyle: TextStyle(
                            color: cons.kBlueColor,
                            fontWeight: FontWeight.bold),
                        decoration: BoxDecoration(
                            color: cons.kSolidBlueColor.withOpacity(0.1)),
                        value: startYearNew,
                        minValue: thaiFormYear - 20,
                        maxValue: thaiFormYear - 1,
                        step: 1,
                        haptics: true,
                        itemCount: 5,
                        itemHeight: 30,
                        onChanged: (value) {
                          validateData(value, lastYearNew);
                        },
                      ),
                    ),
                    Expanded(
                      child: NumberPicker(
                        selectedTextStyle: TextStyle(
                            color: cons.kBlueColor,
                            fontWeight: FontWeight.bold),
                        decoration: BoxDecoration(
                            color: cons.kSolidBlueColor.withOpacity(0.1)),
                        value: lastYearNew,
                        minValue: startYearNew,
                        maxValue: thaiFormYear,
                        step: 1,
                        haptics: true,
                        itemCount: 5,
                        itemHeight: 30,
                        // onChanged: onChanged2,
                        onChanged: (value) {
                          validateData(startYearNew, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  widget.startTime(startYearNew);
                  widget.lastTime(lastYearNew);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150,
                  height: 36,
                  decoration: BoxDecoration(
                    color: cons.kGoldColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child:
                      Text("เสร็จสิ้น", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
