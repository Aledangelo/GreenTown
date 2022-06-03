import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ErrorScreens/Error/error_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Confirm/confirm_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/globals.dart';
import 'package:http/http.dart' as http;

bool temp = false;

class checkReg extends StatefulWidget {
  checkReg({key}) : super(key: key);

  @override
  _checkRegState createState() => _checkRegState();
}

class _checkRegState extends State<checkReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: SignUp(
            nome, cognome, citta, email_r, cell, data, password, confirm_p),
        builder: (context, snapshot) {
          nome = "";
          cognome = "";
          citta = "";
          email_r = "";
          cell = "";
          data = "";
          password = "";
          confirm_p = "";
          if (snapshot.hasError) {
            return WelcomeScreen();
          } else if (snapshot.hasData) {
            int status = snapshot.data.statusCode;
            if (status == 200) {
              return ConfirmScreen();
            }
            if (status == 402) {
              error_s = 'ERROR - Sottoscrivere i campi obbligatori';
            }
            if (status == 401) {
              error_s = 'ERROR - Email inserita non valida';
            }
            if (status == 400) {
              error_s = 'ERROR - Email inserita già in uso';
            }
            return ErrorScreen();
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
