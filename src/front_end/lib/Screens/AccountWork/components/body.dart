import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/check/checkLogout.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/Screens/BachecaWorker/bachecaWorker_screen.dart';
import 'package:flutter_auth/Screens/SospesoWorker/sospeso_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/id-card.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Username: " + worker.username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "VISUALIZZA BACHECA",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BachecaScreenWorker();
                }));
              },
            ),
            RoundedButton(
              text: "SEGNALAZIONI IN SOSPESO",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SospesoScreen();
                }));
              },
            ),
            RoundedButton(
              text: "LOGOUT",
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return checkLogout();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
