part of 'income_expense_info_bloc.dart';

@immutable
abstract class IncomeExpenseInfoEvent {}

class LoadIncomeExpenseInitial extends IncomeExpenseInfoEvent {
  @override
  String toString() => "LoadIncomeExpenseInitial{}";
}

class UpdateYearIncomeExpense extends IncomeExpenseInfoEvent {
  UpdateYearIncomeExpense(this.yearSelected);
  String yearSelected;
  @override
  String toString() => "UpdateYearIncomeExpense{}";
}
