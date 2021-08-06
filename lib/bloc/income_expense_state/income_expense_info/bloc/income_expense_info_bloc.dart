import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/income_expense/model/expense_income_info_model.dart';
import 'package:ai_flutter/home/income_expense/model/expense_info_model.dart';
import 'package:ai_flutter/provider/expense_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'income_expense_info_event.dart';
part 'income_expense_info_state.dart';

class IncomeExpenseInfoBloc
    extends Bloc<IncomeExpenseInfoEvent, IncomeExpenseInfoState> {
  IncomeExpenseInfoBloc() : super(IncomeExpenseInfoInitial());
  ExpenseIncomeInfo expenseIncomeInfo;
  String selectedYearFormAPI;
  @override
  Stream<IncomeExpenseInfoState> mapEventToState(
    IncomeExpenseInfoEvent event,
  ) async* {
    if (event is LoadIncomeExpenseInitial) {
      int yearBuddhistNow = (DateTime.now().year + 543);
      selectedYearFormAPI = "${yearBuddhistNow - 1}/$yearBuddhistNow";
      yield* _connectAPI();
    } else if (event is UpdateYearIncomeExpense) {
      print(event.yearSelected);
      selectedYearFormAPI = event.yearSelected;
      yield* _connectAPI();
    }
  }

  Stream<IncomeExpenseInfoState> _connectAPI() async* {
    yield IncomeExpenseLoading();
    try {
      print("in");
      var rs = await ExpenseAPI().getExpenseData(selectedYearFormAPI);
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      if (jsonRes.isNotEmpty) {
        print("jsonRes");
        print(jsonRes);
        expenseIncomeInfo = ExpenseIncomeInfo.fromJson(jsonRes[0]);
        yield IncomeExpenseLoaded();
      } else {
        yield IncomeExpenseNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield IncomeExpenseError(e.toString());
    }
  }
}
