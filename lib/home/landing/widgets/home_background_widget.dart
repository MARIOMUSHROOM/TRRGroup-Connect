import 'package:flutter/material.dart';
import '../../../base_class/pages/ai_base_page.dart';
import '../home_const.dart' as homeCons;
import '../../../global_utils.dart' as util;

// ignore: must_be_immutable
class HomePageBackgroundWidget extends AiBaseStatelessWidget {
  Widget _logoImage({bool isAnimation = true}) {
    Widget _brandLogo() {
      return Image(
        image: AssetImage('assets/images/landing/brand.png'),
        height: 50,
        fit: BoxFit.contain,
      );
    }

    return (isAnimation)
        ? util.zoomOutAnimation(_brandLogo(), aStartSize: 0, aEndSize: 1, aIsFadeWhenDone: false, aCurve: Curves.easeInOut)
        : _brandLogo();
  }

  @override
  Widget internalBuild(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [homeCons.kBeginColor, homeCons.kEndColor],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       stops: [0, 0.2],
        //     ),
        //   ),
        // ),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: homeCons.kSolidBlueColor,
                    image: DecorationImage(
                      alignment: Alignment(0.0, 1.0),
                      image: AssetImage('assets/images/landing/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(color: homeCons.kSolidBlueColor),
              ),
            ],
          ),
        ),
        Positioned(
          top: dvHeight * 0.040,
          left: 0,
          right: 0,
          child: Align(alignment: Alignment.topCenter, child: _logoImage()),
        ),
        Positioned(
          bottom: dvHeight * 0.030,
          left: 0,
          right: 0,
          child: Align(alignment: Alignment.topCenter, child: _logoImage(isAnimation: false)),
        ),
      ],
    );
  }
}
