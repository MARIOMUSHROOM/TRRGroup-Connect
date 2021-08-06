part of 'user_preference_bloc.dart';

@immutable
abstract class UserPreferenceEvent {}

class UserPreferenceRequestDevicePreferenceEvent extends UserPreferenceEvent {
  final TrrPreferenceData preferenceData;

  UserPreferenceRequestDevicePreferenceEvent(this.preferenceData);
}

class UserPreferenceSaveToDevicePreferenceEvent extends UserPreferenceEvent {
  final TrrPreferenceData updatePreferenceData;

  UserPreferenceSaveToDevicePreferenceEvent(this.updatePreferenceData);
}

// Debugging class
class UserPreferenceClearDevicePreferenceEvent extends UserPreferenceEvent {}
