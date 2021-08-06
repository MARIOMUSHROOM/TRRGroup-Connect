part of 'report_detail_bloc.dart';

@immutable
abstract class ReportDetailEvent {}

class LoadReportDetailData extends ReportDetailEvent {
  LoadReportDetailData(this.idSuccess);
  int idSuccess;
  @override
  String toString() => "LoadReportDetailData{}";
}

class UpdateOffsetReportDetailData extends ReportDetailEvent {
  UpdateOffsetReportDetailData();
  @override
  String toString() => "UpdateOffsetReportDetailData{}";
}
