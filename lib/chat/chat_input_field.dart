import 'dart:io';

import 'package:ai_flutter/bloc/chat_state/bloc/chat_bloc.dart';
import 'package:ai_flutter/chat/take_camera_page.dart';
import 'package:ai_flutter/theme/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({
    Key key,
    @required this.controller,
    @required this.onSend,
  }) : super(key: key);
  final TextEditingController controller;
  final Function() onSend;

  ImagePicker _imgPicker = ImagePicker();

  _doTakePhoto(BuildContext context) async {
    PickedFile img = await _imgPicker.getImage(source: ImageSource.gallery);
    if (img != null && img.path != null) {
      File imgFile = await FlutterExifRotation.rotateImage(path: img.path);
      BlocProvider.of<ChatBloc>(context).add(SendImageMessage(imgFile));
    } else {
      // _imgPicker = ImagePicker();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6), blurRadius: 12.0, color: kPrimaryColor)
          ]),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: kDefaultPadding / 4,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "กรอกข้อความ",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var cameras = await availableCameras();
                      var firstCamera = cameras.first;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TakeCameraPage(
                                    camera: firstCamera,
                                  ))).then((value) async {
                        print(value.path);
                        File file = File(value.path);
                        BlocProvider.of<ChatBloc>(context)
                            .add(SendImageMessage(file));
                      });
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                      size: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _doTakePhoto(context);
                    },
                    child: Icon(
                      Icons.image_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                      size: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: onSend,
                    child: Icon(
                      Icons.send_rounded,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
