import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/AccountWork/components/body.dart';
import 'package:flutter_auth/constants.dart';

class AccountWorkScreen extends StatefulWidget {
  AccountWorkScreen({key}) : super(key: key);

  @override
  _AccountWorkState createState() => _AccountWorkState();
}

class _AccountWorkState extends State<AccountWorkScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILO'),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}