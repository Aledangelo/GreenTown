import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/account_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/Screens/AccountWork/accountWork_screen.dart';
import 'package:http/http.dart' as http;

bool temp = false;

class checkSession extends StatefulWidget {
  checkSession({key}) : super(key: key);

  @override
  _checkSessionState createState() => _checkSessionState();
}

class _checkSessionState extends State<checkSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: checkToken(token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return WelcomeScreen();
          } else if (snapshot.hasData) {
            Map<String, dynamic> map = jsonDecode(snapshot.data.body);
            if (snapshot.data.statusCode == 200) {
              if (map["userType"] == "usr") {
                user = Utente.fromJson(map);
                return AccountScreen();
              } else {
                worker = Dipendente.fromJson(map);
                return AccountWorkScreen();
              }
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
