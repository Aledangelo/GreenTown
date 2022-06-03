import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Camera/camera_screen.dart';

Future<CameraDescription> Camera() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  return firstCamera;
}

class checkCamera extends StatefulWidget {
  checkCamera({key}) : super(key: key);

  @override
  _checkCamera createState() => _checkCamera();
}

class _checkCamera extends State<checkCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<CameraDescription>(
        future: Camera(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final CameraDescription firstCamera = snapshot.data;
            return TakePictureScreen(camera: firstCamera);
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
