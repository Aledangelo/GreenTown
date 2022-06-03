import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/BachecaWorker/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/main.dart';

class BachecaScreenWorker extends StatefulWidget {
  BachecaScreenWorker({key}) : super(key: key);

  @override
  _BachecaWorkerState createState() => _BachecaWorkerState();
}

class _BachecaWorkerState extends State<BachecaScreenWorker> {
  @override
  void initState() {
    super.initState();
    futureReport =
        getReportDipendenti(worker.id.toString(), token, worker.cityId, 'si');
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
