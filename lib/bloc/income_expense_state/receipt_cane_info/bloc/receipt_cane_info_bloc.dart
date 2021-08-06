import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/income_expense/model/receipt_cane_model.dart';
import 'package:ai_flutter/provider/expense_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'receipt_cane_info_event.dart';
part 'receipt_cane_info_state.dart';

class ReceiptCaneInfoBloc
    extends Bloc<ReceiptCaneInfoEvent, ReceiptCaneInfoState> {
  ReceiptCaneInfoBloc() : super(ReceiptCaneInfoInitial());

  ReceiptCaneModel receiptCaneModel;
  DateTime selectedDate;
  int plotSelected;
  @override
  Stream<ReceiptCaneInfoState> mapEventToState(
    ReceiptCaneInfoEvent event,
  ) async* {
    if (event is LoadReceiptCaneInitial) {
      selectedDate = DateTime.now();
      plotSelected = 1;
      yield* _connectAPI();
    } else if (event is UpdateDateReceiptCane) {
      selectedDate = event.date;
      yield* _connectAPI();
    } else if (event is UpdatePlotReceiptCane) {
      plotSelected = event.plot;
      yield* _connectAPI();
    }
  }

  Stream<ReceiptCaneInfoState> _connectAPI() async* {
    yield ReceiptCaneInfoLoading();
    try {
      print("in");
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      final String formatted = formatter.format(selectedDate);
      Response rs =
          await ExpenseAPI().getReceiptCaneData(formatted, plotSelected);
      if (rs.statusCode == 200) {
        var jsonRes = json.decode(rs.body);
        print(jsonRes);
        if (jsonRes['result'] == 1) {
          receiptCaneModel = ReceiptCaneModel.fromJson(jsonRes);
          print(receiptCaneModel.installmentList[0]);
          yield ReceiptCaneInfoLoaded();
        } else {
          yield ReceiptCaneInfoNoData();
        }
      } else {
        print("error :");
        print(rs.body);
        yield ReceiptCaneInfoError(rs.body);
      }
    } catch (e) {
      print("error :");
      print(e);
      yield ReceiptCaneInfoError(e.toString());
    }
  }
}
