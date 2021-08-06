part of 'journal_bloc.dart';

@immutable
abstract class JournalEvent {}

class LoadJournalInitial extends JournalEvent {
  @override
  String toString() => "LoadJournalInitial{}";
}

class LoadMoreJournal extends JournalEvent {
  @override
  String toString() => "LoadMoreJournal{}";
}
