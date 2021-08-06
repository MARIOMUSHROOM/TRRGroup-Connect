import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/report/models/report_list_model.dart';
import 'package:ai_flutter/provider/report_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'report_list_event.dart';
part 'report_list_state.dart';

class ReportListBloc extends Bloc<ReportListEvent, ReportListState> {
  ReportListBloc() : super(ReportListInitial());
  ReportListModel reportList;
  String startYear;
  String endYear;
  @override
  Stream<ReportListState> mapEventToState(
    ReportListEvent event,
  ) async* {
    if (event is LoadReportListInitial) {
      int thaiFormYear = DateTime.now().year + 543;
      startYear = (thaiFormYear - 1).toString();
      endYear = thaiFormYear.toString();
      yield* _connectAPI();
    } else if (event is UpdateYearReportList) {
      startYear = event.startYear;
      endYear = event.endYear;
      yield* _connectAPI();
    }
  }

  Stream<ReportListState> _connectAPI() async* {
    yield ReportListLoading();
    try {
      print("in");
      var rs = await ReportAPI().getReportList(startYear, endYear);
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      if (jsonRes.isNotEmpty) {
        print("jsonRes");
        print(jsonRes);
        reportList = ReportListModel.fromJson(jsonRes[0]);
        // startYear = reportList.yearStart;
        // endYear = reportList.yearEnd;
        yield ReportListLoaded();
      } else {
        yield ReportListNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield ReportListError(e.toString());
    }
  }
}
