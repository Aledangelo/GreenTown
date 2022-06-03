import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/account_screen.dart';
import 'dart:convert';
import 'package:flutter_auth/Screens/Signup/components/body.dart';
import 'package:flutter_auth/globals.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: checkToken(token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Body();
          } else if (snapshot.hasData) {
            if (snapshot.data.statusCode == 200) {
              user = Utente.fromJson(jsonDecode(snapshot.data.body));
              return AccountScreen();
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
