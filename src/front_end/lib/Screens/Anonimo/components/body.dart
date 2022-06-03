import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';

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
            Text(
              "ANONIMO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/anon.png",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "\nCon la modalità anonima non potrai publicare o commentare alcuna segnalazione\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "\nSei sicuro di voler continuare?\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RoundedButton(
              text: "CONTINUA",
              press: () {
                null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
