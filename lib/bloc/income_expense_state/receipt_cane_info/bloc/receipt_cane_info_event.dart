part of 'receipt_cane_info_bloc.dart';

@immutable
abstract class ReceiptCaneInfoEvent {}

class LoadReceiptCaneInitial extends ReceiptCaneInfoEvent {}

class UpdateDateReceiptCane extends ReceiptCaneInfoEvent {
  UpdateDateReceiptCane(this.date);
  DateTime date;
  @override
  String toString() => "UpdateDateReceiptCane{}";
}

class UpdatePlotReceiptCane extends ReceiptCaneInfoEvent {
  UpdatePlotReceiptCane(this.plot);
  int plot;
  @override
  String toString() => "UpdatePlotReceiptCane{}";
}
