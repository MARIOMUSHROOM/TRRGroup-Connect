part of 'otp_bloc.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpRequesting extends OtpState {}

// class OtpRequestSuccess extends OtpState {}

// class OtpRequestFail extends OtpState {} // Otp bad request response

class OtpRequestComplete extends OtpState {}

class OtpSystemNotResponse extends OtpState {}

class OtpSystemError extends OtpState {
  final String errorMessage;

  OtpSystemError(this.errorMessage);

  @override
  String toString() => 'Otp Error with message : $errorMessage';
}
