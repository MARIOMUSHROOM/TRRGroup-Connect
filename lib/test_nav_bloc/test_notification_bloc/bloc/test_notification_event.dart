part of 'test_notification_bloc.dart';

@immutable
abstract class TestNotificationEvent {}

class TestNoficationNewAlertEvent extends TestNotificationEvent {}

class TestNotificationClearAlertEvent extends TestNotificationEvent {}
