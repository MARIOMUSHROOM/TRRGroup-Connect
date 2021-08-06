import 'dart:convert';
import '../../base_class/models/ai_base_model.dart';

const kSuccessText = 'success';
const kErrorText = 'error';
const kCodeInvalidMessage = 'Code is invalid';
const kCodeAlreadyUsed = 'Code used already';

enum ValidateOtpStatus {
  Correct,
  InvalidCode,
  OtpAlreadyUsed,
}

class ValidateOtpResult extends AiBasicItem {
  ValidateOtpStatus status;
  String message;
  // int errorCode;

  ValidateOtpResult({
    this.status,
    this.message,
  });

  void copyFromVerifySucces(OtpVerifySuccess aSuccessObj) {
    if (aSuccessObj != null) {
      if (aSuccessObj.data.status.contains(kSuccessText)) {
        this.status = ValidateOtpStatus.Correct;
        this.message = aSuccessObj.data.message;
      }
    }
  }

  void copyFromVerifyError(OtpVerifyError aErrorObj) {
    if (aErrorObj != null) {
      // String msg = aErrorObj.error.message;
      if (aErrorObj.error.message.contains(kCodeInvalidMessage)) {
        this.status = ValidateOtpStatus.InvalidCode;
        this.message = kCodeInvalidMessage;
      } else if (aErrorObj.error.message.contains(kCodeAlreadyUsed)) {
        this.status = ValidateOtpStatus.OtpAlreadyUsed;
        this.message = kCodeAlreadyUsed;
      } else {
        this.status = ValidateOtpStatus.InvalidCode;
      }
    }
  }

  static final ValidateOtpResult instance = ValidateOtpResult();
}

//===================================================================================================

// To parse this JSON data, do
//
//     final otpVerifySuccess = otpVerifySuccessFromJson(jsonString);
OtpVerifySuccess otpVerifySuccessFromJson(String str) => OtpVerifySuccess.fromJson(json.decode(str));
String otpVerifySuccessToJson(OtpVerifySuccess data) => json.encode(data.toJson());

class OtpVerifySuccess {
  OtpVerifySuccess({
    this.data,
  });

  Data data;

  factory OtpVerifySuccess.fromJson(Map<String, dynamic> json) => OtpVerifySuccess(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}

//======================================================================================

// To parse this JSON data, do
//
//     final otpVerifyError = otpVerifyErrorFromJson(jsonString);
OtpVerifyError otpVerifyErrorFromJson(String str) => OtpVerifyError.fromJson(json.decode(str));
String otpVerifyErrorToJson(OtpVerifyError data) => json.encode(data.toJson());

class OtpVerifyError {
  OtpVerifyError({
    this.error,
  });

  OtpVerifyErrorError error;

  factory OtpVerifyError.fromJson(Map<String, dynamic> json) => OtpVerifyError(
        error: json["error"] == null ? null : OtpVerifyErrorError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error.toJson(),
      };
}

class OtpVerifyErrorError {
  OtpVerifyErrorError({
    this.errors,
    this.code,
    this.message,
  });

  List<ErrorElement> errors;
  int code;
  String message;

  factory OtpVerifyErrorError.fromJson(Map<String, dynamic> json) => OtpVerifyErrorError(
        errors: json["errors"] == null ? null : List<ErrorElement>.from(json["errors"].map((x) => ErrorElement.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x.toJson())),
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}

class ErrorElement {
  ErrorElement({
    this.detail,
    this.message,
  });

  List<dynamic> detail;
  String message;

  factory ErrorElement.fromJson(Map<String, dynamic> json) => ErrorElement(
        detail: json["detail"] == null ? null : List<dynamic>.from(json["detail"].map((x) => x)),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail == null ? null : List<dynamic>.from(detail.map((x) => x)),
        "message": message == null ? null : message,
      };
}

// To parse this JSON data, do
//
//     final validateOtpData = validateOtpDataFromJson(jsonString);

ValidateOtpData validateOtpDataFromJson(String str) => ValidateOtpData.fromJson(json.decode(str));
String validateOtpDataToJson(ValidateOtpData data) => json.encode(data.toJson());

class ValidateOtpData extends AiBasicItem {
  ValidateOtpData({
    this.key,
    this.secret,
    this.token,
    this.pin,
  });

  String key = '';
  String secret = '';
  String token = '';
  String pin = '';
  String validateUrl = '';

  void clear() {
    key = '';
    secret = '';
    token = '';
    pin = '';
    validateUrl = '';
  }

  bool get isValidPreparing => (key.isNotEmpty && secret.isNotEmpty && token.isNotEmpty && validateUrl.isNotEmpty);

  bool get isDataReady => (this.isOtpReady && this.isValidPreparing);

  bool get isOtpReady => (pin.isNotEmpty && pin.length == 6);

  void prepareData(String aKey, String aSecret, String aToken, String aValidateUrl, String aPin) {
    key = aKey;
    secret = aSecret;
    token = aToken;
    validateUrl = aValidateUrl;
    pin = aPin;
  }

  factory ValidateOtpData.fromJson(Map<String, dynamic> json) => ValidateOtpData(
        key: json["key"] == null ? '' : json["key"],
        secret: json["secret"] == null ? '' : json["secret"],
        token: json["token"] == null ? '' : json["token"],
        pin: json["pin"] == null ? '' : json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "secret": secret == null ? null : secret,
        "token": token == null ? null : token,
        "pin": pin == null ? null : pin,
      };

  static final ValidateOtpData instance = ValidateOtpData();
}
