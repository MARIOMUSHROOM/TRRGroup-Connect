part of 'income_expense_info_bloc.dart';

@immutable
abstract class IncomeExpenseInfoState {}

class IncomeExpenseInfoInitial extends IncomeExpenseInfoState {}

class IncomeExpenseLoading extends IncomeExpenseInfoState {}

class IncomeExpenseLoaded extends IncomeExpenseInfoState {
  @override
  String toString() => "IncomeExpenseLoaded{}";
}

class IncomeExpenseNoData extends IncomeExpenseInfoState {}

class IncomeExpenseError extends IncomeExpenseInfoState {
  IncomeExpenseError(this.message);
  String message;
  @override
  String toString() => "IncomeExpenseError{message: $message}";
}
