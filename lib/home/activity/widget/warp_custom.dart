import 'package:ai_flutter/home/activity/utils/border_warp.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';

class WarpCustomPick extends StatefulWidget {
  WarpCustomPick({Key key, this.typeList, this.typeSelected, this.selected})
      : super(key: key);
  final List<String> typeList;
  final String typeSelected;
  final ValueChanged<String> selected;
  @override
  _WarpCustomPickState createState() => _WarpCustomPickState(this.typeSelected);
}

class _WarpCustomPickState extends State<WarpCustomPick> {
  _WarpCustomPickState(this.typeSelected);
  String typeSelected;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.typeList
          .map((textStyle) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelected = textStyle;
                  });
                  widget.selected(typeSelected);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color:
                        typeSelected == textStyle ? kGoldColor : Colors.white,
                    border: Border.all(
                      color: kGoldColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    textStyle,
                    style: TextStyle(
                      color:
                          typeSelected == textStyle ? Colors.white : kGoldColor,
                    ),
                  ),
                ),
              ),
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }
}
