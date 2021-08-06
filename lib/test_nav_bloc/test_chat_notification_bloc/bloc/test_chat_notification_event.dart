part of 'test_chat_notification_bloc.dart';

@immutable
abstract class TestChatNotificationEvent {}

class TestChatNotificationSendMessageEvent extends TestChatNotificationEvent {}

class TestChatNotificationClearAlertCount extends TestChatNotificationEvent {}
