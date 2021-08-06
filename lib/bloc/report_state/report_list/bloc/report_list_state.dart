part of 'report_list_bloc.dart';

@immutable
abstract class ReportListState {}

class ReportListInitial extends ReportListState {}

class ReportListLoading extends ReportListState {}

class ReportListLoaded extends ReportListState {
  @override
  String toString() => "ReportListLoaded{}";
}

class ReportListNoData extends ReportListState {}

class ReportListError extends ReportListState {
  ReportListError(this.message);
  String message;
  @override
  String toString() => "ReportListError{message: $message}";
}
