part of 'user_preference_bloc.dart';

@immutable
abstract class UserPreferenceState {}

class UserPreferenceInitial extends UserPreferenceState {}

// --------------------------------------------------------------
class UserPreferenceLoading extends UserPreferenceState {}

class UserPreferenceLoadFinished extends UserPreferenceState {}

class UserPreferenceNoData extends UserPreferenceState {}

class UserPreferenceError extends UserPreferenceState {
  final String errorMessage;
  UserPreferenceError(this.errorMessage);

  @override
  String toString() => 'User preference error with message : $errorMessage';
}

// ----------------------------------------------------------------------------------
class SavingUserPreference extends UserPreferenceState {}

class SaveUserPreferenceComplete extends UserPreferenceState {}

class SaveUserPreferenceFail extends UserPreferenceState {}

class SaveUserPreferenceError extends UserPreferenceState {
  final String errorMessage;
  SaveUserPreferenceError(this.errorMessage);
  @override
  String toString() {
    return 'Save user preference error with message : $errorMessage';
  }
}

// ----------------------------------------------------------------------------------
class ClearingDevicePreferenceState extends UserPreferenceState {}

class ClearPreferenceSuccesState extends UserPreferenceState {}

class ClearPreferenceFailState extends UserPreferenceState {}
