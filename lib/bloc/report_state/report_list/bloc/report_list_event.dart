part of 'report_list_bloc.dart';

@immutable
abstract class ReportListEvent {}

class LoadReportListInitial extends ReportListEvent {
  @override
  String toString() => "LoadReportListInitial{}";
}

class UpdateYearReportList extends ReportListEvent {
  UpdateYearReportList(this.startYear, this.endYear);
  String startYear;
  String endYear;
  @override
  String toString() => "UpdateYearReportList{}";
}
