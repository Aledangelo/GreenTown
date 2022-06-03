import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/check/checkReg.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/globals.dart';
import 'package:crypt/crypt.dart';


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
            RoundedInputField(
              hintText: "Nome - campo obbligatorio",
              onChanged: (value) {
                nome = value;
              },
            ),
            RoundedInputField(
              hintText: "Cognome - campo obbligatorio",
              onChanged: (value) {
                if (value.isEmpty) {
                  return "Campo obbligatorio";
                }
                cognome = value;
              },
            ),
            RoundedInputField(
              hintText: "Comune - campo obbligatorio",
              onChanged: (value) {
                if (value.isEmpty) {
                  return "Campo obbligatorio";
                }
                citta = value;
              },
            ),
            RoundedInputField(
              hintText: "Email - campo obbligatorio",
              onChanged: (value) {
                if (value.isEmpty) {
                  return "Campo obbligatorio";
                }
                email_r = value;
              },
            ),
            RoundedInputField(
              hintText: "Cellulare",
              onChanged: (value) {
                if (value.isEmpty) {
                  return "Campo obbligatorio";
                }
                cell = value;
              },
            ),
            RoundedInputField(
              hintText: "Data di nascita",
              onChanged: (value) {
                if (value.isEmpty) {
                  return "Campo obbligatorio";
                }
                data = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                value = Crypt.sha256(value, salt:'GreenTown').toString();
                password = value;
              },
            ),

            RoundedButton(
              text: "REGISTRATI",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return checkReg();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.04),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
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
