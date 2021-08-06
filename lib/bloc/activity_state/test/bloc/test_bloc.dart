import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial());
  String titleClass;
  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    if (event is ChangeTitle) {
      print(event.title);
      titleClass = event.title + " class";
      yield TestChanged(event.title);
    }
  }
}
