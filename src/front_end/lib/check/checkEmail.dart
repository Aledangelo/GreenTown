import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ErrorScreens/Error/error_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';

bool temp = false;

class checkEmail extends StatefulWidget {
  checkEmail({key}) : super(key: key);

  @override
  _checkEmailState createState() => _checkEmailState();
}

class _checkEmailState extends State<checkEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: verifyEmail(confirmCode),
        builder: (context, snapshot) {
          confirmCode = "";
          if (snapshot.hasError) {
            return ErrorScreen();
          } else if (snapshot.hasData) {
            if (snapshot.data.statusCode == 200) {
              user = Utente.fromJson(jsonDecode(snapshot.data.body));
              return WelcomeScreen();
            } else
              return ErrorScreen();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
