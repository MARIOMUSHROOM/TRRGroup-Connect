import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/home/journal/model/journal_model.dart';
import 'package:ai_flutter/provider/journal_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc() : super(JournalInitial());
  JournalModel journalList;
  int offset;
  int takeData;
  bool hasMore;
  @override
  Stream<JournalState> mapEventToState(
    JournalEvent event,
  ) async* {
    if (event is LoadJournalInitial) {
      hasMore = true;
      offset = 0;
      takeData = 5;
      yield* _connectAPI();
    } else if (event is LoadMoreJournal) {}
  }

  Stream<JournalState> _connectAPI() async* {
    print("in _connectAPI");
    yield JournalLoading();
    try {
      print("in _connectAPI");
      var rs = await JournalAPI().getJournalList(offset, takeData);
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      print(jsonRes);
      journalList = JournalModel.fromJson(jsonRes);
      if (journalList.data.isNotEmpty && hasMore) {
        yield JournalLoaded();
      } else {
        yield JournalNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield JournalError(e.toString());
    }
  }
}
