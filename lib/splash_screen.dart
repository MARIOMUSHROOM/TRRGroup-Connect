import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import './basic/pages/trr_basic_page.dart';
import './auth/pages/passcode_page.dart';
import './auth/pages/register_front_page.dart';
import './global_const.dart' as cons;
import './global_utils.dart' as util;

import 'user/models/guest_user_json_model.dart';

// import 'user/models/trr_shared_preference_model.dart';
// import './bloc/user/validate_user/bloc/validate_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/user/shared_preference/bloc/user_preference_bloc.dart';
import './user/models/trr_preference_data.dart';
import './basic/models/trr_object.dart';

const kAnimOpacity = 'opacity';
const kAnimScale = 'scale';
const kAnimMotion = 'motion';

const kCompanyNameTH = 'กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง';
const kCompanyNameEN = 'Thai Roong Ruang Sugar Group';

class SplashScreen extends TrrBasicPageStatefulWidget {
  static String pageName = 'splash_page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends TrrBasicPageState<SplashScreen>
    with TickerProviderStateMixin {
  bool finishAnimated = false;

  final TrrPreferenceData preferenceData = TrrPreferenceData.instance;
  final TrrData globalTrrDataObj = TrrData.instance; // Reference to global object

  UserPreferenceBloc prefBloc;

  final Widget _logo = Image.asset('assets/images/auth/logo_image.gif',
      fit: BoxFit.contain, width: 150);

  final Widget _logoText = Container(
    child: Column(
      children: [
        Text(
          kCompanyNameTH,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: cons.kGoldColor,
              fontSize: 36,
              fontWeight: FontWeight.bold),
        ),
        Text(
          kCompanyNameEN,
          style: TextStyle(
              color: cons.kGoldColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 0.8),
        ),
      ],
    ),
  );
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((String token) async {
      print("device token = $token");
    });
    animController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animController.repeat();
    super.initState();
  }

  AnimationController animController;

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget internalBuild(BuildContext context) {
    // GuestUserJsonModel test = GuestUserJsonModel();
    // print('guest id : ${test.idUserGuest} userName: ${test.userName}');
    // initialized preference bloc object
    // FocusScope.of(context).unfocus();
    util.hideCurrentKeyboard();
    prefBloc = BlocProvider.of<UserPreferenceBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: BlocListener<UserPreferenceBloc, UserPreferenceState>(
          listener: (context, state) {
            if (state is UserPreferenceLoadFinished) _gotoAppropriatePage();
          },
          child: Stack(
            children: [
              _background(),
              _foregroundAnim(),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoAppropriatePage() {
    // print('${this.runtimeType} - userEnrollID : ${preferenceData.userEnrollID}');
    debug(
        'userEnrollID : ${preferenceData.userEnrollID} / User Passcode : ${preferenceData.passcode} / isSpecial : ${preferenceData.isSpecialUser} / userID : ${preferenceData.userID}');
    Future.delayed(
      Duration(milliseconds: 1800),
      () {
        if (preferenceData.isAlreadyEnroll)
          // If not enrolled then navigate to Login Passcode Page
          Navigator.pushReplacement(
            pageContext,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 800),
              pageBuilder: (context, _, __) => PasscodePage(
                inputType: PasscodeInputType.LoginPasscode,
                userPasscode: preferenceData.passcode,
                dataObj: globalTrrDataObj,
              ),
            ),
          );
        else {
          // Navigate to Register Page
          Navigator.pushReplacement(
            pageContext,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1200),
              pageBuilder: (context, _, __) => RegisterFrontPage(),
            ),
          );
        }
      },
    );
  }

  Widget _foregroundAnim() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child:
                  Align(child: _animLogo(), alignment: Alignment.bottomCenter),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: _animatedTextLogo(),
                ),
                Expanded(
                  child: (finishAnimated)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(
                                strokeWidth: 5,
                                valueColor: animController.drive(ColorTween(
                                  begin: cons.kGoldColor,
                                  end: cons.kSolidBlueColor,
                                ))),
                          ),
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _animLogo() {
    return Container(
      child: Animator(
        tween: Tween<double>(begin: 0.5, end: 1),
        cycles: 1,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 2000),
        builder: (_, anim, __) {
          return Opacity(
            opacity: anim.value,
            child: _logo,
            // child: Hero(tag: authCons.kLogoHeroTag, child: _logo),
          );
        },
        endAnimationListener: (anim) {
          if (anim.animation.status == AnimationStatus.completed) {
            return _animatedTextLogo();
          }
        },
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth/register_background.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _animatedTextLogo() {
    return Container(
      child: Animator(
        tweenMap: {
          kAnimOpacity: Tween<double>(begin: -1, end: 1),
          kAnimScale: Tween<double>(begin: 1, end: 1),
          kAnimMotion: Tween<Offset>(begin: Offset(0, 50), end: Offset(0, -12)),
        },
        cycles: 1,
        curve: Curves.easeInExpo,
        duration: Duration(milliseconds: 3500),
        builder: (_, anim, __) {
          return Align(
            child: FadeTransition(
              opacity: anim.getAnimation(kAnimOpacity),
              child: Transform.scale(
                  scale: anim.getValue(kAnimScale),
                  child: Transform.translate(
                    offset: anim.getValue(kAnimMotion),
                    child: _logoText,
                  )),
            ),
          );
        },
        endAnimationListener: (anim) {
          if (anim.animation.status == AnimationStatus.completed) {
            if (!finishAnimated) {
              setState(() {
                finishAnimated = true;
              });
              // Bloc object start to load preference from device
              if (prefBloc != null)
                prefBloc.add(
                    UserPreferenceRequestDevicePreferenceEvent(preferenceData));
            }
          }
        },
      ),
    );
  }
}
