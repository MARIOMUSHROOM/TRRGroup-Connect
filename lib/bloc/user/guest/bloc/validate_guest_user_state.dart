part of 'validate_guest_user_bloc.dart';

@immutable
abstract class ValidateGuestUserState {}

class ValidateGuestUserInitial extends ValidateGuestUserState {}

class ValidateGuestUserAuthenticating extends ValidateGuestUserState {}

class ValidateGuestUserFinishState extends ValidateGuestUserState {}

class ValidateGuestUserFailState extends ValidateGuestUserState {}

class ValidateGuestUserError extends ValidateGuestUserState {
  final String errorMessage;
  ValidateGuestUserError(this.errorMessage);

  @override
  String toString() => 'Validate Guest User Error with message : $errorMessage';
}
