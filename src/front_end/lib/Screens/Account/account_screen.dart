import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/body.dart';
import 'package:flutter_auth/constants.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
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