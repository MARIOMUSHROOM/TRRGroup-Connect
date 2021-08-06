import 'dart:async';

import 'package:ai_flutter/bloc/chat_state/bloc/chat_bloc.dart';
import 'package:ai_flutter/chat/chat_input_field.dart';
import 'package:ai_flutter/chat/chat_message.dart';
import 'package:ai_flutter/chat/test/test_data.dart';
import 'package:ai_flutter/chat/model/local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  List<ChatMessage> chatMessageList = [];
  ChatBloc _chatBloc;
  @override
  Widget build(BuildContext context) {
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "TRR Group",
            style: GoogleFonts.montserrat(
                fontSize: 27.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: Colors.white)),
          ),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatInitial) {
              _chatBloc.add(LoadChatInitial());
            } else if (state is ChatLoaded) {
              chatMessageList = _chatBloc.chatMessageList;
              Timer(Duration(milliseconds: 100), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              print("chat loaded");
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: chatMessageList.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: 5.0, right: 10.0),
                                // child: Text(chatMessageList[index].text),
                                child: Message(message: chatMessageList[index]),
                                // child: Message(message: demoChatMessages[index]),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
                // SizedBox(height: 30),
              ],
            );
          },
        ),
        bottomNavigationBar: ChatInputField(
          controller: textController,
          onSend: () async {
            _chatBloc.add(SendMessage(textController.text));
            textController.clear();
            Timer(Duration(milliseconds: 100), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            // print(textController.text);
            // DateTime now = DateTime.now();
            // String timeFormat = DateFormat('kk:mm').format(now);
            // setState(() {
            //   chatMessageList.add(ChatMessage(
            //     text: textController.text,
            //     time: timeFormat,
            //     messageType: ChatMessageType.text,
            //     messageStatus: MessageStatus.not_view,
            //     isSender: true,
            //     date: now,
            //   ));
            // });
            // textController.clear();
            // scrollController.animateTo(scrollController.position.maxScrollExtent,
            //     duration: const Duration(milliseconds: 500),
            //     curve: Curves.easeOut);
          },
        ),
      ),
    );
  }
}
