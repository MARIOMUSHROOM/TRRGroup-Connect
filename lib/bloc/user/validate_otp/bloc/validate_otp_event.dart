part of 'validate_otp_bloc.dart';

@immutable
abstract class ValidateOtpEvent {}

class SendOtpToValidateEvent extends ValidateOtpEvent {
  final ValidateOtpData otpData;

  SendOtpToValidateEvent(this.otpData);
}
