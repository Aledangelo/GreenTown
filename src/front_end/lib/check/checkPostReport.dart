import 'package:flutter_auth/Screens/ErrorScreens/ErrorScreenAfterLogin/error_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Success/success_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/main.dart';
import '../globals.dart';

bool temp = false;

class checkPostReport extends StatefulWidget {
  checkPostReport({key}) : super(key: key);

  @override
  _checkPostReport createState() => _checkPostReport();
}

class _checkPostReport extends State<checkPostReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: postReport(
            user.id.toString(), token, name, description, place, cityId, image),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return WelcomeScreen();
          } else if (snapshot.hasData) {
            int stato = snapshot.data.statusCode;
            if (stato == 201) {
              return SuccessScreen();
            } else
              return ErrorScreenAfterLogin();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
