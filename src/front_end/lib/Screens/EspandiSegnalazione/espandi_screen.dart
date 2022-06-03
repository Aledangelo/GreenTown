import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EspandiSegnalazione/components/body.dart';
import 'package:flutter_auth/constants.dart';

class EspandiScreen extends StatefulWidget {
  EspandiScreen({key}) : super(key: key);

  @override
  _EspandiState createState() => _EspandiState();
}

class _EspandiState extends State<EspandiScreen> {
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
