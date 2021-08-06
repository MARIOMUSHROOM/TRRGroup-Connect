import 'package:flutter/material.dart';

class TabbarWithImageWidget extends StatelessWidget {
  TabbarWithImageWidget({
    Key key,
    @required this.imageActivePath,
    @required this.imageNonActivePath,
    @required this.index,
    @required this.indexSelected,
  }) : super(key: key);
  final String imageActivePath;
  final String imageNonActivePath;
  final int index;
  final int indexSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(width: 100),
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: new DecorationImage(
          image: new ExactAssetImage(
            indexSelected == index ? imageActivePath : imageNonActivePath,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
