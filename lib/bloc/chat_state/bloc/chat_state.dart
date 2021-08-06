part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  @override
  String toString() => "ChatLoaded{}";
}

class ChatLazyLoading extends ChatState {}

class ChatLazyLoaded extends ChatState {}

class ChatNoData extends ChatState {}

class ChatError extends ChatState {
  ChatError(this.message);
  String message;
  @override
  String toString() => "ChatError{message: $message}";
}
