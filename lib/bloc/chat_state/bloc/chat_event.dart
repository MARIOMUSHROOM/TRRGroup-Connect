part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChatInitial extends ChatEvent {
  @override
  String toString() => "LoadChatInitial{}";
}

class LoadMoreChat extends ChatEvent {
  @override
  String toString() => "LoadMoreChat{}";
}

class SendMessage extends ChatEvent {
  SendMessage(this.message);
  String message;
  @override
  String toString() => "SendChat{}";
}

class SendImageMessage extends ChatEvent {
  SendImageMessage(this.path);
  File path;
  @override
  String toString() => "SendImageMessage{}";
}
