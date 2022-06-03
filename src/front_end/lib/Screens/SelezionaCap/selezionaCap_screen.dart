import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SelezionaCap/components/body.dart';
import 'package:flutter_auth/constants.dart';

class SelezionaCapScreen extends StatefulWidget {
  SelezionaCapScreen({key}) : super(key: key);

  @override
  _SelezionaCapState createState() => _SelezionaCapState();
}

class _SelezionaCapState extends State<SelezionaCapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserisci il CAP'),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
