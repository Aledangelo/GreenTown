import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import 'checkSession.dart';
import 'package:flutter_auth/Screens/ErrorScreens/Error/error_screen.dart';

class checkLogout extends StatefulWidget {
  checkLogout({key}) : super(key: key);

  @override
  _checkLogoutState createState() => _checkLogoutState();
}

class _checkLogoutState extends State<checkLogout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: logout(token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen();
          } else if (snapshot.hasData) {
            if (snapshot.data.statusCode == 200) {
              return WelcomeScreen();
            } else
              return checkSession();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
