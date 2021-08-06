import 'package:flutter/material.dart';

class DividerCustomWidget extends StatelessWidget {
  DividerCustomWidget({
    Key key,
    this.thickness,
  }) : super(key: key);
  double thickness;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      child: Divider(
        thickness: thickness,
      ),
    );
  }
}
