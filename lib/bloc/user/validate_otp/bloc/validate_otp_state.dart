part of 'validate_otp_bloc.dart';

@immutable
abstract class ValidateOtpState {}

class ValidateOtpInitial extends ValidateOtpState {}

class ValidatingOtpState extends ValidateOtpState {}

class ValidateOtpFinishState extends ValidateOtpState {}

class ValidateOtpNotResponseState extends ValidateOtpState {}

class ValidateOtpErrorState extends ValidateOtpState {
  final String errorMessage;

  ValidateOtpErrorState(this.errorMessage);

  @override
  String toString() {
    return 'Validate OTP Error with message : $errorMessage';
  }
}
