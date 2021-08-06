import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../user_cons.dart' as userCons;
import '../../../../provider/user_api.dart';
import '../../../../user/models/otp_model.dart';
import '../../../../user/models/validate_otp_model.dart';

part 'validate_otp_event.dart';
part 'validate_otp_state.dart';

class ValidateOtpBloc extends Bloc<ValidateOtpEvent, ValidateOtpState> {
  ValidateOtpBloc() : super(ValidateOtpInitial());

  ValidateUserAPI _userApi = ValidateUserAPI.instance;
  final ValidateOtpResult validateResult = ValidateOtpResult.instance;

  @override
  Stream<ValidateOtpState> mapEventToState(
    ValidateOtpEvent event,
  ) async* {
    if (event is SendOtpToValidateEvent) {
      yield* _validateOtp(event.otpData);
    }
  }

  Stream<ValidateOtpState> _validateOtp(ValidateOtpData aOtpData) async* {
    // Production Code
    yield ValidatingOtpState();
    try {
      dynamic resObj = await _userApi.validateOTP(aOtpData);
      if (resObj != null) {
        if (resObj is OtpVerifySuccess)
          validateResult.copyFromVerifySucces(resObj);
        else if (resObj is OtpVerifyError) validateResult.copyFromVerifyError(resObj);
        yield ValidateOtpFinishState();
      } else
        yield ValidateOtpNotResponseState();
    } catch (error) {
      ValidateOtpErrorState(error.toString());
    }
  }
}
