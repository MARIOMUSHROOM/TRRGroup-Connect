// import 'dart:io';
import './api_provider.dart';
import 'package:http/http.dart' as http;
import './provider_utils.dart' as provUtil;
import '../global_utils.dart' as util;
import 'dart:convert';

import '../user/models/validate_user_model.dart';
import '../user/models/otp_model.dart';
import '../user/models/validate_otp_model.dart';
import '../user/models/special_user_json_model.dart';
import '../user/models/trr_preference_data.dart';
import '../user/models/guest_user_json_model.dart';
import '../user/models/person_data_model.dart';
import '../profile/models/profile_json_model.dart';
import '../user/models/special_user_json_model.dart';

// Temporary constants
const kOtpApiKey = '1703955874393991';
const kOtpApiSecret = 'c1c7627ddf0bbe5d19796b6275b8ba96';
const kRequestOtpApiUrl = 'https://otp.thaibulksms.com/v1/otp/request';
const kValidateOtpApiUrl = 'https://otp.thaibulksms.com/v1/otp/verify';

// Trr URL
const kTrrGetProfileUrl = 'https://json.trrsugar.com:28089/api/profile';

// Connect to TRR API
class ValidateUserAPI extends ApiProvider {
  static final ValidateUserAPI instance = ValidateUserAPI();

  // Find normal TRR user
  Future<dynamic> findTrrUser(String aIDCard, String aPhoneNumber) async {
    String _getTrrUserUrl = 'https://json.trrsugar.com:28089/api/register'; // TRR API
    /* Testing Data
    "id_card_number":"3190200013363",
    "phone_number":"0818524158"  
    */

    // Production code (works)
    //------------------------------------------------------------------------
    var _sendData = {
      "id_card_number": aIDCard,
      'phone_number': aPhoneNumber,
    };

    return provUtil.postDataToAPI(_getTrrUserUrl, this.headers, _sendData);
    //------------------------------------------------------------------------

    /*
      function should return http.Response in Json like
      {
        "result":  1,
        "quota_id": 1,
        "factory_id": 2
      }
    */
    // Testing code
    //------------------------------------------------------------------------
    // return Future.delayed(Duration(seconds: 3)).then(
    //   (_) => TrrValidateUser(
    //     result: 0,
    //     quotaId: 0,
    //     factoryId: 0,
    //   ),
    // );
    //------------------------------------------------------------------------

    // return Future.delayed(Duration(seconds: 3)).then(
    //   (_) => TrrValidateUser(
    //     result: 1,
    //     quotaId: 74,
    //     factoryId: 1,
    //   ),
    // );
  }

  // Find special user in table user_special
  Future<dynamic> findSpecialUser(String aIDCard, String aPhoneNumber) async {
    /* Testing data in db
    idCardNumber = 3689897676663
    phoneNumber = 0828992889
    
     */
    // Production code (works)
    //------------------------------------------------------------------------
    String _getSpecialUserUrl = '$endPoint/get_user_special/$aIDCard/$aPhoneNumber';
    return provUtil.getDataFromAPI(_getSpecialUserUrl, this.headers);
    //------------------------------------------------------------------------

    // Testing code
    //------------------------------------------------------------------------
    // return Future.delayed(Duration(seconds: 3)).then(
    //   (_) => SpecialUserJsonModel(
    //     idUserSpecial: 0,
    //     idUser: 0,
    //     idFactory: 0,
    //     idCardNumber: '',
    //     phoneNumber: '',
    //   ),
    // );
    //------------------------------------------------------------------------

    /* 
      function should return http.Response in Json
      {
        "id_user_special": 1,
        "id_user": 10,
        "id_factory": 10,
        "id_card_number": "123456789012",
        "phone_number": "0899999999"
      }

      https://www.trrgroup.advancedis.co.th/api/get_user_special/1100701914754/0909108540
      https://www.trrgroup.advancedis.co.th/api/get_special_user/3190200013363/0818524150
     */
    // Testing
    // return Future.delayed(Duration(seconds: 3)).then(
    //   (_) => SpecialUserDataJsonModel(
    //     idUserSpecial: 1,
    //     idUser: 10,
    //     idFactory: 10,
    //     idCardNumber: '123456789012',
    //     phoneNumber: '0899999999',
    //   ),
    // );
  }

  // Send request OTP to Beckend
  Future<dynamic> requestOTP(String aPhoneNumber) async {
    // Production code (works)
    //--------------------------------------------------------------------------------------
    // String _requestOtpUrl = '$endPoint/request_otp';
    // var _postBody = {"phone": aPhoneNumber};
    // return provUtil.postDataToAPI(_requestOtpUrl, this.headers, _postBody);
    //--------------------------------------------------------------------------------------

    /* this will return Json response from Backend 
    format when Backend sending to ThaiBulkSMS will be
    {
      "key": "1703955874393991",
      "secret": "c1c7627ddf0bbe5d19796b6275b8ba96",
      "msisdn": "0828992889"
    }

    return format will be
    {
      "status": 1,
      "otp_api_key": "1703955874393991",
      "otp_api_secret": "c1c7627ddf0bbe5d19796b6275b8ba96",
      "otp_token": "otp-token-xxxxxxxxxxxxxxxxxxx",
      "otp_validate_url": "https://otp.thaibulksms.com/v1/otp/verify",
      "error_message": "error message if exist",
    }
    */

    // Testing code
    //--------------------------------------------------------------------------------------
    return Future.delayed(Duration(seconds: 3)).then(
      (requestOtpResult) => RequestOtpResult(
        status: 1,
        otpApiKey: kOtpApiKey,
        otpApiSecret: kOtpApiSecret,
        otpToken: 'dummy-otp-token',
        otpValidateUrl: kValidateOtpApiUrl,
      ),
    );
    //--------------------------------------------------------------------------------------
  }

  Future<dynamic> validateOTP(ValidateOtpData aOtpDataObj) async {
    // Production Code (works)
    //--------------------------------------------------------------------------------------
    // http.Response verifyResponse = await provUtil.postDataToAPI(aOtpDataObj.validateUrl, this.headers, aOtpDataObj.toJson());
    // if (verifyResponse != null && verifyResponse.body.isNotEmpty) {
    //   Map<String, dynamic> res = json.decode(verifyResponse.body) as Map<String, dynamic>;
    //   if (res.containsKey('data'))
    //     return otpVerifySuccessFromJson(verifyResponse.body);
    //   else if (res.containsKey('error')) return otpVerifyErrorFromJson(verifyResponse.body);
    // }
    //--------------------------------------------------------------------------------------

    // Testing Code
    //--------------------------------------------------------------------------------------
    var result = Future.delayed(Duration(seconds: 4)).then((_) => OtpVerifySuccess(data: Data(status: kSuccessText)));
    // var result = Future.delayed(Duration(seconds: 4)).then((_) => OtpVerifyError(error: OtpVerifyErrorError(message: kCodeInvalidMessage)));
    return result;
    //--------------------------------------------------------------------------------------
  }
}

// ============================================================================================================================================
class UpdateUserDataAPI extends ApiProvider {
  static final UpdateUserDataAPI instance = UpdateUserDataAPI();

  Future<dynamic> enrollUser(TrrPreferenceData aMainPreferenceData) async {
    // Update user data to database
    if (aMainPreferenceData != null) {
      // Production code (works)
      //---------------------------------------------------------------------------------------------------
      // copy data from main preference to another object
      var instancePref = TrrPreferenceData()..copyFrom(aMainPreferenceData);
      String _enrollUrl = '$endPoint/save_user_enroll';
      return provUtil.postDataToAPI(_enrollUrl, this.headers, instancePref.toJsonDataForEnroll());
      //---------------------------------------------------------------------------------------------------

      // Testing code
      //---------------------------------------------------------------------------------------------------
      // return Future.delayed(Duration(seconds: 3)).then((value) => EnrollUserResultModel(idUserEnroll: 2));
      //---------------------------------------------------------------------------------------------------
    }
  }
}

// ============================================================================================================================================
class GuestUserAPI extends ApiProvider {
  static final GuestUserAPI instance = GuestUserAPI();

  Future<dynamic> verifyGuestUser(String aUserName, String aPassword) async {
    // Production Code (works)
    //--------------------------------------------------------------------------------------
    String _verifyGuestUrl = '$endPoint/verify_user_guest/$aUserName/$aPassword';
    return await provUtil.getDataFromAPI(_verifyGuestUrl, headers);
    //--------------------------------------------------------------------------------------

    // Testing Code
    //--------------------------------------------------------------------------------------
    // return Future.delayed(Duration(seconds: 3)).then((result) => GuestUserJsonModel(
    //       idUserGuest: 99,
    //       displayName: 'หนุมาน ชาญสมร',
    //       userName: 'hanuman',
    //     ));
    //--------------------------------------------------------------------------------------
  }
}

// ============================================================================================================================================
class PreparePersonDataAPI extends ApiProvider {
  static final PreparePersonDataAPI instance = PreparePersonDataAPI();

  // return NormalPersonDataModel
  Future<dynamic> getNormalPerson(int aUserID, int aFactoryID) async {
    // Production code (works)
    // ---------------------------------------------------------------------------------------
    String _profileUrl = kTrrGetProfileUrl;
    var beginYear = util.getShortThaiYearFromYear(DateTime.now().year - 5);
    beginYear = (beginYear * 100) + beginYear + 1;
    var endYear = util.getShortThaiYearFromYear(DateTime.now().year);
    endYear = (endYear * 100) + endYear + 1;

    // Create map of Json
    var sendMapData = {
      "QuotaNO": aUserID,
      "FacID": aFactoryID,
      "Begin_year": beginYear,
      "End_year": endYear,
    };

    http.Response response = await provUtil.postDataToAPI(_profileUrl, this.headers, sendMapData);
    return response;
    // ---------------------------------------------------------------------------------------
  }

  // return boolean and copy data to 2 result objects
  Future<dynamic> getSpecialPersonByID(int aUserSpecialID, SpecialPersonfDataModel aResultSpecialPersonObj) async {
    bool result = false;
    // check if assigned result object
    // Production code (works)
    // ---------------------------------------------------------------------------------------
    if (aResultSpecialPersonObj != null) {
      String _getSpecialUrl = '$endPoint/get_user_special_data/$aUserSpecialID';
      http.Response specialRes = await provUtil.getDataFromAPI(_getSpecialUrl, this.headers);
      if (specialRes != null && specialRes.body.isNotEmpty) {
        SpecialUserJsonModel tempSpecialUser = SpecialUserJsonModel.fromJson(json.decode(specialRes.body));
        if (tempSpecialUser.isSpecialUser) {
          http.Response normalRes = await getNormalPerson(tempSpecialUser.idUser, tempSpecialUser.idFactory);
          if (normalRes != null && normalRes.body.isNotEmpty) {
            ProfileJsonModel tempProfile = ProfileJsonModel.fromJson(json.decode(normalRes.body));
            if (tempProfile.profileFoundResult == ProfileFoundResult.FoundProfile) {
              aResultSpecialPersonObj.profileJsonObj.copyFrom(tempProfile);
              aResultSpecialPersonObj.specialJsonObj.copyFrom(tempSpecialUser);
              result = true;
            }
          }
        }
      }
    }
    return result;
  }
  // ---------------------------------------------------------------------------------------
}
