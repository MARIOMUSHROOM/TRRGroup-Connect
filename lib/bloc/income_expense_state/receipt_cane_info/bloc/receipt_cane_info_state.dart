part of 'receipt_cane_info_bloc.dart';

@immutable
abstract class ReceiptCaneInfoState {}

class ReceiptCaneInfoInitial extends ReceiptCaneInfoState {}

class ReceiptCaneInfoLoading extends ReceiptCaneInfoState {}

class ReceiptCaneInfoLoaded extends ReceiptCaneInfoState {
  @override
  String toString() => "ReceiptCaneInfoLoaded{}";
}

class ReceiptCaneInfoNoData extends ReceiptCaneInfoState {}

class ReceiptCaneInfoError extends ReceiptCaneInfoState {
  ReceiptCaneInfoError(this.message);
  String message;
  @override
  String toString() => "ReceiptCaneInfoError{message: $message}";
}
