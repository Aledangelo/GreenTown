import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Segnala/segnala_screen.dart';
import 'package:flutter_auth/check/checkSession.dart';
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
              "SI È VERIFICATO UN ERRORE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/error-icon.png",
              height: size.height * 0.3,
            ),
            RoundedButton(
              text: "HOME",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => checkSession(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
