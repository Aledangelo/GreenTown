import 'dart:async';
import 'dart:io';
import 'package:flutter_auth/globals.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_auth/check/checkPostReport.dart';
import 'package:flutter_auth/components/rounded_button.dart';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image_take = await _controller.takePicture();
            final List<int> bytes = File(image_take.path).readAsBytesSync();

            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image_take.path,
                  img: bytes,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final List<int> img;

  const DisplayPictureScreen({Key key, this.imagePath, this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Image.file(File(imagePath)),
        floatingActionButton: RoundedButton(
            text: 'SEGNALA!',
            press: () {
              image = base64Encode(img);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return checkPostReport();
              }));
            }));
  }
}
