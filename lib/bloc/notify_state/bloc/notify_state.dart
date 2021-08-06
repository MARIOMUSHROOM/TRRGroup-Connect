part of 'notify_bloc.dart';

@immutable
abstract class NotifyState {}

class NotifyInitial extends NotifyState {}

class NotifyLoading extends NotifyState {}

class NotifyLoaded extends NotifyState {
  @override
  String toString() => "NotifyLoaded{}";
}

class NotifyLazyLoading extends NotifyState {}

class NotifyLazyLoaded extends NotifyState {}

class NotifyNoData extends NotifyState {}

class NotifyError extends NotifyState {
  NotifyError(this.message);
  String message;
  @override
  String toString() => "NotifyError{message: $message}";
}

class NotifyCount extends NotifyState {}
