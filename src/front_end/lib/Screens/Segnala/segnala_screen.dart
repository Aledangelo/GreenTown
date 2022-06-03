import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Segnala/components/body.dart';
import 'package:flutter_auth/constants.dart';

class SegnalaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EFFETTUA UNA SEGNALAZIONE'),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
