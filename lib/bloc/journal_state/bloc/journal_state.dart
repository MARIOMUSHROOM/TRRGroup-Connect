part of 'journal_bloc.dart';

@immutable
abstract class JournalState {}

class JournalInitial extends JournalState {}

class JournalLoading extends JournalState {}

class JournalLoaded extends JournalState {
  @override
  String toString() => "JournalLoaded{}";
}

class JournalLazyLoading extends JournalState {}

class JournalLazyLoaded extends JournalState {}

class JournalNoData extends JournalState {}

class JournalError extends JournalState {
  JournalError(this.message);
  String message;
  @override
  String toString() => "JournalError{message: $message}";
}
