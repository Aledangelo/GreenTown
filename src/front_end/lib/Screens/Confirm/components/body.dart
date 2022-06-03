import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/check/checkEmail.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/globals.dart';

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
              "CONFERMA IL TUO ACCOUNT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset("assets/images/send_mail.png",
                height: size.height * 0.3),
            SizedBox(height: size.height * 0.03),
            Text(
              "\nControlla la tua casella di posta\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Inserisci il codice a 6 cifre che ti è stato inviato per mail\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.3),
            RoundedInputField(
              hintText: "Codice",
              onChanged: (value) {
                confirmCode = value;
              },
            ),
            RoundedButton(
              text: "CONTINUA",
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return checkEmail();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
