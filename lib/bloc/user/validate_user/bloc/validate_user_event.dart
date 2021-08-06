part of 'validate_user_bloc.dart';

@immutable
abstract class ValidateUserEvent {}

// event to verify normal TRR user exists
class ValidateUserCheckExistingUserEvent extends ValidateUserEvent {
  final String idCard;
  final String phoneNumber;

  ValidateUserCheckExistingUserEvent(this.idCard, this.phoneNumber);
}

// event to look up into user_special table
class ValidateUserCheckExistingSpecialUserEvent extends ValidateUserEvent {
  final String idCard;
  final String phoneNumber;

  ValidateUserCheckExistingSpecialUserEvent(this.idCard, this.phoneNumber);
}
