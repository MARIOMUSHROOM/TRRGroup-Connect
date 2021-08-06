part of 'test_notification_bloc.dart';

@immutable
abstract class TestNotificationState {}

class TestNotificationInitial extends TestNotificationState {}

class TestNotificaitonIncomingState extends TestNotificationState {}

class TestNotificationUpdateState extends TestNotificationState {}
