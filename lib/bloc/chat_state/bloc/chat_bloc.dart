import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/chat/model/chat_message_model.dart';
import 'package:ai_flutter/chat/model/local_model.dart';
import 'package:ai_flutter/provider/chat_api.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());
  List<ChatMessageModel> chatList;
  List<ChatMessage> chatMessageList = [];
  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is LoadChatInitial) {
      yield* _connectAPI();
    } else if (event is SendMessage) {
      try {
        bool sender = true;
        var viewed = MessageStatus.sending;
        String time = DateFormat('hh:mm').format(DateTime.now());
        ChatMessage only = ChatMessage(
          text: event.message.toString(),
          time: time,
          messageType: ChatMessageType.text,
          messageStatus: viewed,
          isSender: sender,
          date: DateTime(2021, 5, 18),
        );
        chatMessageList.add(only);
        yield ChatLoaded();
        await Future.delayed(Duration(seconds: 2));
        await ChatAPI().sendMessage(event.message);
        yield* _connectAPI();
      } catch (e) {
        yield ChatError(e.toString());
      }
    } else if (event is SendMessage) {
      try {
        bool sender = true;
        var viewed = MessageStatus.sending;
        String time = DateFormat('hh:mm').format(DateTime.now());
        ChatMessage only = ChatMessage(
          text: event.message.toString(),
          time: time,
          messageType: ChatMessageType.text,
          messageStatus: viewed,
          isSender: sender,
          date: DateTime(2021, 5, 18),
        );
        chatMessageList.add(only);
        yield ChatLoaded();
        await Future.delayed(Duration(seconds: 2));
        await ChatAPI().sendMessage(event.message);
        yield* _connectAPI();
      } catch (e) {
        yield ChatError(e.toString());
      }
    } else if (event is SendImageMessage) {
      try {
        bool sender = true;
        var viewed = MessageStatus.sending;
        String time = DateFormat('hh:mm').format(DateTime.now());
        ChatMessage only = ChatMessage(
          text: "",
          time: time,
          messageType: ChatMessageType.image,
          messageStatus: viewed,
          isSender: sender,
          date: DateTime(2021, 5, 18),
        );
        chatMessageList.add(only);
        yield ChatLoaded();
        await Future.delayed(Duration(seconds: 2));
        var res = await ChatAPI().sendImageMessage(imagePath: event.path);
        print("res = $res");
        yield* _connectAPI();
      } catch (e) {
        yield ChatError(e.toString());
      }
    }
  }

  // Stream<ChatState> _sendMessage(String message) async* {
  //   try {
  //     var rs = await ChatAPI().sendMessage(message);
  //   } catch (e) {}
  // }

  Stream<ChatState> _connectAPI() async* {
    print("in _connectAPI");
    yield ChatLoading();
    try {
      print("in _connectAPI");
      var rs = await ChatAPI().getChatList();
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      print(jsonRes);
      chatList = jsonRes['data'] == null
          ? null
          : List<ChatMessageModel>.from(
              jsonRes['data'].map((x) => ChatMessageModel.fromJson(x)));
      if (chatList.isNotEmpty) {
        print(chatList.length);
        chatMessageList = new List();
        for (var i = 0; i < chatList.length; i++) {
          // print("chatMessageList");
          // print(chatMessageList.length);
          bool sender = false;
          if (chatList[i].to == 1) {
            sender = true;
          }
          var viewed = MessageStatus.not_view;
          if (chatList[i].status == 0) {
            viewed = MessageStatus.viewed;
          }
          var typeMessage = ChatMessageType.text;
          if (chatList[i].typeMessage == 2) {
            typeMessage = ChatMessageType.image;
          }
          String time = DateFormat('hh:mm').format(chatList[i].createdAt);
          ChatMessage only = ChatMessage(
            text: chatList[i].message.toString(),
            time: time,
            messageType: typeMessage,
            messageStatus: viewed,
            isSender: sender,
            date: DateTime(2021, 5, 18),
          );
          chatMessageList.add(only);
        }
        yield ChatLoaded();
      } else {
        yield ChatNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield ChatError(e.toString());
    }
  }
}
