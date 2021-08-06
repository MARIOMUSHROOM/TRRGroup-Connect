import 'package:flutter/material.dart';

class CouldUploadWidget extends StatelessWidget {
  const CouldUploadWidget({Key key, this.onTap, @required this.imagePath})
      : super(key: key);
  final Function() onTap;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: imagePath == null
          ? Align(
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.cloud_upload_outlined,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(imagePath),
              ),
            ),
    );
  }
}
