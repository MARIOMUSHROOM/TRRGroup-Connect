import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../global_const.dart' as cons;

class CustomYearPickerWidget extends StatefulWidget {
  int startYear;
  final ValueChanged<int> yearSelect;
  CustomYearPickerWidget({Key key, @required this.startYear, this.yearSelect})
      : super(key: key);
  @override
  _CustomYearPickerWidgetState createState() => _CustomYearPickerWidgetState();
}

class _CustomYearPickerWidgetState extends State<CustomYearPickerWidget> {
  int thaiFormYear = DateTime.now().year + 543;
  List<int> thaiFormYearList = [];
  int startYearNew;
  int lastYearNew;

  validateData(int index) {
    setState(() {
      startYearNew = thaiFormYearList[index];
      lastYearNew = thaiFormYearList[index] + 1;
    });
  }

  setData() {
    startYearNew = widget.startYear + 543;
    lastYearNew = thaiFormYear + 1;
    int data = thaiFormYear;
    for (var i = thaiFormYear; i >= thaiFormYear - 10; i--) {
      thaiFormYearList.add(data);
      data = data - 1;
    }
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
                      child: CupertinoPicker(
                        // scrollController: scrollController,
                        itemExtent: 50,
                        children: <Widget>[
                          for (var i = 0; i < thaiFormYearList.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text(
                                    thaiFormYearList[i].toString(),
                                  ),
                                ),
                                Text("/"),
                                Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text(
                                    (thaiFormYearList[i] + 1).toString(),
                                  ),
                                )
                              ],
                            ),
                        ],
                        onSelectedItemChanged: (int index) {
                          validateData(index);
                        },
                        // looping: true,
                        // backgroundColor: Color(0xff2e3032),
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
                  widget.yearSelect(startYearNew);
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
