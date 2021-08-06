import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

import '../global_const.dart' as cons;
import '../global_utils.dart' as util;

ThemeData trrAppTheme() {
  return ThemeData(
      primaryColor: cons.kSolidBlueColor,
      primaryColorLight: Colors.white,
      accentColor: Colors.white,
      // splashColor: cons.kBlueColor,
      fontFamily: cons.kDefFontFamily,
      // primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 22),
        subtitle2: TextStyle(fontSize: 22),
        bodyText2: TextStyle(fontSize: 22),
        caption: TextStyle(fontSize: 16),
        button: TextStyle(fontSize: 22),
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: TextStyle(fontFamily: cons.kDefFontFamily, fontSize: 18),
        labelColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontFamily: cons.kDefFontFamily, fontSize: 18),
        unselectedLabelColor: Colors.grey,
      )
      // pageTransitionsTheme: PageTransitionsTheme(
      //   builders: {
      //     TargetPlatform.android: GlobalPageTransitionBuilder(),
      //     TargetPlatform.iOS: GlobalPageTransitionBuilder(),
      //   },
      // ),
      );
}

class GlobalPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _pageSlideTransitionEffect(animation, child);

    // if (route.settings.name == '/')
    //   return child;
    // else
    //   return Builder(builder: (ctx) {
    //     return _pageSlideTransitionEffect(animation, Offset(1, 0), child);
    //   });
  }

  Widget _pageSlideTransitionEffect(
    Animation aAnim,
    // Offset aBeginOffset,
    Widget aChild, [
    Curve aCurve = Curves.easeInOut,
  ]) {
    return Animator(
      tweenMap: {
        'opacity': Tween<double>(begin: 1, end: 1),
        'motion': Tween<Offset>(begin: Offset(1, 0), end: Offset.zero),
      },
      duration: Duration(milliseconds: 2000),
      cycles: 1,
      curve: aCurve,
      builder: (_, anim, __) => FadeTransition(
        opacity: anim.getAnimation('opacity'),
        child: Transform.translate(
          offset: anim.getValue('motion'),
          child: aChild,
        ),
      ),
    );

    // return SlideTransition(
    //   position: aAnim.drive(
    //     Tween(begin: Offset(1, 0), end: Offset.zero).chain(
    //       CurveTween(curve: aCurve),
    //     ),
    //   ),
    // );
  }
}
