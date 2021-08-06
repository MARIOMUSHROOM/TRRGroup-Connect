import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextValidate {
  static requireText() => "ระบุเป็นตัวหนังสือ";
  static requireNumberText() => "ระบุเป็นตัวเลข";
}

class CustomTextFormFieldStyle {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = "", String suffixText}) {
    return InputDecoration(
      // hintText: 'ระบุตัวเลข',
      // labelText: labelTextStr,
      filled: true,
      suffixText: suffixText == null ? null : suffixText,
      hintText: hintTextStr,
      fillColor: Colors.white,
      contentPadding:
          new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
    );
  }

  static Widget inputTitleTextStyle({String labelTextStr = ""}) {
    return Row(
      children: [
        // Container(
        //   height: 15,
        //   width: 5,
        //   color: Colors.black,
        // ),
        // SizedBox(
        //   width: 5,
        // ),
        Text(
          labelTextStr,
          style: TextStyle(
            fontSize: 20,
            color: kGoldColor,
          ),
        ),
      ],
    );
  }

  static Widget inputSubTitleTextStyle({String labelTextStr = ""}) {
    return Row(
      children: [
        SizedBox(
          width: 8,
        ),
        Text(labelTextStr),
      ],
    );
  }
}
