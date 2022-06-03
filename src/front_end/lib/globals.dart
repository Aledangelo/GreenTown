library green.globals;

import 'package:url_launcher/url_launcher.dart';

String cap =
    ""; //serve per selezionare la città di cui si vogliono vedere le segnalazioni

Utente user;
Dipendente worker;
String token =
    ""; //il token è quello generato per l'utente se si logga altrimenti è vuoto
String email = "";
String pwd = "";
String confirmCode = "";
String userId = "";
String userType = "";
int indice = 0;

String error_s = "";

//variabili registrazione
String nome = "";
String cognome = "";
String citta = "";
String email_r = ""; //mail per registrazione
String cell = "";
String data = "";
String password = "";
String confirm_p = "";

List<Report> listReport; //Per la bacheca
Future<List<Report>> futureReport;

// Variabili che servono per fare il post della segnalazione
String name = "";
String clientId = "";
String description = "";
String place = "";
String cityId = "";
String image = "";

// Classi

class Report {
  final String id;
  final String name;
  final String description;
  final String place;
  final int cityId;
  final String date;
  final String
      images;

  Report(
      {this.id,
      this.name,
      this.description,
      this.place,
      this.cityId,
      this.date,
      this.images});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        place: json['place'],
        cityId: json['cityId'],
        date: json['date'],
        images: json['images']);
  }
}

class Utente {
  final int id;
  final String name;
  final String surname;
  final String city;
  final String email;
  final String token;
  final String cell;
  final String age;

  Utente(
      {this.id,
      this.name,
      this.surname,
      this.city,
      this.email,
      this.token,
      this.cell,
      this.age});

  //prende i parametri dal json che manda il back end
  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      id: json["id"] as int,
      name: json["name"] as String,
      surname: json["cognome"] as String,
      city: json["città"] as String,
      email: json["email"] as String,
      token: json["token"] as String,
      cell: json["cell"] as String,
      age: json["age"] as String,
    );
  }
}

class Dipendente {
  final int id;
  final String username;
  final String cityId;

  Dipendente({this.id, this.username, this.cityId});

  factory Dipendente.fromJson(Map<String, dynamic> json) {
    return Dipendente(
        id: json["id"] as int,
        username: json["username"] as String,
        cityId: json['cityId'] as String);
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> launchMap(String address) async {
    String query = Uri.encodeFull(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }
}
