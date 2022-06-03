import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Confirm/confirm_screen.dart';
import 'package:flutter_auth/Screens/ErrorScreens/Error/error_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import 'checkSession.dart';

class checkLogin extends StatefulWidget {
  checkLogin({key}) : super(key: key);

  @override
  _checkLoginState createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: login(email, pwd, userType),
        builder: (context, snapshot) {
          email = "";
          pwd = "";
          if (snapshot.hasError) {
            return ErrorScreen();
          } else if (snapshot.hasData) {
            Map<String, dynamic> map = jsonDecode(snapshot.data.body);
            if (snapshot.data.statusCode == 200) {
              token = map["token"];
              return checkSession();
            } else if (snapshot.data.statusCode == 300) {
              return ConfirmScreen();
            } else
              return WelcomeScreen();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
