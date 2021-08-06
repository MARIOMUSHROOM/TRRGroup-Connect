part of 'validate_guest_user_bloc.dart';

@immutable
abstract class ValidateGuestUserEvent {}

class ValidateGuestUserAuthenticationEvent extends ValidateGuestUserEvent {
  final String userName;
  final String password;

  ValidateGuestUserAuthenticationEvent(this.userName, this.password);
}
