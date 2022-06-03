import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Segnala/segnala_screen.dart';
import 'package:flutter_auth/check/checkLogout.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/Screens/SelezionaCap/selezionaCap_screen.dart';

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
              "assets/images/user.png",
              height: size.height * 0.2,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Nome: " +
                  user.name.toString() +
                  "        Cognome: " +
                  user.surname.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Data di Nascita: " +
                  user.age.toString() +
                  "        Cellulare: " +
                  user.cell.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Città: " + user.city.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Email: " + user.email.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "VISUALIZZA BACHECA",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelezionaCapScreen();
                }));
              },
            ),
            RoundedButton(
              text: "PUBBLICA SEGNALAZIONE",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SegnalaScreen();
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
