part of 'report_detail_bloc.dart';

@immutable
abstract class ReportDetailState {}

class ReportDetailInitial extends ReportDetailState {}

class ReportDetailLoading extends ReportDetailState {}

class ReportDetailLoaded extends ReportDetailState {
  @override
  String toString() => "ReportDetailLoaded{}";
}

class ReportDetailLazyLoading extends ReportDetailState {}

class ReportDetailLazyLoaded extends ReportDetailState {}

class ReportDetailNoData extends ReportDetailState {}

class ReportDetailError extends ReportDetailState {
  ReportDetailError(this.message);
  String message;
  @override
  String toString() => "ReportDetailError{message: $message}";
}
