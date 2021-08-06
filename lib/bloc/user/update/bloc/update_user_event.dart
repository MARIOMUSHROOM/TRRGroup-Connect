part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserEvent {}

class UpdateUserEnrollNewUserEvent extends UpdateUserEvent {
  final TrrPreferenceData mainPreferenceData;

  UpdateUserEnrollNewUserEvent(this.mainPreferenceData);
}

// class UpdateUserResetStateEvent extends UpdateUserEvent {}
