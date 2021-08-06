import 'package:ai_flutter/auth/pages/input_otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import '../../basic/pages/trr_basic_page.dart';
import '../../global_const.dart' as cons;
import '../../global_utils.dart' as util;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/validate_user/bloc/validate_user_bloc.dart';
import '../../bloc/user/otp/bloc/otp_bloc.dart';

import '../../user/models/trr_preference_data.dart';
import '../../user/models/validate_user_model.dart';
import '../../user/models/special_user_json_model.dart';
import '../auth_util.dart' as authUtil;

// ignore: must_be_immutable
class ForgotPasswordPage extends TrrBasicPageStatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends TrrBasicPageState<ForgotPasswordPage> {
  /* Page and elements controller */
  final GlobalKey<FormState> _inputFormKey = GlobalKey<FormState>();
  final FocusScopeNode _fieldNode = FocusScopeNode();
  TextEditingController _idCardFieldController = TextEditingController();
  TextEditingController _phoneFieldController = TextEditingController();

  /* Static Widgets */
  final Widget _pageTitle = Text('ลืมรหัสผ่าน', style: TextStyle(fontSize: 34), textAlign: TextAlign.center);
  final Widget _pageCaption = Text('กรุณากรอกเลขที่บัตรประชาชน 13 หลัก\nและกรอกหมายเลขโทรศััพท์ เพื่อทำการเปลี่ยนรหัสผ่านใหม่',
      style: TextStyle(fontSize: 24, color: Colors.grey), textAlign: TextAlign.center);

  /* Page properties */
  String idCardText = '';
  String phoneNumberText = '';

  final TrrPreferenceData _prefDataObj = TrrPreferenceData.instance;

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back, color: cons.kSolidBlueColor),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: Align(child: _forgotPasswordPageUI()),
      ),
    );
  }

  Widget _forgotPasswordPageUI() {
    // get instance of ValidateUserBloc object
    ValidateUserBloc validateUserBloc = BlocProvider.of<ValidateUserBloc>(pageContext);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _pageTitle, // Page Ttitle Widget
            _pageCaption, // Page Caption Widget
            _inputForm(), // Input Form Widget
            BlocConsumer<ValidateUserBloc, ValidateUserState>(
              listener: (context, state) {
                if (state is ValidateUserLoadFinishedState) {
                  switch (validateUserBloc.runningFlag) {
                    // 1st round validate TRR user
                    case ValidateUserBlocRunningFlag.AlreadyCheckedNormalUser:
                      if (validateUserBloc.isFoundNormalUser) {
                        // Update TRRPreferenceData with quotaID and factoryID
                        _updatePrefByNormalUser(validateUserBloc.validateNormalUserObj);
                        // Request OTP and go to OTP page
                        _requestAndGotoOtpPage(this.phoneNumberText);
                      } else // Send event to ValidateUserBloc again to find Special user
                        validateUserBloc.add(ValidateUserCheckExistingSpecialUserEvent(this.idCardText, this.phoneNumberText));
                      break;
                    // 2nd round when finish checking special user
                    case ValidateUserBlocRunningFlag.AlreadyCheckedSpecialUser:
                      if (validateUserBloc.isFoundSpecialUser) {
                        // Update TRRPreferenceData with userID, factoryID and isSpecialUser
                        _updatePrefBySpecialUser(validateUserBloc.validateSpecialUserObj);
                        _requestAndGotoOtpPage(this.phoneNumberText);
                      } else
                        // Show not found any user dialog
                        util.showErrorTextDialog('คุณไม่มีบัญชีในระบบ\nกรุณาติดต่อเจ้าหน้าที่\n02-345-6789',
                            referContext: pageContext, deviceHeight: dvHeight, deviceWidth: dvWidth);
                      break;
                    default:
                      break;
                  }
                }
              },
              builder: (context, state) {
                Widget viewWidget;
                if (state is ValidateUserLoadingState)
                  viewWidget = _userValidatingProgress();
                else
                  viewWidget = _confirmButton();
                return viewWidget;
              },
            ),
          ],
        ),
      ),
    );
  }

  /* List of Method */
  /* ================================================================================================= */
  void _updatePrefByNormalUser(TrrValidateUser aNormalUser) {
    _prefDataObj.userID = aNormalUser.quotaId;
    _prefDataObj.factoryID = aNormalUser.factoryId;
    _prefDataObj.inputIDCardNumber = this.idCardText;
  }

  void _updatePrefBySpecialUser(SpecialUserJsonModel aSpecialUser) {
    _prefDataObj.userID = aSpecialUser.idUser;
    _prefDataObj.factoryID = aSpecialUser.idFactory;
    _prefDataObj.inputIDCardNumber = aSpecialUser.idCardNumber;
    _prefDataObj.userSpecialID = aSpecialUser.idUserSpecial;
    _prefDataObj.isSpecialUser = true;
  }

  void _requestAndGotoOtpPage(String aPhoneNumber) {
    // Reference to global OTP Bloc
    OtpBloc requestOtpBloc = BlocProvider.of<OtpBloc>(pageContext);
    // Request for OTP by bloc
    requestOtpBloc.add(OtpRequestEvent(aPhoneNumber));
    // Navigate to OTP Page
    Navigator.of(pageContext).push(
      MaterialPageRoute(builder: (context) => InputOtpPage(phoneNumber: aPhoneNumber)),
    );
  }

  /* List of Widget */
  /* ================================================================================================= */
  Widget _inputForm() {
    return Container(
      // height: dvHeight * 0.40,
      width: dvWidth * 0.60,
      margin: EdgeInsets.symmetric(vertical: 40),
      child: Theme(
        data: Theme.of(pageContext).copyWith(
          primaryColor: cons.kGoldColor,
        ),
        child: Form(
          key: _inputFormKey,
          child: FocusScope(
            node: _fieldNode,
            child: Column(
              children: [
                _idCardTextField(),
                _phoneNumberTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _idCardTextField() {
    return TextFormField(
      autocorrect: false,
      controller: _idCardFieldController,
      keyboardType: TextInputType.number,
      maxLength: 13,
      onEditingComplete: () => _fieldNode.nextFocus(),
      decoration: InputDecoration(
        counter: Offstage(),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: 'เลขที่บัตรประชาชน',
        prefixIcon: Icon(Icons.credit_card_outlined),
        fillColor: cons.kPageBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (input) {
        return (input.isNotEmpty && input.length == 13) ? null : 'เลขที่บัตรประชาชนไม่ถูกต้อง';
      },
      onSaved: (inputText) {
        setState(() {
          idCardText = _idCardFieldController.text;
        });
      },
    );
  }

  Widget _phoneNumberTextField() {
    return TextFormField(
      autocorrect: false,
      controller: _phoneFieldController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        counter: Offstage(),
        hintText: 'หมายเลขโทรศัพท์',
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(Icons.phone_iphone_outlined),
        fillColor: cons.kPageBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.done,
      validator: (input) {
        return (input.isNotEmpty && input.length == 10) ? null : 'เบอร์โทรศัพท์ไม่ถูกต้อง';
      },
      onSaved: (inputText) {
        setState(() {
          phoneNumberText = _phoneFieldController.text;
        });
      },
    );
  }

  Widget _confirmButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: cons.kBlueColor,
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 6),
      ),
      onPressed: () {
        if (_inputFormKey.currentState.validate()) {
          idCardText = _idCardFieldController.text;
          phoneNumberText = _phoneFieldController.text;
          // Validate user to TRR API
          ValidateUserBloc validateUserBloc = BlocProvider.of<ValidateUserBloc>(pageContext);
          validateUserBloc.add(ValidateUserCheckExistingUserEvent(this.idCardText, this.phoneNumberText));
        }
      },
      child: Text('ตกลง', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _userValidatingProgress() {
    return Container(
      padding: EdgeInsets.only(top: 14),
      child: SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(cons.kSolidBlueColor),
          strokeWidth: 5,
        ),
      ),
    );
  }
}
