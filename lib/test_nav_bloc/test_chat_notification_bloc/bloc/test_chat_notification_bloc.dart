import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_chat_notification_event.dart';
part 'test_chat_notification_state.dart';

class TestChatNotificationBloc extends Bloc<TestChatNotificationEvent, TestChatNotificationState> {
  TestChatNotificationBloc() : super(TestChatNotificationInitial());

  int messageCount = 0;

  @override
  Stream<TestChatNotificationState> mapEventToState(
    TestChatNotificationEvent event,
  ) async* {
    if (event is TestChatNotificationSendMessageEvent) {
      yield* _updateMessage();
    } else if (event is TestChatNotificationClearAlertCount) {
      yield* _clearMessageCount();
    }
  }

  Stream<TestChatNotificationState> _updateMessage() async* {
    yield TestChatNotificationIncomingMessageState();
    try {
      messageCount += 1;
    } finally {
      yield TestChatNotificationUpdateState();
    }
  }

  Stream<TestChatNotificationState> _clearMessageCount() async* {
    yield TestChatNotificationIncomingMessageState();
    try {
      messageCount = 0;
    } finally {
      yield TestChatNotificationUpdateState();
    }
  }
}
