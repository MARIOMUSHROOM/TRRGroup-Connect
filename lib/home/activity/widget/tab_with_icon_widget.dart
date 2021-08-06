import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabCustomWithIcon extends StatelessWidget {
  const TabCustomWithIcon({
    Key key,
    @required this.text,
    @required this.imagePath,
    @required this.index,
    @required this.indexSelected,
  }) : super(key: key);
  final String text;
  final String imagePath;
  final int index;
  final int indexSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(width: 100),
      decoration: BoxDecoration(
        color: indexSelected == index ? kGoldColor : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tab(
          //   // text: text,
          //   icon: icon == null
          //       ? Icon(
          //           Icons.image_outlined,
          //           size: 40,
          //         )
          //       : icon,
          // ),
          imagePath == null
              ? Icon(
                  Icons.image_outlined,
                  size: 40,
                )
              : Image.asset(imagePath),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.kanit(),
          ),
        ],
      ),
    );
  }
}
