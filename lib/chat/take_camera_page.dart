import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TakeCameraPage extends StatefulWidget {
  final CameraDescription camera;

  const TakeCameraPage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakeCameraPageState createState() => TakeCameraPageState();
}

class TakeCameraPageState extends State<TakeCameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  // List<XFile> imagePathList = [];
  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "ถ่ายรูป",
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: _height,
        width: _width,
        color: Colors.black,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RawMaterialButton(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
          ),
          // fillColor: Colors.white,
          fillColor: Colors.grey[300],
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              Navigator.pop(context, image);
            } catch (e) {
              print(e);
            }
          },
          child: Container(
              child: Text(
            "ยืนยัน",
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
          constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width,
            height: 56.0,
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     try {
      //       await _initializeControllerFuture;
      //       final image = await _controller.takePicture();
      //       // imagePathList.add(image);
      //       Navigator.pop(context, image);
      //       // await Navigator.of(context).push(
      //       //   MaterialPageRoute(
      //       //     builder: (context) => DisplayPictureScreen(
      //       //       imagePath: imagePathList,
      //       //     ),
      //       //   ),
      //       // );
      //       // await Navigator.of(context).push(
      //       //   MaterialPageRoute(
      //       //     builder: (context) => DisplayPictureScreen(
      //       //       imagePath: image.path,
      //       //     ),
      //       //   ),
      //       // );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
    );
  }
}
