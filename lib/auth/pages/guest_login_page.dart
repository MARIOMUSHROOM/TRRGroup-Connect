// import 'package:ai_flutter/base_class/pages/ai_base_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../basic/pages/trr_basic_page.dart';
import '../../global_const.dart' as cons;
import '../../global_utils.dart' as util;

import '../../basic/models/trr_object.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/guest/bloc/validate_guest_user_bloc.dart';
import '../../nav_page.dart';
// import '../../bloc/user/person/bloc/retrieve_person_data_bloc.dart';
import '../../user/models/trr_preference_data.dart';

// ignore: must_be_immutable
class GuestLoginPage extends TrrBasicPageStatefulWidget {
  // GuestLoginPage({ Key: key }) : super(key: key);
  GuestLoginPage({Key key, TrrData dataObj}) : super(key: key, dataObj: dataObj);

  @override
  _GuestLoginPageState createState() => _GuestLoginPageState();
}

class _GuestLoginPageState extends TrrBasicPageState<GuestLoginPage> {
  GlobalKey<FormState> _inputFormKey = GlobalKey<FormState>();
  FocusScopeNode _fieldNode = FocusScopeNode();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _alreadyShowButton = false;

  String userStr = '';
  String passwordStr = '';

  final Widget _pageCaption = Padding(
    padding: EdgeInsets.only(top: 40, bottom: 0),
    child: Text('* สำหรับผู้ใช้ที่เป็นพนักงานของบริษัทเท่านั้น', style: TextStyle(color: Colors.white)),
  );

  void _gotoHomePage() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavPage()), (route) => false);
  }

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cons.kSolidBlueColor,
        appBar: AppBar(
          backgroundColor: cons.kSolidBlueColor,
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back, color: cons.kGoldColor, size: 36),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        body: _guestLoginPageUI(),
      ),
    );
  }

  Widget _guestLoginPageUI() {
    ValidateGuestUserBloc guestBloc = BlocProvider.of<ValidateGuestUserBloc>(pageContext);
    // RetrievePersonDataBloc personBloc = BlocProvider.of<RetrievePersonDataBloc>(pageContext);

    return Align(
      child: SingleChildScrollView(
        child: BlocConsumer<ValidateGuestUserBloc, ValidateGuestUserState>(
          listener: (context, state) {
            // if (state is ValidateGuestUserFinishState && guestBloc.guestUserObj.foundGuestUser) _gotoHomePage();
            if (state is ValidateGuestUserFinishState) {
              if (guestBloc.guestUserObj.foundGuestUser && guestBloc.currentGuestPerson != null) {
                widget.dataObj.generateUserObjByPersonData(guestBloc.currentGuestPerson, TrrPreferenceData.instance);
                _gotoHomePage();
              }
            } else if (state is ValidateGuestUserFailState)
              // wrong login data then show snack bar
              ScaffoldMessenger.of(pageContext).showSnackBar(_incorrectUserSnackBar());
          },
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  util.verticalAnimation(_logoImage(), aStartPosition: 50),
                  _inputForm(),
                  if (state is ValidateGuestUserAuthenticating) _validatingProgress() else _loginButton(),
                  // else {
                  //   if (_alreadyShowButton) _loginButton() else util.verticalAnimation(_loginButton(), aStartPosition: -50)
                  // },
                  _pageCaption,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _logoImage() {
    return Container(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage('assets/images/landing/big_logo.png'),
        width: dvWidth * 0.30,
        fit: BoxFit.cover,
        color: cons.kGoldColor,
      ),
    );
  }

  Widget _inputForm() {
    return Container(
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
                util.verticalAnimation(_userNameTextField(), aStartPosition: 20),
                util.verticalAnimation(_passwordTextField(), aStartPosition: -20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return TextFormField(
      autocorrect: false,
      controller: _userController,
      // keyboardType: TextInputType.number,
      keyboardType: TextInputType.text,
      maxLength: 255,
      onEditingComplete: () => _fieldNode.nextFocus(),
      decoration: InputDecoration(
        counter: Offstage(),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: 'ชื่อบัญชีผู้ใช้',
        prefixIcon: Icon(Icons.account_circle_rounded),
        fillColor: cons.kPageBackgroundColor,
        filled: true,
        errorStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (input) {
        return (input.isNotEmpty && !input.contains(' ')) ? null : 'กรุณากรอกชื่อบัญชีผู้ใช้ให้ถูกต้อง';
      },
      onSaved: (inputText) {
        setState(() {
          userStr = _userController.text;
        });
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _passwordController,
      // keyboardType: TextInputType.number,
      keyboardType: TextInputType.text,
      maxLength: 30,
      decoration: InputDecoration(
        counter: Offstage(),
        hintText: 'รหัสผ่าน',
        errorStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(Icons.lock_rounded),
        fillColor: cons.kPageBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.done,
      validator: (input) {
        return (input.isNotEmpty) ? null : 'กรุณากรอกรหัสผ่าน';
      },
      onSaved: (inputText) {
        setState(() {
          passwordStr = _passwordController.text;
        });
      },
    );
  }

  Widget _loginButton() {
    Widget result;

    final resultButton = ElevatedButton(
      onPressed: () {
        if (_inputFormKey.currentState.validate()) {
          userStr = _userController.text;
          passwordStr = _passwordController.text;
          // Pointing to global ValidateGuestUserBloc object and send username and password to verify in event
          (BlocProvider.of<ValidateGuestUserBloc>(pageContext)).add(
            ValidateGuestUserAuthenticationEvent(this.userStr, this.passwordStr),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        primary: cons.kGoldColor,
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 40),
      ),
      child: Text('เข้าสู่ระบบ', style: TextStyle(color: Colors.white)),
    );

    if (_alreadyShowButton)
      result = resultButton;
    else
      result = util.verticalAnimation(resultButton, aStartPosition: -50);

    _alreadyShowButton = true;
    return result;
  }

  Widget _validatingProgress() {
    return Container(
      padding: EdgeInsets.only(top: 14),
      child: SizedBox(
        width: 34,
        height: 34,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 5,
        ),
      ),
    );
  }

  SnackBar _incorrectUserSnackBar() {
    final resultSnackBar = SnackBar(
      content: Container(
          padding: EdgeInsets.all(2),
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 24),
              Text(
                ' ขออภัยข้อมูลล๊อคอินไม่ถูกต้อง!',
                style: TextStyle(color: Colors.white, fontSize: 16, height: 1.0),
              ),
            ],
          )),
      backgroundColor: cons.kGoldColor,
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
      margin: EdgeInsets.all(6),
      duration: Duration(seconds: 5),
    );
    return resultSnackBar;
  }
}
