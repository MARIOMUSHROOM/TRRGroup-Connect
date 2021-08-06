// import 'package:flutter/material.dart';

// enum ChatMessageType { text, audio, image, video }
// enum MessageStatus { not_sent, not_view, viewed }

// class ChatMessage {
//   final String text;
//   final String time;
//   final ChatMessageType messageType;
//   final MessageStatus messageStatus;
//   final bool isSender;

//   ChatMessage({
//     this.text = "",
//     this.time = "",
//     @required this.messageType,
//     @required this.messageStatus,
//     @required this.isSender,
//   });
// }

// List demoChatMessages = [
//   ChatMessage(
//     text: "Hi Sajol,",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     time: '08:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     time: '06:00',
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "",
//     time: '06:00',
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "คุณไปถ่ายที่ไหนมา?",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "ผมไปถ่ายที่สเปนมาครับ",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "นานหรือยังครับ?",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "เมื่อเดือนที่แล้วเองครับ",
//     time: '06:00',
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
// ];
