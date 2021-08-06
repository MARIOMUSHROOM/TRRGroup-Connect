part of 'notify_bloc.dart';

@immutable
abstract class NotifyEvent {}

class LoadNotifyInitial extends NotifyEvent {
  @override
  String toString() => "LoadNotifyInitial{}";
}

class LoadMoreNotify extends NotifyEvent {
  @override
  String toString() => "LoadMoreNotify{}";
}
// class NewNotifyFromFCM extends NotifyEvent {
//   NewNotifyFromFCM(this.fcmNotification);
//   FcmNotification fcmNotification;
//   @override
//   String toString() => "UpdateNotify{}";
// }

class ReadNotify extends NotifyEvent {
  ReadNotify(this.notificationId);
  int notificationId;
  @override
  String toString() => "ReadNotify{}";
}

class CountNewNotify extends NotifyEvent {
  @override
  String toString() => "CountNewNotify{}";
}

class CountClearNotify extends NotifyEvent {
  @override
  String toString() => "CountClearNotify{}";
}
