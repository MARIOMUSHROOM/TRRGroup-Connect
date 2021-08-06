import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import './global_const.dart' as cons;

const kOpacity = 'opacity';
const kScale = 'scale';
const kMotion = 'motion';

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget scaleAnimation(
  Widget aChildWidget, {
  int aMilliseconds = 1000,
  double aStartSize = 10,
  double aEndSize = 1,
  bool aIsFadeWhenDone = false,
  Curve aCurve = Curves.easeInOut,
}) {
  double opacityBegin = aIsFadeWhenDone ? 1 : 0;
  double opacityEnd = aIsFadeWhenDone ? 0 : 1;
  return Animator(
    tweenMap: {
      kOpacity: Tween<double>(begin: opacityBegin, end: opacityEnd),
      kScale: Tween<double>(begin: aStartSize, end: aEndSize),
      kMotion: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0)),
    },
    duration: Duration(milliseconds: aMilliseconds),
    // duration: Duration(milliseconds: 400),
    cycles: 1,
    curve: aCurve,
    builder: (_, anim, __) => FadeTransition(
      opacity: anim.getAnimation(kOpacity),
      child: Transform.scale(
        scale: anim.getValue(kScale),
        child: Transform.translate(
          offset: anim.getValue(kMotion),
          child: aChildWidget,
        ),
      ),
    ),
  );
}

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget motionAnimation(
  Widget aChildWidget,
  bool aIsVertical, {
  int aMilliseconds = 1000,
  double aStartPosition = 100,
  Curve aCurve = Curves.easeInOut,
}) {
  final double xPos = (aIsVertical) ? 0 : aStartPosition;
  final double yPos = (aIsVertical) ? aStartPosition : 0;

  return Animator(
    tweenMap: {
      kOpacity: Tween<double>(begin: -3, end: 1),
      kMotion: Tween<Offset>(begin: Offset(xPos, yPos), end: Offset.zero),
    },
    duration: Duration(milliseconds: aMilliseconds),
    // duration: Duration(milliseconds: 400),
    cycles: 1,
    curve: aCurve,
    builder: (_, anim, __) => FadeTransition(
      opacity: anim.getAnimation(kOpacity),
      child: Transform.translate(
        offset: anim.getValue(kMotion),
        child: aChildWidget,
      ),
    ),
  );
}

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget zoomInAnimation(
  Widget aChildWidget, {
  int aMilliseconds = 1000,
  double aStartSize = 10,
  double aEndSize = 1,
  bool aIsFadeWhenDone = false,
  // int aDelayMilliSeconds = 0,
  Curve aCurve = Curves.easeInOut,
}) {
  return scaleAnimation(
    aChildWidget,
    aMilliseconds: aMilliseconds,
    aStartSize: aStartSize,
    aEndSize: aEndSize,
    aIsFadeWhenDone: aIsFadeWhenDone,
    aCurve: aCurve,
    // aDelayMilliSeconds: aDelayMilliSeconds,
  );
}

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget zoomOutAnimation(
  Widget aChildWidget, {
  int aMilliseconds = 1000,
  double aStartSize = 1,
  double aEndSize = 10,
  bool aIsFadeWhenDone = false,
  Curve aCurve = Curves.easeInOut,
}) {
  return scaleAnimation(
    aChildWidget,
    aMilliseconds: aMilliseconds,
    aStartSize: aStartSize,
    aEndSize: aEndSize,
    aIsFadeWhenDone: aIsFadeWhenDone,
    aCurve: aCurve,
  );
}

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget verticalAnimation(
  Widget aChildWidget, {
  int aMilliseconds = 1000,
  double aStartPosition = 60,
  Curve aCurve = Curves.easeInOut,
  bool aIsAnimated = true,
}) {
  if (aIsAnimated)
    return motionAnimation(
      aChildWidget,
      true,
      aMilliseconds: aMilliseconds,
      aStartPosition: aStartPosition,
      aCurve: aCurve,
    );
  else
    return aChildWidget;
}

/* ------------------------------------------------------------------------------------------------------------------------ */
Widget horizontalAnimation(
  Widget aChildWidget, {
  int aMilliseconds = 1000,
  double aStartPosition = 60,
  Curve aCurve = Curves.easeInOut,
  bool aIsAnimated = true,
}) {
  if (aIsAnimated)
    return motionAnimation(
      aChildWidget,
      false,
      aMilliseconds: aMilliseconds,
      aStartPosition: aStartPosition,
      aCurve: aCurve,
    );
  else
    return aChildWidget;
}

/* ------------------------------------------------------------------------------------------------------------------------ */

DateTime getThaiDateTime(DateTime aDateTime) {
  return DateTime(
    aDateTime.year + 543,
    aDateTime.month,
    aDateTime.day,
    aDateTime.hour,
    aDateTime.minute,
    aDateTime.second,
    aDateTime.millisecond,
    aDateTime.microsecond,
  );
}

String getFullThaiDateFormat(DateTime aDateTime) {
  return DateFormat('EEEE d MMMM yyyy', 'th').format(getThaiDateTime(aDateTime));
}

String getThaiDateFormat(DateTime aDateTime) {
  return DateFormat('d MMMM yyyy', 'th').format(getThaiDateTime(aDateTime));
}

int getThaiYear(DateTime aDateTime) => aDateTime.year + 543;

int getShortThaiYearFromDate(DateTime aDateTime) => getThaiYear(aDateTime) - 2500;

int getShortThaiYearFromYear(int aYear) => (aYear + 543) - 2500;

String safeDataAsString(dynamic aData, [String aDefaultString = '']) {
  String result = aDefaultString;
  if (aData == null)
    result = aDefaultString;
  else
    result = '${aData.toString()}';
  return result;
}

void hideCurrentKeyboard() {
  if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
    /* hide keyboard */
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

String getThaiWeekDayName(int aWeekDay) {
  return (aWeekDay >= 1 && aWeekDay <= 7) ? cons.kThaiWeekDayNameMap[aWeekDay] : '';
}

String getThaiWeekDayShortName(int aWeekDay) {
  return (aWeekDay >= 1 && aWeekDay <= 7) ? cons.kThaiWeekDayShortNameMap[aWeekDay] : '';
}

String getThaiMonthName(int aMonth) {
  return (aMonth >= 1 && aMonth <= 12) ? cons.kThaiMonthNameMap[aMonth] : '';
}

void showErrorTextDialog(String aDescriptionMessage, {BuildContext referContext, double deviceHeight, double deviceWidth}) async {
  await showDialog(
    context: referContext,
    builder: (BuildContext ctx) {
      return verticalAnimation(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: deviceHeight * 0.40,
            width: deviceWidth * 0.85,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(image: AssetImage('assets/images/auth/invalid_user.png'), fit: BoxFit.cover, width: 100),
                  Expanded(
                    child: Align(
                      child: Text(
                        aDescriptionMessage,
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(referContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: cons.kBlueColor,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 6),
                    ),
                    child: Text('ตกลง', style: TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
