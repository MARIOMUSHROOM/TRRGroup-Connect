part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserState {}

class UpdateUserInitial extends UpdateUserState {}

// updating / update complete / update fail / update error
class UpdatingNewUser extends UpdateUserState {}

class UpdateNewUserComplete extends UpdateUserState {}

class UpdateNewUserFail extends UpdateUserState {}

class UpdateNewUserError extends UpdateUserState {
  final errorMessage;
  UpdateNewUserError(this.errorMessage);

  @override
  String toString() => '${this.runtimeType} : Update new user to database error with message : ${this.errorMessage}';
}
