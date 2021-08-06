import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:otp_text_field/style.dart';
import '../../basic/pages/trr_basic_page.dart';
import '../../global_const.dart' as cons;
import '../../global_utils.dart' as util;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/otp/bloc/otp_bloc.dart';
import '../../user/models/otp_model.dart';
import '../../user/models/validate_otp_model.dart';
import '../../bloc/user/validate_otp/bloc/validate_otp_bloc.dart';
import './passcode_page.dart';
import '../../basic/models/trr_object.dart';

class InputOtpPage extends TrrBasicPageStatefulWidget {
  final String phoneNumber;

  InputOtpPage({Key key, @required this.phoneNumber}) : super(key: key);

  @override
  _InputOtpPageState createState() => _InputOtpPageState();
}

class _InputOtpPageState extends TrrBasicPageState<InputOtpPage> {
  String inputOtp = '';
  final ValidateOtpData _otpData = ValidateOtpData.instance;
  final TrrData globalTrrDataObj = TrrData.instance;

  bool get isValidPreparing => _otpData.isValidPreparing;
  bool get isInputOtpExist => _otpData.isOtpReady;
  // bool _isOtpError = false;

  /* List of Method */
  //=======================================================================================
  void _validateOtp() {
    ValidateOtpBloc validateOtpBloc = BlocProvider.of<ValidateOtpBloc>(pageContext);
    validateOtpBloc.add(SendOtpToValidateEvent(_otpData));
  }

  void _gotoSetupPasscodePage() {
    // print('${this.runtimeType} : Show setup Passcode Page');
    // Save pass OTP process to preference
    Navigator.push(
      pageContext,
      MaterialPageRoute(
        builder: (context) => PasscodePage(
          inputType: PasscodeInputType.SetupPasscode,
          dataObj: globalTrrDataObj,
        ),
      ),
    );
  }

  void _requestOtpAgain() {
    OtpBloc reqOtpBloc = BlocProvider.of<OtpBloc>(pageContext);
    reqOtpBloc.add(OtpRequestEvent(widget.phoneNumber));
  }

  _showErrorDialog(ValidateOtpStatus aValidateOtpStatus) async {
    String _dialogCaption = '';

    switch (aValidateOtpStatus) {
      case ValidateOtpStatus.InvalidCode:
        _dialogCaption = 'รหัส OTP ไม่ถูกต้อง\nกรุณาลองใหม่อีกครั้ง';
        break;
      case ValidateOtpStatus.OtpAlreadyUsed:
        _dialogCaption = 'รหัสอ้างอิงซ้ำ\nกรุณาลองใหม่อีกครั้ง';
        break;
      default:
        break;
    }

    await showDialog(
      context: pageContext,
      builder: (ctx) {
        return util.verticalAnimation(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: dvWidth * 0.80,
              height: dvHeight * 0.38,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(image: AssetImage('assets/images/auth/invalid_user.png'), fit: BoxFit.cover, width: 100),
                    Expanded(
                      child: Align(
                        child: Text(_dialogCaption, style: TextStyle(fontSize: 28), textAlign: TextAlign.center),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: cons.kSolidBlueColor,
                          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 6),
                        ),
                        child: Text('ตกลง', style: TextStyle(fontSize: 28)),
                        onPressed: () {
                          // inputOtp = '';
                          Navigator.of(pageContext).pop();
                          // setState(() {
                          //   _isOtpError = true;
                          // });
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /* List of Widget */
  //=======================================================================================
  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back, color: Colors.black),
            onTap: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        body: Align(
          child: _inputOtpPageUI(),
        ),
      ),
    );
  }

  Widget _inputOtpPageUI() {
    OtpBloc otpBloc = BlocProvider.of<OtpBloc>(pageContext);

    return SingleChildScrollView(
      child: BlocBuilder<OtpBloc, OtpState>(builder: (context, state) {
        Widget result;

        if (state is OtpInitial || state is OtpRequesting)
          result = _loadingView();
        else if (state is OtpRequestComplete) {
          _otpData.clear();

          RequestOtpResult requestOtpResultObj = otpBloc.requestOtpResult;

          switch (requestOtpResultObj.resultStatus) {
            case RequestOtpStatus.Success:
              // prepare OTP data for this page
              _otpData.prepareData(
                requestOtpResultObj.otpApiKey,
                requestOtpResultObj.otpApiSecret,
                requestOtpResultObj.otpToken,
                requestOtpResultObj.otpValidateUrl,
                inputOtp,
              );

              result = _inputOtpView();
              break;
            case RequestOtpStatus.Fail:
              result = _inputOtpView();
              break;
            default:
              result = _inputOtpView();
          }
        } else if (state is OtpSystemNotResponse) result = _errorView();
        return result;
      }),
    );
  }

  Widget _inputOtpView() {
    return Container(
      width: dvWidth * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _contentText(),
          _otpDisplayBox(),
          _confirmOtpSection(),
          if (!this.isValidPreparing) _resendOtpButton(),
        ],
      ),
    );
  }

  Widget _loadingView() {
    return Container(
      child: Align(
        child: Column(
          children: [
            Text(
              '..กรุณารอสักครู่..\nระบบกำลังส่งรหัส OTP ไปที่เบอร์ของท่าน',
              style: TextStyle(color: cons.kSolidBlueColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(cons.kSolidBlueColor), strokeWidth: 5),
          ],
        ),
      ),
    );
  }

  Widget _errorView() {
    return Align(
      child: Text('ขออภัยไม่สามารถดึงข้อมูลได้ในขณะนี้..', style: TextStyle(fontSize: 28, color: cons.kSolidBlueColor)),
    );
  }

  Widget _contentText() {
    final String _confirmOtp = 'รหัสยืนยัน (OTP\nได้ส่งไปที่เบอร์โทรศัพท์ ${widget.phoneNumber} แล้ว)';
    final String _resendOtp = 'ขออภัย..เกิดข้อผิดพลาด\nกรุณากดส่งใหม่อีกครั้งเพื่อรับรหัส OTP';
    String _caption = (isValidPreparing) ? _confirmOtp : _resendOtp;

    return Column(
      children: [
        Text('ยืนยันรหัส', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        Text(
          _caption,
          style: TextStyle(color: Colors.grey[600], fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _otpTextField() {
    return OTPTextField(
      length: 6,
      width: dvWidth * 0.6,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      style: TextStyle(fontSize: 28),
      onChanged: (input) {
        inputOtp = input;
        setState(() {
          // update view when otp digit input
        });
      },
      onCompleted: (input) => inputOtp = input,
    );

    // ValidateOtpBloc bloc = BlocProvider.of<ValidateOtpBloc>(pageContext);
    // return BlocBuilder<ValidateOtpBloc, ValidateOtpState>(
    //   builder: (context, state) {
    //     if (state is ValidateOtpFinishState)
    //     return OTPTextField(
    //       length: 6,
    //       width: dvWidth * 0.6,
    //       textFieldAlignment: MainAxisAlignment.spaceAround,
    //       fieldStyle: FieldStyle.underline,
    //       style: TextStyle(fontSize: 28),
    //       onChanged: (input) {
    //         inputOtp = input;
    //         setState(() {
    //           // update view when otp digit input
    //         });
    //       },
    //       onCompleted: (input) => inputOtp = input,
    //     );
    //   },
    // );
  }

  Widget _otpDisplayBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: dvHeight * 0.09,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.8),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: (!isValidPreparing) ? SizedBox(width: dvWidth * 0.6) : _otpTextField(),

        // child: Builder(
        //   builder: (_) {
        //     Widget result;
        //     if (!isValidPreparing)
        //       result = SizedBox(width: dvWidth * 0.6);
        //     else
        //       result = _otpTextField();
        //     return result;
        //   },
        // ),

        // child: (!isValidPreparing)
        //     ? SizedBox(width: dvWidth * 0.6)
        //     : OTPTextField(
        //         length: 6,
        //         width: dvWidth * 0.6,
        //         textFieldAlignment: MainAxisAlignment.spaceAround,
        //         fieldStyle: FieldStyle.underline,
        //         style: TextStyle(fontSize: 28),
        //         onChanged: (input) {
        //           inputOtp = input;
        //           setState(() {
        //             // update view when otp digit input
        //           });
        //         },
        //         onCompleted: (input) {
        //           inputOtp = input;
        //           // otpData.pin = input;
        //         },
        //       ),
      ),
    );
  }

  Widget _confirmOtpSection() {
    ValidateOtpBloc validateOtpBloc = BlocProvider.of<ValidateOtpBloc>(pageContext);
    return BlocConsumer<ValidateOtpBloc, ValidateOtpState>(
      listener: (context, state) {
        // Listen to verified OTP result
        if (state is ValidateOtpFinishState) {
          ValidateOtpStatus _validStatus = validateOtpBloc.validateResult.status;
          switch (_validStatus) {
            case ValidateOtpStatus.Correct:
              // If OTP is correct then go to set up passcode
              _gotoSetupPasscodePage();
              break;
            default: // Stay on this page
              // ScaffoldMessenger.of(pageContext).showSnackBar(_snackBar(_validStatus));
              _showErrorDialog(_validStatus);
              break;
          }
        }
      },
      builder: (context, state) {
        // Graping state when validating OTP
        Widget result;
        if (state is ValidatingOtpState)
          // If validating OTP then show spinning circle
          result = _validatingOtpProgress();
        else
          // Otherwise show clickable button
          result = _confirmOtpButton();
        return result;
      },
    );
  }

  Widget _confirmOtpButton() {
    return ElevatedButton(
      onPressed: (isValidPreparing && isInputOtpExist) ? _validateOtp : null,
      style: ElevatedButton.styleFrom(
        elevation: (isValidPreparing && isInputOtpExist) ? 2 : 0,
        primary: (isValidPreparing && isInputOtpExist) ? cons.kGoldColor : cons.kPageBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      ),
      child: Text('ยืนยันตัวตน'),
    );
  }

  Widget _validatingOtpProgress() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: SizedBox(
          height: 34,
          width: 34,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(cons.kGoldColor),
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }

  Widget _resendOtpButton() {
    return TextButton(
      onPressed: _requestOtpAgain,
      child: Text('ส่งใหม่อีกครั้ง', style: TextStyle(color: cons.kGoldColor)),
    );
  }

  // SnackBar _snackBar(ValidateOtpStatus aValidateOtpStatus) {
  //   String s = '';
  //   switch (aValidateOtpStatus) {
  //     case ValidateOtpStatus.InvalidCode:
  //       s = 'รหัส OTP ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง';
  //       break;
  //     case ValidateOtpStatus.OtpAlreadyUsed:
  //       s = 'รหัสอ้างอิงซ้ำ กรุณาลองใหม่อีกครั้ง';
  //       break;
  //     default:
  //       break;
  //   }
  //   final resultSnackBar = SnackBar(
  //     content: Container(
  //       padding: EdgeInsets.all(2),
  //       child: Text(s, style: TextStyle(fontFamily: cons.kDefFontFamily, fontSize: 22, height: 1.0)),
  //     ),
  //     backgroundColor: cons.kSolidBlueColor,
  //     behavior: SnackBarBehavior.floating,
  //     elevation: 10.0,
  //     margin: EdgeInsets.all(6),
  //     duration: Duration(seconds: 5),
  //   );
  //   return resultSnackBar;
  // }

}
