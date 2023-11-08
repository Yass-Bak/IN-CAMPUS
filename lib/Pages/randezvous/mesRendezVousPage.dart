import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_campus/Pages/randezvous/BookingCalendar.dart';
import 'package:in_campus/Pages/randezvous/randezvous_page.dart';
import 'package:in_campus/main.dart';

import '../../helper/hexColors.dart';
import '../../models/User.dart';

class MesRendezVousPage extends StatefulWidget {
  const MesRendezVousPage({Key? key}) : super(key: key);

  @override
  _MesRendezVousPageState createState() => _MesRendezVousPageState();
}

class _MesRendezVousPageState extends State<MesRendezVousPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.fromHex('DBD9D9'),
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (_) => (RendezVousPage()))),
            child: Icon(FontAwesomeIcons.arrowLeft),
          ),
          backgroundColor: HexColor.fromHex('2F2E41'),
          title: Text("Mes Rendez-Vous"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/HomeScreen');
                // do something
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: MyApp.uuser!.heuresRdv!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    elevation: 24.0,
                    backgroundColor: Colors.white,
                    title: const Text("Voulez-vous Supprimer ce rendez-vous?"),
                    //  content: Text("Choose one"),
                    actions: <Widget>[
                      FlatButton(
                        color: HexColor.fromHex('2F2E41'),
                        child: const Text("Oui",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          String des = MyApp.uuser!.heuresRdv![index];
                          String date = des.split(" ").first;
                          final docUser = FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid);
                          docUser.update({
                            'rendezvous': FieldValue.arrayRemove([date]),
                            'heuresRdv': FieldValue.arrayRemove([des])
                          });
                          final rdv = FirebaseFirestore.instance
                              .collection("Rendez-vous")
                              .doc(date.split("/")[0] +
                                  "-" +
                                  date.split("/")[1] +
                                  "-" +
                                  date.split("/")[2]);
                          rdv.get().then((snapshot) async {
                            if (snapshot.exists) {
                              log("---------------------------------");
                              log(snapshot.toString());
                              final json = {
                                'date': date,
                                'heures':
                                    FieldValue.arrayRemove([des.split(" ")[2]]),
                                'etudiants':
                                    FieldValue.arrayRemove([MyApp.cin]),
                                'raison': FieldValue.arrayRemove([des])
                              };
                              await rdv.update(json);
                            }
                          });
                          final docUser2 = FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid);
                          docUser2.get().then((value) {
                            if (value.exists) {
                              MyApp.uuser = Uuser(
                                  Uuser.fromJson(value.data()!).displayName,
                                  Uuser.fromJson(value.data()!).Etablissement!,
                                  Uuser.fromJson(value.data()!).NiveauEtude!,
                                  Uuser.fromJson(value.data()!).Sexe!,
                                  Uuser.fromJson(value.data()!).dateNais!,
                                  Uuser.fromJson(value.data()!).Cin!,
                                  Uuser.fromJson(value.data()!).rendezvous!,
                                  Uuser.fromJson(value.data()!).heuresRdv!);
                              MyApp.cin = Uuser.fromJson(value.data()!).Cin!;
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (_) => MesRendezVousPage()));
                            }
                          });
                        },
                      ),
                      FlatButton(
                        color: HexColor.fromHex('2F2E41'),
                        child: const Text("Non",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 30, top: 20, bottom: 20, right: 30),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: HexColor.fromHex('FFFFFF'),
                ),
                child: Text(
                  MyApp.uuser!.heuresRdv![index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: HexColor.fromHex('01579B'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
