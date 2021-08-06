import 'package:ai_flutter/home/income_expense/function.dart';
import 'package:flutter/material.dart';
import '../../../global_const.dart' as cons;

class ColumnTextData extends StatelessWidget {
  ColumnTextData({
    Key key,
    @required this.title,
    @required this.content,
    this.bit,
  }) : super(key: key);

  String title;
  String content;
  String bit;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              checkNull(title),
              style: TextStyle(
                color: cons.kBlueColor,
                fontSize: 25,
                height: 1.0,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            bit == null
                ? SizedBox()
                : Text(
                    checkNull(bit),
                    style: TextStyle(
                      color: cons.kBlueColor,
                      fontSize: 25,
                      height: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
        Text(
          checkNull(content),
          style: TextStyle(
            color: cons.kBlueColor,
            fontSize: 20,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
