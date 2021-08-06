import 'package:ai_flutter/chat/model/local_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final double kDefaultPadding = 15.0;
final Color kPrimaryColor = Colors.blue;
final Color kErrorColor = Colors.red;

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.image:
          return ImageMessage(message: message);
          break;
        // case ChatMessageType.audio:
        //   return AudioMessage(message: message);
        //   break;
        // case ChatMessageType.video:
        //   return VideoMessage(message: message);
        //   break;
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/avatar/user_01.png"),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            )
          ],
          if (message.isSender)
            Container(
              padding: EdgeInsets.only(left: 5.0, top: 0.0),
              child: Column(
                children: [
                  MessageStatusDot(status: message.messageStatus),
                  Text(
                    message.time,
                    style: GoogleFonts.kanit(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        textStyle: TextStyle(color: kPrimaryColor)),
                  ),
                ],
              ),
            ),
          SizedBox(width: 5),
          messageContaint(message),
          if (!message.isSender)
            Container(
              padding: EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  Text(
                    message.time,
                    style: GoogleFonts.kanit(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        textStyle: TextStyle(color: kPrimaryColor)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color dotColor(MessageStatus status) {
    //   switch (status) {
    //     case MessageStatus.not_sent:
    //       return kErrorColor;
    //       break;
    //     case MessageStatus.not_view:
    //       return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
    //       break;
    //     case MessageStatus.viewed:
    //       return kPrimaryColor;
    //       break;
    //     default:
    //       return Colors.transparent;
    //   }
    // }

    return Column(
      children: [sendStatusWidget(context)],
    );

    // Text(
    //   message,
    //   style: GoogleFonts.kanit(
    //       fontSize: 12.0,
    //       fontWeight: FontWeight.w600,
    //       textStyle: TextStyle(color: kPrimaryColor)),
    // ),

    // return Column(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(left: kDefaultPadding / 2),
    //       height: 16.0,
    //       width: 16.0,
    //       decoration:
    //           BoxDecoration(color: dotColor(status), shape: BoxShape.circle),
    //       child: Icon(
    //           status == MessageStatus.not_sent
    //               ? Icons.error_rounded
    //               : Icons.done,
    //           size: 14.0,
    //           color: Theme.of(context).scaffoldBackgroundColor),
    //     ),
    //   ],
    // );
  }

  Widget sendStatusWidget(BuildContext context) {
    switch (status) {
      case MessageStatus.not_sent:
        // return kErrorColor;
        return Container(
          // margin: EdgeInsets.only(left: kDefaultPadding / 2),
          height: 16.0,
          width: 16.0,
          decoration: BoxDecoration(color: kErrorColor, shape: BoxShape.circle),
          child: Icon(Icons.error_rounded,
              size: 14.0, color: Theme.of(context).scaffoldBackgroundColor),
        );
        break;
      case MessageStatus.not_view:
        return Container(
          child: Text(
            'ยังไม่อ่าน',
            style: GoogleFonts.kanit(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: kPrimaryColor)),
          ),
        );
        // return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
        break;
      case MessageStatus.viewed:
        return Container(
          child: Text(
            'อ่านแล้ว',
            style: GoogleFonts.kanit(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: kPrimaryColor)),
          ),
        );
        // return kPrimaryColor;
        break;
      case MessageStatus.sending:
        return Container(
          // margin: EdgeInsets.only(left: kDefaultPadding / 2),
          height: 16.0,
          width: 16.0,
          decoration:
              BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
          child: Icon(Icons.send,
              size: 14.0, color: Theme.of(context).scaffoldBackgroundColor),
        );
        // return kPrimaryColor;
        break;
      default:
        return Container(
          // margin: EdgeInsets.only(left: kDefaultPadding / 2),
          height: 16.0,
          width: 16.0,
          decoration: BoxDecoration(color: kErrorColor, shape: BoxShape.circle),
          child: Icon(Icons.error_rounded,
              size: 14.0, color: Theme.of(context).scaffoldBackgroundColor),
        );
      // return Colors.transparent;
    }

    // if (status != MessageStatus.not_sent) {
    //   return Container(
    //     child: Text(
    //       status == MessageStatus.not_view ? 'ยังไม่อ่าน' : 'อ่านแล้ว',
    //       style: GoogleFonts.kanit(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.w600,
    //           textStyle: TextStyle(color: kPrimaryColor)),
    //     ),
    //   );
    // }
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.08),
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            message.text,
            style: GoogleFonts.kanit(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                textStyle: TextStyle(
                    color: message.isSender
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyText1.color)),
          ),
        ),
      ],
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
            maxHeight: 150,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: message.messageStatus == MessageStatus.sending
              ? Text(
                  "uploading...",
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    message.text,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Text("Failed image"),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
