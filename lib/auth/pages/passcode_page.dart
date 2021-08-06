import 'dart:ui';
import 'package:flutter/material.dart';
// import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:table_calendar/table_calendar.dart';

// import '../auth_const.dart' as authCons;
import '../../basic/pages/trr_basic_page.dart';
import '../widgets/numpad_widget.dart';
import '../../basic/models/trr_object.dart';
import '../../nav_page.dart';
import '../../global_const.dart' as cons;
import '../../user/models/trr_preference_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/update/bloc/update_user_bloc.dart';
import '../../bloc/user/shared_preference/bloc/user_preference_bloc.dart';
import './forgot_password_page.dart';
import '../../bloc/user/person/bloc/retrieve_person_data_bloc.dart';
import '../../user/models/person_data_model.dart';

import 'package:local_auth/local_auth.dart';
// const kLogoHeroTag = 100;

typedef OnTapBackEvent = void Function();

enum PasscodeInputType {
  SetupPasscode, // first setup
  ConfirmPasscode,
  LoginPasscode,
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

// ignore: must_be_immutable
class PasscodePage extends TrrBasicPageStatefulWidget {
  final int maxDigit;
  final String userPasscode;
  final OnTapBackEvent onBackButtonTap;
  final PasscodeInputType inputType;

  PasscodePage({
    Key key,
    TrrData dataObj,
    this.maxDigit = 6,
    this.userPasscode = '',
    this.onBackButtonTap,
    this.inputType = PasscodeInputType.SetupPasscode,
  }) : super(key: key, dataObj: dataObj);

  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends TrrBasicPageState<PasscodePage>
    with SingleTickerProviderStateMixin {
  AnimationController dotController;
  Animation<double> dotAnim;

  String inputPasscode = '';
  int digitCount;

  final String settingPasscodeLabel = 'กรุณาตั้งรหัส 6 หลัก';
  final String confirmPasscodeLabel = 'กรุณายืนยันรหัสผ่านอีกครั้ง';
  final String inputPasscodeLable = 'กรุณาใส่รหัสผ่าน';

  final _prefDataObj = TrrPreferenceData.instance;
  // final _trrDataObj = TrrObj

  @override
  void initState() {
    super.initState();
    switch (widget.inputType) {
      case PasscodeInputType.SetupPasscode:
        digitCount = widget.maxDigit;
        break;
      default:
        digitCount = widget.userPasscode.length;
        break;
    }

    dotController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    dotAnim = Tween(begin: 0.0, end: 30.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(dotController);
    dotAnim.addStatusListener(_dotShakeMotion);
  }

  _dotShakeMotion(AnimationStatus aStatus) {
    if (aStatus == AnimationStatus.completed) dotController.reverse();
  }

  @override
  void dispose() {
    dotController.dispose();
    super.dispose();
  }

  List<Widget> _displayPasscode(String aCurrentPasscode) {
    var dotList = <Widget>[];

    for (int i = 0; i <= digitCount - 1; i++) {
      dotList.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          alignment: Alignment.center,
          child: PasscodeDot(
            filled: i < this.inputPasscode.length,
            numStr: (i < inputPasscode.length) ? inputPasscode[i] : '',
          ),
        ),
      );
    }
    return dotList;
  }

  Widget _passcodeDisplay(String aCurrentPasscode) {
    return AnimatedBuilder(
      animation: dotAnim,
      builder: (context, _) {
        return Container(
          height: dvHeight * 0.06,
          padding: EdgeInsets.only(
            left: dotAnim.value + 30.0,
            right: 30.0 - dotAnim.value,
          ),
          child: Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _displayPasscode(aCurrentPasscode),
            ),
          ),
        );
      },
    );
  }

  void _doOnNumpadTap(NumpadData aNumpadKey) {
    switch (aNumpadKey) {
      case NumpadData.delete:
        _deletePasscode();
        break;
      case NumpadData.back:
        switch (widget.inputType) {
          case PasscodeInputType.LoginPasscode:
            // go to forgot password page
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ForgotPasswordPage();
            }));
            break;
          case PasscodeInputType.ConfirmPasscode:
            Navigator.pop(
                pageContext); // Otherwise pop back to setup passcode page
            break;
          default:
            break;
        }

        // Check if back button has event
        if (widget.onBackButtonTap != null) widget.onBackButtonTap();
        break;
      default:
        _insertPasscode(aNumpadKey.index);
    }
  }

  _insertPasscode(int aNumValue) {
    setState(() {
      if (inputPasscode.length < digitCount) {
        inputPasscode += '$aNumValue';
      }
    });
    if (inputPasscode.length == digitCount) _verifyPasscode();
  }

  _deletePasscode() {
    if (inputPasscode.length > 0) {
      setState(() {
        inputPasscode = inputPasscode.substring(0, inputPasscode.length - 1);
      });
    }
  }

  _verifyPasscode() {
    // Production code
    // if page using for login or confirm passcode
    if (widget.inputType == PasscodeInputType.LoginPasscode ||
        widget.inputType == PasscodeInputType.ConfirmPasscode) {
      // validate input and user passcode
      if (inputPasscode == widget.userPasscode) {
        // if current page is Confirm passcode page
        if (widget.inputType == PasscodeInputType.ConfirmPasscode) {
          // print('${this.runtimeType} userID : ${_prefDataObj.userID} - is special : ${_prefDataObj.isSpecialUser}');
          // Update passcode to preference data object
          _prefDataObj.passcode = inputPasscode;
          // _prefDataObj.deviceToken = 'xxxxxxxxxxxxxxxxxxxxxxxxx';
          // save setup data to user_enroll table and
          // get idUserEnroll back from database by BLOC
          UpdateUserBloc updateUserBloc =
              BlocProvider.of<UpdateUserBloc>(pageContext);
          updateUserBloc.add(UpdateUserEnrollNewUserEvent(_prefDataObj));
        } else {
          // if the is Login page then just prepare person data
          // doesn't has to save anything in preferrence
          _preparePersonData(_prefDataObj);
          // _gotoHomePage();
        }
      } else
        _shakeAndReset(); // otherwise reset current input passcode
    } else {
      // if page using for first setting up passcode
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        // navigate to passcode page again and create page for confirm passcode
        return PasscodePage(
          userPasscode: inputPasscode,
          inputType: PasscodeInputType.ConfirmPasscode,
          onBackButtonTap: _onHandleConfirmPageTapBack,
          dataObj: widget.dataObj,
        );
      }));
    }
  }

  _gotoHomePage() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => NavPage()), (route) => false);
  }

  _resetPasscode() {
    setState(() {
      inputPasscode = '';
    });
  }

  _shakeAndReset() {
    dotController.forward().then((_) => _resetPasscode());
  }

  void _onHandleConfirmPageTapBack() {
    _resetPasscode();
  }

  void _preparePersonData(TrrPreferenceData aPrefData) {
    RetrievePersonDataBloc retrievePersonBloc =
        BlocProvider.of<RetrievePersonDataBloc>(pageContext);
    if (aPrefData.isSpecialUser) {
      // call API to get SpecialPersonDataModel
      retrievePersonBloc
          .add(RetrieveSpecialPersonDataEvent(aPrefData.userSpecialID));
    } else {
      // call API to get NormalPersonDataModel
      retrievePersonBloc.add(
          RetrieveNormalPersonDataEvent(aPrefData.userID, aPrefData.factoryID));
    }
  }

  void _initLoginUserData(BasicPersonDataModel aCurrentPersonObj,
      TrrPreferenceData aPreferenceDataObj) {
    widget.dataObj
        .generateUserObjByPersonData(aCurrentPersonObj, aPreferenceDataObj);
  }

  /* Build method */
  @override
  Widget internalBuild(BuildContext context) {
    return Scaffold(
      body: _passcodePageUI(),
    );
  }

  Widget _passcodePageUI() {
    UpdateUserBloc updateUserBloc =
        BlocProvider.of<UpdateUserBloc>(pageContext);
    UserPreferenceBloc prefBloc =
        BlocProvider.of<UserPreferenceBloc>(pageContext);
    RetrievePersonDataBloc retrieveBloc =
        BlocProvider.of<RetrievePersonDataBloc>(pageContext);

    return Container(
      child: Stack(
        children: [
          _background(),
          MultiBlocListener(
            listeners: [
              // Listening when finish enroll user to database
              BlocListener<UpdateUserBloc, UpdateUserState>(
                listener: (context, updateUserState) {
                  if (updateUserState is UpdateNewUserComplete &&
                      updateUserBloc.isEnrollNewUserSuccess) {
                    // Get this state after enroll user data to backend
                    // Retrieve user enroll ID from API and set to preference data
                    _prefDataObj.userEnrollID = updateUserBloc.newUserEnrollID;

                    // Next thing to do is save setting to device preference
                    prefBloc.add(UserPreferenceSaveToDevicePreferenceEvent(
                        _prefDataObj));
                  }
                },
              ),
              // Listening when save preference data to device completed
              BlocListener<UserPreferenceBloc, UserPreferenceState>(
                listener: (context, prefState) {
                  if (prefState is SaveUserPreferenceComplete) {
                    // Check type of user between NormalUser or SpecialUser
                    // Then call BloC to get data from API
                    _preparePersonData(_prefDataObj);
                  }
                },
              ),
              BlocListener<RetrievePersonDataBloc, RetrievePersonDataState>(
                listener: (context, retrieveState) {
                  if (retrieveState is RetrievePersonDataCompleteState &&
                      retrieveBloc.currentPersonObjPointer != null) {
                    // initial global TrrData object
                    _initLoginUserData(
                        retrieveBloc.currentPersonObjPointer, _prefDataObj);
                    _gotoHomePage();
                  }
                },
              ),
            ],
            child: BlocBuilder<UpdateUserBloc, UpdateUserState>(
                builder: (context, updateUserState) {
              return BlocBuilder<UserPreferenceBloc, UserPreferenceState>(
                  builder: (context, preferenceState) {
                return BlocBuilder<RetrievePersonDataBloc,
                    RetrievePersonDataState>(
                  builder: (context, retrieveState) {
                    bool _someBlocProcessing =
                        (updateUserState is UpdatingNewUser ||
                            preferenceState is SavingUserPreference ||
                            retrieveState is RetrievingPersonDataState);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _logoAndCloseButton(_someBlocProcessing),
                        _pageCaption(),
                        (_someBlocProcessing)
                            ? SizedBox()
                            : _passcodeDisplay(inputPasscode),
                        (_someBlocProcessing)
                            ? Expanded(child: _newEnrollUserProgress())
                            : _numpadKeyboard(),
                      ],
                    );
                  },
                );
              });
            }),
          ),
          _biometricSection(),
        ],
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth/passcode_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 20),
        child: Container(
          color: Colors.black.withOpacity(0.45),
        ),
      ),
    );
  }

  Widget _logoAndCloseButton(bool aIsSomeBlocProcessing) {
    return Container(
      margin: EdgeInsets.only(top: dvHeight * 0.09),
      height: dvHeight * 0.12,
      child: Stack(
        children: [
          Container(
            child: Align(
              child: Image(
                  image: AssetImage('assets/images/landing/big_logo.png'),
                  color: Colors.white,
                  width: dvWidth * 0.2),
            ),
          ),
          (widget.inputType == PasscodeInputType.ConfirmPasscode)
              ? Container() // confirm passcode page doesn't show close button
              // else if in during process bloc state then hide close button too
              : (aIsSomeBlocProcessing)
                  ? Container()
                  : Positioned(
                      right: 20,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 32, color: Colors.white),
                        onPressed: () {
                          if (Platform.isAndroid)
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          else if (Platform.isIOS) MinimizeApp.minimizeApp();
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _pageCaption() {
    String pageLabel = inputPasscodeLable;
    switch (widget.inputType) {
      case PasscodeInputType.SetupPasscode:
        pageLabel = settingPasscodeLabel;
        break;
      case PasscodeInputType.ConfirmPasscode:
        pageLabel = confirmPasscodeLabel;
        break;
      default:
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        pageLabel,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _numpadKeyboard() {
    bool canShowBackButton =
        (widget.inputType == PasscodeInputType.ConfirmPasscode ||
            widget.inputType == PasscodeInputType.LoginPasscode);
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: NumpadWidget(
        onNumpadTap: _doOnNumpadTap,
        isShowDeleteButton: inputPasscode.length > 0,
        isShowBackButton: canShowBackButton,
        isShowForgotPasscode:
            widget.inputType == PasscodeInputType.LoginPasscode,
      ),
    );
  }

  Widget _newEnrollUserProgress() {
    return Align(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(cons.kGoldColor),
          strokeWidth: 8,
        ),
      ),
    );
  }

  Widget _biometricSection() {
    return Positioned(
      bottom: 30,
      right: 30,
      left: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _faceAuthenButton(),
          SizedBox(width: 10),
          _fingerprintAuthenButton(),
        ],
      ),
    );
  }

  Widget _faceAuthenButton() {
    return Container(
      width: 64,
      height: 64,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), side: BorderSide.none),
        color: Colors.yellow.withOpacity(0.1),
        child: FittedBox(
          child: Icon(Icons.face_unlock_outlined,
              color: Colors.white.withOpacity(0.8), size: 38),
        ),
      ),
    );
  }

  Widget _fingerprintAuthenButton() {
    return Container(
      width: 64,
      height: 64,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), side: BorderSide.none),
        color: Colors.yellow.withOpacity(0.1),
        child: FittedBox(
          child: Icon(Icons.fingerprint,
              color: Colors.white.withOpacity(0.8), size: 38),
        ),
      ),
    );
    // child: Container(
    //   height: 60,
    //   width: 60,
    //   decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.1), shape: BoxShape.circle),
    //   padding: EdgeInsets.all(8.0),
    //   child: FittedBox(child: Icon(Icons.fingerprint, color: Colors.white.withOpacity(0.8))),
    // ),
  }

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
      print(authenticated);
      if (authenticated) {
        _gotoHomePage();
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: Text("ทำรายการไม่สำเร็จ"),
                content: Container(
                  width: 200,
                  child: Text("ข้อมูลลายนิ้วมือไม่ถูกต้อง"),
                ),
                actions: [
                  TextButton(
                    child: Text("ปิด"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text("ทำรายการไม่สำเร็จ"),
              content: Container(
                width: 200,
                child: Text("คุณยังไม่ได้ติดตั้งสแกนนิ้วบนอุปกรณ์ของคุณ"),
              ),
              actions: [
                TextButton(
                  child: Text("ปิด"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  // SnackBar _snackBar() {
  //   final resultSnackBar = SnackBar(
  //     content: Container(
  //         padding: EdgeInsets.all(2),
  //         child: Text(
  //           'Passcode CORRECT!',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.0),
  //         )),
  //     backgroundColor: Colors.blueAccent,
  //     behavior: SnackBarBehavior.floating,
  //     elevation: 10.0,
  //     margin: EdgeInsets.all(6),
  //     duration: Duration(seconds: 3),
  //   );
  //   return resultSnackBar;
  // }
}

// return Container(
//   child: Stack(
//     children: [
//       _background(),

//       BlocConsumer<UpdateUserBloc, UpdateUserState>(
//         listener: (context, state) {
//           if (state is UpdateNewUserComplete && (updateUserBloc.isEnrollNewUserSuccess)) {
//             _prefDataObj.userEnrollID = updateUserBloc.newUserEnrollID;

//             // Save data to prefernce
//             prefBloc.add(UserPreferenceSaveToDevicePreferenceEvent(_prefDataObj));
//           }
//         },

//         builder: (context, updateUserState) {
//           return BlocBuilder<UserPreferenceBloc, UserPreferenceState>(
//             builder: (context, preferenceState) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   _logoAndCloseButton(),
//                   _pageCaption(),
//                   (updateUserState is UpdatingNewUser || preferenceState is SavingUserPreference) ? SizedBox() : _passcodeDisplay(inputPasscode),
//                   (updateUserState is UpdatingNewUser || preferenceState is SavingUserPreference)
//                       ? Expanded(child: _newEnrollUserProgress())
//                       : _numpadKeyboard(),
//                 ],
//               );
//             },
//           );
//         },
//         // builder: (context, updateUserState) {
//         //   return Column(
//         //     mainAxisAlignment: MainAxisAlignment.start,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     mainAxisSize: MainAxisSize.max,
//         //     children: [
//         //       _logoAndCloseButton(),
//         //       _pageCaption(),
//         //       (updateUserState is UpdatingNewUser) ? SizedBox() : _passcodeDisplay(inputPasscode),
//         //       (updateUserState is UpdatingNewUser) ? Expanded(child: _newEnrollUserProgress()) : _numpadKeyboard(),
//         //     ],
//         //   );
//         // },
//       ),
//     ],
//   ),
// );

// return Container(
//   child: Stack(
//     children: [
//       _background(),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           _logoAndCloseButton(),
//           _pageCaption(),
//           _passcodeDisplay(inputPasscode),
//           _numpadKeyboard(),
//         ],
//       ),
//     ],
//   ),
// );

// Testing code
// switch (widget.inputType) {
//   // First time setup passcode
//   case PasscodeInputType.SetupPasscode:
//     // Go to confirm passcode page agian
//     Navigator.push(context, MaterialPageRoute(builder: (ctx) {
//       return PasscodePage(
//         userPasscode: inputPasscode,
//         inputType: PasscodeInputType.ConfirmPasscode,
//         onBackButtonTap: _onHandleConfirmPageTapBack,
//       );
//     }));
//     break;
//   // Confirm passcode
//   case PasscodeInputType.ConfirmPasscode:
//     if (inputPasscode == widget.userPasscode)
//       // save setting data to device preference
//       // before go to homepage
//       _gotoHomePage();
//     else
//       _shakeAndReset();
//     break;
//   // Login Passcode screen
//   case PasscodeInputType.LoginPasscode:
//     // testing code by pass to home
//     // if (inputPasscode.length == widget.maxDigit) _gotoHomePage();

//     // check passcode matched and go to homepage
//     if (inputPasscode == widget.userPasscode)
//       // maybe update device token to database and go to homepage
//       _gotoHomePage();
//     else
//       _shakeAndReset();
//     break;
//   default:
//     break;
// }
