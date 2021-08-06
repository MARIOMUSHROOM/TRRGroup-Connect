part of 'test_chat_notification_bloc.dart';

@immutable
abstract class TestChatNotificationState {}

class TestChatNotificationInitial extends TestChatNotificationState {}

class TestChatNotificationIncomingMessageState extends TestChatNotificationState {}

class TestChatNotificationUpdateState extends TestChatNotificationState {}
