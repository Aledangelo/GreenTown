import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/check/checkSession.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';

import 'package:flutter_auth/constants.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

Future<http.Response> verifyEmail(String codice) async {
  final response =
      await http.post(Uri.parse("https://${host_port}/user/checkEmail"),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': codice.toString()}));

  return response;
}

Future<http.Response> checkToken(String token) async {
  final response = await http.get(
      Uri.parse("https://${host_port}/user/checkToken"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'X-API-Key': token,
      });

  return response;
}

Future<http.Response> SignUp(
    String nome,
    String cognome,
    String citta,
    String email_r,
    String cell,
    String data,
    String password,
    String confirm_p) async {
  final response = await http.post(
    Uri.parse("https://${host_port}/user/Registration"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nome': nome,
      'cognome': cognome,
      'citta': citta,
      'email_r': email_r,
      'cell': cell,
      'data': data,
      'password': password,
      'confermap': confirm_p,
    }),
  );

  return response;
}

Future<http.Response> postReport(String clientId, String token, String name,
    String description, String place, String cityId, String image) async {
  String formattedStr =
      formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
  final response = await http.post(
    Uri.parse(
        "https://${host_port}/reports"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-API-Key': token,
      'userId': clientId,
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'description': description,
      'place': place,
      'cityId': cityId,
      'date': formattedStr,
      'images': image
    }),
  );

  return response;
}

Future<List<Report>> getReport(
    String clientId, String token, String cityId) async {
  final response = await http.get(
      Uri.parse("https://${host_port}/reports/" + cityId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': token,
        'userId': clientId,
        'userType': userType,
      });
  if (response.statusCode == 200) {
    print('ok');
    listReport = (jsonDecode(response.body) as List)
        .map((data) => Report.fromJson(data))
        .toList();
    return listReport;
  } else
    throw Exception("Si è verificato un errore durante l'accesso");
}

Future<http.Response> elimina(
    String reportId, String clientId, String token) async {
  final response = await http.delete(
      Uri.parse("https://${host_port}/reports/destroy/" + reportId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': token,
        'userId': clientId,
      });
  return response;
}

Future<http.Response> approva(
    String reportId, String clientId, String token) async {
  final response = await http.patch(
      Uri.parse("https://${host_port}/reports/approva/" + reportId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': token,
        'userId': clientId,
      });
  return response;
}

Future<List<Report>> getReportDipendenti(
    String clientId, String token, String cityId, String status) async {
  final response = await http.get(
      Uri.parse("https://${host_port}/reports/" + cityId + "?status=" + status),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': token,
        'userId': clientId,
        'userType': userType,
      });
  if (response.statusCode == 200) {
    print('ok');
    listReport = (jsonDecode(response.body) as List)
        .map((data) => Report.fromJson(data))
        .toList();
    return listReport;
  } else
    throw Exception("Si è verificato un errore durante l'accesso");
}

Future<http.Response> login(
    String email, String password, String usrType) async {
  final response = await http.post(
    Uri.parse(
        "https://${host_port}/user/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'userType': usrType
    }),
  );

  return response;
}

Future<http.Response> logout(String token) async {
  final response = await http.get(
    Uri.parse("https://${host_port}/user/logout"),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
      'X-API-Key': token,
    },
  );
  return response;
}


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenTown',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.lightGreenAccent, 
      ),
      home: WelcomeScreen(),
    );
  }
}
