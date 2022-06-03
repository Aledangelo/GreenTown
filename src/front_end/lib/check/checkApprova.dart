import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Success/success_screen.dart';
import 'package:flutter_auth/Screens/ErrorScreens/ErrorScreenAfterLogin/error_screen.dart';
import 'package:flutter_auth/main.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';

class checkApprova extends StatefulWidget {
  checkApprova({key}) : super(key: key);

  @override
  _checkApprovaState createState() => _checkApprovaState();
}

class _checkApprovaState extends State<checkApprova> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<http.Response>(
        future: approva(listReport[indice].id, worker.id.toString(), token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreenAfterLogin();
          } else if (snapshot.hasData) {
            if (snapshot.data.statusCode == 200) {
              return SuccessScreen();
            } else {
              return ErrorScreenAfterLogin();
            }
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),
    );
  }
}