part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

class OtpRequestEvent extends OtpEvent {
  final String requestByPhoneNumber;

  OtpRequestEvent(this.requestByPhoneNumber);
}
