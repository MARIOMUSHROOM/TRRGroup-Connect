// import 'package:ai_flutter/user/const.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../basic/pages/trr_basic_page.dart';
import '../auth_const.dart' as authCons;
// import '../auth_util.dart' as authUtil;
import './input_otp_page.dart';
import '../../global_utils.dart' as util;
import '../../global_const.dart' as cons;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/otp/bloc/otp_bloc.dart';
import '../../bloc/user/validate_user/bloc/validate_user_bloc.dart';

// import '../../user/models/otp_model.dart';
import '../../user/models/validate_user_model.dart';
import '../../user/models/trr_preference_data.dart';
import '../../user/models/special_user_json_model.dart';
import '../auth_util.dart' as authUtil;
import './guest_login_page.dart';
import '../../basic/models/trr_object.dart';

class RegisterFrontPage extends TrrBasicPageStatefulWidget {
  @override
  _RegisterFrontPageState createState() => _RegisterFrontPageState();
}

class _RegisterFrontPageState extends TrrBasicPageState<RegisterFrontPage> {
  GlobalKey<FormState> _formKey;

  TextEditingController _idCardTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  _RegisterFrontPageState() {
    _formKey = GlobalKey<FormState>();
  }

  String idCardNumber;
  String phoneNumber;
  FocusScopeNode _fieldNode;
  // retrieve global TrrPreferenceData object instance
  final TrrPreferenceData _prefDataObj = TrrPreferenceData.instance;
  final TrrData globalTrrDataObj = TrrData.instance;

  @override
  Widget internalBuild(BuildContext context) {
    _fieldNode = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _background(),
            _registerFrontPageUI(),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
        height: dvHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth/register_background.png'),
            fit: BoxFit.fill,
          ),
        ));
  }

  Widget _registerFrontPageUI() {
    ValidateUserBloc validateUserBloc = BlocProvider.of<ValidateUserBloc>(pageContext);
    double heightFactor = (Platform.isIOS) ? 0.90 : 0.96;
    return SingleChildScrollView(
      child: Container(
        height: dvHeight * heightFactor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: dvHeight * 0.2),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _logoImage(),
                  util.verticalAnimation(_registrationForm(), aStartPosition: 60, aMilliseconds: 1500),
                  BlocConsumer<ValidateUserBloc, ValidateUserState>(
                    // Building UI
                    builder: (context, state) {
                      Widget element;
                      if (state is ValidateUserLoadingState)
                        element = _validatingUserProgressView();
                      else
                        element = util.verticalAnimation(_registerButton(), aStartPosition: -60, aMilliseconds: 1900);
                      return element;
                    },
                    // Listening to go to functions
                    listener: (context, state) {
                      // If finish load state
                      if (state is ValidateUserLoadFinishedState) {
                        switch (validateUserBloc.runningFlag) {
                          // grap 1st round running bloc
                          case ValidateUserBlocRunningFlag.AlreadyCheckedNormalUser:
                            // if found normal TRR user then navigate to OTP page
                            if (validateUserBloc.isFoundNormalUser) {
                              _updatePreferenceDataByNormalUser(validateUserBloc.validateNormalUserObj);
                              _gotoOtpInputPage();
                            } else
                              // if not found normal TRR user then try to find in user_special table
                              validateUserBloc.add(ValidateUserCheckExistingSpecialUserEvent(this.idCardNumber, this.phoneNumber));
                            break;

                          // grap 2nd round of running bloc
                          case ValidateUserBlocRunningFlag.AlreadyCheckedSpecialUser:
                            // if found Special user then got OTP page
                            if (validateUserBloc.isFoundSpecialUser) {
                              _updatePreferenceDataBySpecialUser(validateUserBloc.validateSpecialUserObj);
                              _gotoOtpInputPage();
                            } else
                              // Otherwise mean that not a TRR user then show dialog box
                              util.showErrorTextDialog('คุณไม่มีบัญชีในระบบ\nกรุณาติดต่อเจ้าหน้าที่\n02-345-6789',
                                  referContext: pageContext, deviceHeight: dvHeight, deviceWidth: dvWidth);
                            break;
                          default:
                            break;
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: _guestLoginButton()),
          ],
        ),
      ),
    );
  }

  void _updatePreferenceDataByNormalUser(TrrValidateUser aTrrValidateUser) {
    // update quotaid and factory id to preference object
    _prefDataObj.userID = aTrrValidateUser.quotaId;
    _prefDataObj.factoryID = aTrrValidateUser.factoryId;
    _prefDataObj.inputIDCardNumber = this.idCardNumber;

    print('${this.runtimeType} update to preference data : userID : ${_prefDataObj.userID} : factoryID : ${_prefDataObj.factoryID}');
  }

  void _updatePreferenceDataBySpecialUser(SpecialUserJsonModel aSpecialUserObj) {
    _prefDataObj.userID = aSpecialUserObj.idUser;
    _prefDataObj.factoryID = aSpecialUserObj.idFactory;
    _prefDataObj.inputIDCardNumber = aSpecialUserObj.idCardNumber;
    _prefDataObj.userSpecialID = aSpecialUserObj.idUserSpecial;
    _prefDataObj.isSpecialUser = true;
  }

  void _gotoOtpInputPage() {
    // Request OTP
    OtpBloc otpBloc = BlocProvider.of<OtpBloc>(pageContext);
    // Add event request to OTP bloc
    otpBloc.add(OtpRequestEvent(this.phoneNumber));
    // Navigate to OTP page
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InputOtpPage(phoneNumber: phoneNumber);
    }));
  }

  Widget _validatingUserProgressView() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: SizedBox(
          height: 34,
          width: 34,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(cons.kSolidBlueColor),
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }

  Widget _logoImage() {
    return Hero(
      tag: authCons.kLogoHeroTag,
      child: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('assets/images/landing/big_logo.png'),
          fit: BoxFit.cover,
          width: dvWidth * 0.30,
          color: authCons.kGoldColor,
        ),
      ),
    );
  }

  Widget _registrationForm() {
    return Container(
      width: dvWidth * 0.60,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Theme(
        data: Theme.of(pageContext).copyWith(
          primaryColor: authCons.kGoldColor,
        ),
        child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState.save();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _idCardText(),
              _phoneNumberText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _idCardText() {
    return TextFormField(
      autocorrect: false,
      controller: _idCardTextController,
      keyboardType: TextInputType.number,
      maxLength: 13,
      validator: (input) {
        return (input.isNotEmpty && input.length == 13) ? null : 'เลขที่บัตรประชาชนไม่ถูกต้อง';
      },
      onSaved: (input) {
        setState(() {
          idCardNumber = input;
        });
      },
      decoration: InputDecoration(
        counter: Offstage(),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: 'เลขที่บัตรประชาชน',
        prefixIcon: Icon(Icons.credit_card_outlined),
        fillColor: authCons.kEditColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      onEditingComplete: () => _fieldNode.nextFocus(),
      textInputAction: TextInputAction.next,
    );
  }

  Widget _phoneNumberText() {
    return TextFormField(
      autocorrect: false,
      controller: _phoneTextController,
      keyboardType: TextInputType.number,
      maxLength: 10,

      validator: (input) {
        return (input.isNotEmpty && input.length == 10) ? null : 'เบอร์โทรศัพท์ไม่ถูกต้อง';
      },
      // inputFormatters: [LengthLimitingTextInputFormatter(10)],
      onSaved: (input) {
        setState(() {
          phoneNumber = _phoneTextController.text;
        });
      },
      decoration: InputDecoration(
        counter: Offstage(),
        hintText: 'หมายเลขโทรศัพท์',
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(Icons.phone_iphone_outlined),
        fillColor: authCons.kEditColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  Widget _registerButton() {
    // OtpBloc otpBloc = BlocProvider.of<OtpBloc>(pageContext);

    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          idCardNumber = _idCardTextController.text;
          phoneNumber = _phoneTextController.text;

          // get global validate trr user bloc pointer
          ValidateUserBloc validateUserBloc = BlocProvider.of<ValidateUserBloc>(pageContext);
          // request event
          validateUserBloc.add(ValidateUserCheckExistingUserEvent(this.idCardNumber, this.phoneNumber));
          // validate these idCardNumber and phoneNumber is TRR User from API
          // If validated then request OTP and go to OTP page
          // Else show dialog box to contact to staff
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: authCons.kBlueColor,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      ),
      child: Text('ลงทะเบียน'),
    );
  }

  Widget _guestLoginButton() {
    // double bottomPadding = (Platform.isIOS) ? 20 : 20;
    return Container(
      // height: dvHeight * 0.06,
      padding: EdgeInsets.only(bottom: 0),
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return GuestLoginPage(dataObj: globalTrrDataObj);
          }));
        },
        child: Text(
          'ล๊อคอินด้วยบัญชีบริษัท',
          style: TextStyle(color: cons.kSolidBlueColor, fontSize: 22), //, decoration: TextDecoration.underline),
        ),
      ),
    );
    // return Container(
    //   // color: Colors.red,
    //   child: Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Padding(
    //       padding: const EdgeInsets.only(bottom: 100),
    //       child: TextButton(
    //         onPressed: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (_) {
    //             return GuestLoginPage(dataObj: globalTrrDataObj);
    //           }));
    //         },
    //         child: Text(
    //           'ล๊อคอินด้วยบัญชีบริษัท',
    //           style: TextStyle(color: cons.kSolidBlueColor, fontSize: 22), //, decoration: TextDecoration.underline),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

// return SingleChildScrollView(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisSize: MainAxisSize.max,
//     children: [
//
//       Expanded(flex: 1, child: _guestLoginButton()),
//       // _logoImage(),
//       // util.verticalAnimation(_registrationForm(), aStartPosition: 60, aMilliseconds: 1500),
//       // BlocConsumer<ValidateUserBloc, ValidateUserState>(
//       //   // Building UI
//       //   builder: (context, state) {
//       //     Widget element;
//       //     if (state is ValidateUserLoadingState)
//       //       element = _validatingUserProgressView();
//       //     else
//       //       element = util.verticalAnimation(_registerButton(), aStartPosition: -60, aMilliseconds: 1900);
//       //     return element;
//       //   },
//       //   // Listening to do something
//       //   listener: (context, state) {
//       //     if (state is ValidateUserLoadFinishedState) {
//       //       switch (validateUserBloc.validateNormalUserObj.validateResult) {
//       //         case ValidateUserResult.UserNotFound:
//       //           _showNotValidateUserView();
//       //           break;
//       //         case ValidateUserResult.FoundUser:
//       //           _gotoOtpInputPage();
//       //           break;
//       //         default:
//       //           break;
//       //       }
//       //     }
//       //   },
//       // ),
//       // _guestLoginButton(),
//     ],
//   ),
// );
