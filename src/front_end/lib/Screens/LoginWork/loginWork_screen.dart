import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/AccountWork/accountWork_screen.dart';
import 'package:flutter_auth/Screens/LoginWork/components/body.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/Screens/Account/account_screen.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class LoginWorkScreen extends StatefulWidget {
  LoginWorkScreen({key}) : super(key: key);
  @override
  _LoginWorkState createState() => _LoginWorkState();
}

class _LoginWorkState extends State<LoginWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
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
