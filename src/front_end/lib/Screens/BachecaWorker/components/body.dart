import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EspandiSegnalazione/espandi_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/globals.dart';
import 'package:flutter_auth/check/checkElimina.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: (new FutureBuilder(
            future: futureReport,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                listReport = snapshot.data;
                return new ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: listReport.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("${snapshot.data[index].name}")
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("${snapshot.data[index].description}")
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('APRI'),
                                  onPressed: () {
                                    indice = index;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EspandiScreen(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('MAPS'),
                                  onPressed: () {
                                    MapUtils.launchMap(
                                        "${snapshot.data[index].place}, ${snapshot.data[index].cityId}");
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('ELIMINA'),
                                  onPressed: () {
                                    indice = index;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return checkElimina();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return new Center(child: new CircularProgressIndicator());
              }
            })));
  }
}
