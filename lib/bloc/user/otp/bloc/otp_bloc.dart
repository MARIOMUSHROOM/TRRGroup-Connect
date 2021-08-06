import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import '../../../../user/models/otp_model.dart';
import '../../../../provider/user_api.dart';

import '../../user_cons.dart' as userCons;

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial());

  // OtpRequestModel otpRequestObj = OtpRequestModel.instance;
  // DirectRequestOtpResult requestOtpResult;
  ValidateUserAPI _userAPI = ValidateUserAPI.instance;
  RequestOtpResult requestOtpResult;

  // DirectRequestOtpResult get directRequestResult {
  //   if (_directRequestOtpResult == null)
  //     _directRequestOtpResult = DirectRequestOtpResult();
  //   return _directRequestOtpResult;
  // }

  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    if (event is OtpRequestEvent) yield* _doRequestOtp(event.requestByPhoneNumber);
  }

  Stream<OtpState> _doRequestOtp(String aPhoneNumber) async* {
    yield OtpRequesting();
    try {
      // http.Response res = await RequestOtpAPI().requestOTP(aPhoneNumber);

      // if (res != null && res.body.isNotEmpty) {
      //   otpRequestObj = OtpRequestModel.fromJson(res.body as Map<String, dynamic>);
      //   yield OtpBackEndResponse();
      // } else
      //   yield OtpBackEndNotResponse();

      // var res = await ValidateUserAPI().requestOTP(aPhoneNumber);
      // otpRequestObj.copyFrom(res as OtpRequestModel);

      // http.Response result = await _userAPI.directRequestOTP(
      //   userCons.kRequestOtpApiUrl,
      //   userCons.kOtpApiKey,
      //   userCons.kOtpApiSecret,
      //   aPhoneNumber,
      // );

      // if (result != null && result.body.isNotEmpty) {
      //   this.requestOtpResult = result as DirectRequestOtpResult;
      //   if (this.requestOtpResult.data.status.contains('success')) yield OtpRequestSuccess();
      // }

      // this.requestOtpResult = await ValidateUserAPI().directRequestOTP(
      //   userCons.kRequestOtpApiUrl,
      //   userCons.kOtpApiKey,
      //   userCons.kOtpApiSecret,
      //   aPhoneNumber,
      // );

      // testing
      // ------------------------------------------------------------------------
      this.requestOtpResult = await _userAPI.requestOTP(aPhoneNumber);
      if (this.requestOtpResult != null)
        yield OtpRequestComplete();
      else
        yield OtpSystemNotResponse();
      // -------------------------------------------------------------------------

      // production code (works)
      // -------------------------------------------------------------------------
      // http.Response response = await _userAPI.requestOTP(aPhoneNumber);
      // if (response != null && response.body.isNotEmpty) {
      //   this.requestOtpResult = requestOtpResultFromJson(response.body);
      //   yield OtpRequestComplete();
      // } else
      //   yield OtpSystemNotResponse();
      // -------------------------------------------------------------------------

    } catch (error) {
      yield OtpSystemError(error.toString());
    }
  }
}
