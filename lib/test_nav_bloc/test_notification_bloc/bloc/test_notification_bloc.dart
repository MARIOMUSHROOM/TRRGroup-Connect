import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_notification_event.dart';
part 'test_notification_state.dart';

class TestNotificationBloc
    extends Bloc<TestNotificationEvent, TestNotificationState> {
  TestNotificationBloc() : super(TestNotificationInitial());

  int notifyCount = 0;

  @override
  Stream<TestNotificationState> mapEventToState(
    TestNotificationEvent event,
  ) async* {
    if (event is TestNoficationNewAlertEvent)
      yield* _addNotification();
    else if (event is TestNotificationClearAlertEvent)
      yield* _clearNotification();
  }

  Stream<TestNotificationState> _addNotification() async* {
    yield TestNotificaitonIncomingState();
    try {
      notifyCount += 1;
    } finally {
      yield TestNotificationUpdateState();
    }
  }

  Stream<TestNotificationState> _clearNotification() async* {
    yield TestNotificaitonIncomingState();
    try {
      notifyCount = 0;
    } finally {
      yield TestNotificationUpdateState();
    }
  }
}
