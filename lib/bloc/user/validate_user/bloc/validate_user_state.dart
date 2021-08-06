part of 'validate_user_bloc.dart';

@immutable
abstract class ValidateUserState {}

class ValidateUserInitial extends ValidateUserState {}

class ValidateUserLoadingState extends ValidateUserState {}

class ValidateUserLoadFinishedState extends ValidateUserState {}

class ValidateUserEmptyState extends ValidateUserState {}

class ValidateUserErrorState extends ValidateUserState {
  final String errorMessage;

  ValidateUserErrorState(this.errorMessage);

  @override
  String toString() => 'Validate user error state with message : $errorMessage';
}
