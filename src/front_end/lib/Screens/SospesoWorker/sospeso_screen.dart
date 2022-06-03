import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SospesoWorker/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/main.dart';

class SospesoScreen extends StatefulWidget {
  SospesoScreen({key}) : super(key: key);

  @override
  _SospesoState createState() => _SospesoState();
}

class _SospesoState extends State<SospesoScreen> {
  @override
  void initState() {
    super.initState();
    futureReport =
        getReportDipendenti(worker.id.toString(), token, worker.cityId, 'no');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segnalazioni in sospeso'),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
