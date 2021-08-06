import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    Key key,
    this.appBar,
    @required this.titleText,
    this.actionOn = false,
    this.onPressed,
  }) : super(key: key);
  final AppBar appBar;
  final String titleText;
  final bool actionOn;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: kContentColorLightTheme,
      title: Text(
        titleText,
        textAlign: TextAlign.center,
        style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.white)),
      ),
      centerTitle: true,
      actions: [
        actionOn
            ? FlatButton(
                onPressed: onPressed,
                child: Text(
                  'บันทึก',
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.white)),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
