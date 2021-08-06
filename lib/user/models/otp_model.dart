import 'dart:convert';
// import '../../base_class/models/ai_base_model.dart';

enum RequestOtpStatus {
  Unknown, // = 0 get response from backend but unknown error
  Success, // = 1
  Fail, // = 2
}

RequestOtpResult requestOtpResultFromJson(String str) => RequestOtpResult.fromJson(json.decode(str));
String requestOtpResultToJson(RequestOtpResult data) => json.encode(data.toJson());

class RequestOtpResult {
  RequestOtpResult({
    this.status = 0,
    this.otpApiKey = '',
    this.otpApiSecret = '',
    this.otpToken = '',
    this.otpValidateUrl = '',
    this.errorMessage = '',
  });

  int status;
  String otpApiKey;
  String otpApiSecret;
  String otpToken;
  String errorMessage;
  String otpValidateUrl;

  RequestOtpStatus get resultStatus => RequestOtpStatus.values[this.status];

  factory RequestOtpResult.fromJson(Map<String, dynamic> json) => RequestOtpResult(
        status: json["status"] == null ? 0 : json["status"],
        otpApiKey: json["otp_api_key"] == null ? '' : json["otp_api_key"],
        otpApiSecret: json["otp_api_secret"] == null ? '' : json["otp_api_secret"],
        otpToken: json["otp_token"] == null ? '' : json["otp_token"],
        otpValidateUrl: json["otp_validate_url"] == null ? '' : json["otp_validate_url"],
        errorMessage: json["error_message"] == null ? '' : json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "otp_api_key": otpApiKey == null ? null : otpApiKey,
        "otp_api_secret": otpApiSecret == null ? null : otpApiSecret,
        "otp_token": otpToken == null ? null : otpToken,
        "error_message": errorMessage == null ? null : errorMessage,
        "otp_validate_url": otpValidateUrl == null ? null : otpValidateUrl,
      };
}

//-----------------------------------------------------------------------------------------------------------------------------
