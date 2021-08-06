import 'package:flutter/material.dart';
import '../../global_const.dart' as cons;

class RowData extends StatelessWidget {
  RowData({
    Key key,
    @required this.leading,
    @required this.content,
    this.bit,
  }) : super(key: key);

  String leading;
  String content;
  String bit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(leading, style: TextStyle(color: cons.kBlueColor, fontSize: 20, height: 1.0)),
        Text(content, style: TextStyle(color: cons.kBlueColor, fontSize: 20, height: 1.0)),
        Text(bit, style: TextStyle(color: cons.kBlueColor, fontSize: 20, height: 1.0)),
      ],
    );
  }
}
