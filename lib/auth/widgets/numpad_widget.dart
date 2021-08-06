import 'dart:ui';
import 'package:flutter/material.dart';

import '../../base_class/models/ai_display_area_model.dart';
import '../../global_utils.dart' as util;

enum NumpadData { num0, num1, num2, num3, num4, num5, num6, num7, num8, num9, back, delete }
typedef OnNumpadTapEvent = void Function(NumpadData aNumpad);

class NumpadWidget extends StatelessWidget {
  final OnNumpadTapEvent onNumpadTap;
  final bool isShowDeleteButton;
  final bool isShowBackButton;
  final bool isShowForgotPasscode;
  final List<NumpadData> _numpadList = [
    NumpadData.num1,
    NumpadData.num2,
    NumpadData.num3,
    NumpadData.num4,
    NumpadData.num5,
    NumpadData.num6,
    NumpadData.num7,
    NumpadData.num8,
    NumpadData.num9,
    NumpadData.back,
    NumpadData.num0,
    NumpadData.delete,
  ];

  Widget _buttonCaption(NumpadData aNumpadData) {
    double fSize = (aNumpadData == NumpadData.back || aNumpadData == NumpadData.delete) ? 22 : 55;
    String caption = '${aNumpadData.index}';
    switch (aNumpadData) {
      case NumpadData.delete:
        caption = 'ลบ';
        break;
      case NumpadData.back:
        if (this.isShowForgotPasscode)
          caption = 'ลืมรหัส';
        else
          caption = 'ย้อนกลับ';
        break;
      default:
        break;
    }

    switch (aNumpadData) {
      case NumpadData.delete:
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.backspace_outlined, color: Colors.white),
              // Text(caption, style: TextStyle(color: Colors.white, fontSize: fSize), textAlign: TextAlign.center)
            ],
          ),
        );
      default:
        return Container(
          alignment: Alignment.center,
          child: Text(
            caption,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: fSize),
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  Widget _numButton(NumpadData aNumpadData) {
    bool buttonVisible = (aNumpadData != NumpadData.delete && aNumpadData != NumpadData.back);

    if (!buttonVisible) {
      switch (aNumpadData) {
        case NumpadData.delete:
          buttonVisible = isShowDeleteButton;
          break;
        case NumpadData.back:
          buttonVisible = isShowBackButton || isShowForgotPasscode;
          break;
        default:
          break;
      }
    }

    if (buttonVisible) {
      return Container(
        margin: const EdgeInsets.all(2),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: (aNumpadData == NumpadData.delete || aNumpadData == NumpadData.back)
                ? BorderSide.none
                : BorderSide(
                    width: 0.2,
                    color: Colors.transparent,
                  ),
          ),
          onPressed: () {
            if (this.onNumpadTap != null) this.onNumpadTap(aNumpadData);
          },
          child: _buttonCaption(aNumpadData),
        ),
        decoration: !(aNumpadData == NumpadData.delete || aNumpadData == NumpadData.back)
            ? BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.yellow.withOpacity(0.1))
            : null,
      );
    } else
      return Container();
  }

  Widget _numpadGrid(List<NumpadData> aNumList) {
    final double runSpacing = 16;
    final double spacing = 16;
    final columnCount = 3;
    final keyboardSize = displayWidth() * 0.75;
    final buttonSize = (keyboardSize - spacing * (columnCount - 1)) / columnCount;
    int duration = 300;
    return Wrap(
      runSpacing: runSpacing,
      spacing: spacing,
      runAlignment: WrapAlignment.center,
      children: List.generate(
        aNumList.length,
        (index) => Builder(builder: (context) {
          duration += 200;
          return util.scaleAnimation(
            Container(width: buttonSize, height: buttonSize, child: _numButton(aNumList[index])),
            aCurve: Curves.elasticInOut,
            aStartSize: 0,
            aEndSize: 1,
            aMilliseconds: duration,
          );
        }),
      ),
    );
  }

  NumpadWidget({
    Key key,
    @required this.onNumpadTap,
    @required this.isShowDeleteButton,
    @required this.isShowBackButton,
    @required this.isShowForgotPasscode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth() * 0.85,
      // height: displayHeight() * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: _numpadGrid(_numpadList)),
        ],
      ),
    );
  }
}

/* ------------------------------------------------------------------------------------------------------- */
// ignore: must_be_immutable
class PasscodeDot extends StatelessWidget {
  final double dotSize = 16;
  final bool filled;
  final String numStr;
  final double textHeight = 36;
  double shakeOffset = 0;

  PasscodeDot({Key key, @required this.filled, this.numStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: shakeOffset),
      width: dotSize,
      height: (filled) ? textHeight : dotSize,
      child: (filled)
          ? Text(
              numStr,
              style: TextStyle(fontSize: 34, color: Colors.white),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
              ),
            ),
    );
  }
}
