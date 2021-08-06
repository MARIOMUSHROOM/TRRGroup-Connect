import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { sending, not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final String time;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final DateTime date;

  ChatMessage({
    this.text = "",
    this.time = "",
    @required this.messageType,
    @required this.messageStatus,
    @required this.isSender,
    @required this.date,
  });
}
