import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Bacheca/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/main.dart';

class BachecaScreen extends StatefulWidget {
  BachecaScreen({key}) : super(key: key);

  @override
  _BachecaState createState() => _BachecaState();
}

class _BachecaState extends State<BachecaScreen> {
  @override
  void initState() {
    super.initState();
    futureReport = getReport(user.id.toString(), token, cap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segnalazioni'),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
