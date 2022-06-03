import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/AccountWork/accountWork_screen.dart';
import 'package:flutter_auth/Screens/Login/components/body.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/Screens/Account/account_screen.dart';
import 'package:http/http.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<Response>(
        future: checkToken(token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Body();
          } else if (snapshot.hasData) {
            Map<String, dynamic> map = jsonDecode(snapshot.data.body);
            if (snapshot.data.statusCode == 200) {
              if (map["userType"] == "usr") {
                user = Utente.fromJson(jsonDecode(snapshot.data.body));
                return AccountScreen();
              } else {
                worker = Dipendente.fromJson(jsonDecode(snapshot.data.body));
                return AccountWorkScreen();
              }
            } else
              return Body();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
