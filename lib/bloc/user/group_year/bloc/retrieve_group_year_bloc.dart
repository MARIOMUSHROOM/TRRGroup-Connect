import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'retrieve_group_year_event.dart';
part 'retrieve_group_year_state.dart';

class RetrieveGroupYearBloc extends Bloc<RetrieveGroupYearEvent, RetrieveGroupYearState> {
  RetrieveGroupYearBloc() : super(RetrieveGroupYearInitial());

  @override
  Stream<RetrieveGroupYearState> mapEventToState(
    RetrieveGroupYearEvent event,
  ) async* {
    if (event is RetrieveUserGroupYearEvent) yield* _getUserGroupYear(event.userID, event.factoryID);
  }

  Stream<RetrieveGroupYearState> _getUserGroupYear(int aUserID, int aFactoryID) async* {
    yield RetrieveGroupYearLoadingState();
  }
}
