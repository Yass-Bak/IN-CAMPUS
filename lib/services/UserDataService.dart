import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

/*
Future<void> adduserdata(
  String displayName,
  String Etablissement,
  String NiveauEtude,
  String Sexe,
  String dateNais,
  String Cin,
) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  final users = FirebaseFirestore.instance.collection('users');
  users.add({
    'displayName': displayName,
    'uid': uid,
    'Etablissement': Etablissement,
    'NiveauEtude': NiveauEtude,
    'Sexe': Sexe,
    'dateNais': dateNais,
    'Cin': Cin,
  });
}*/
class addUserData {
  final String uid;

  addUserData({required this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  /*Future updateUserData(String displayName, String Etablissement,
      String NiveauEtude, String Sexe, String dateNais, String Cin) async {
    return await users.doc(uid).set({
      'displayName': displayName,
      'Etablissement': Etablissement,
      'NiveauEtude': NiveauEtude,
      'Sexe': Sexe,
      'dateNais': dateNais,
      'Cin': Cin,
    });
  }*/

  Future createUser(String displayName, String Etablissement,
      String NiveauEtude, String Sexe, String dateNais, String Cin,List<dynamic> rendezvous,List<dynamic> heuresRdv) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    final json = {
      'displayName': displayName,
      'Etablissement': Etablissement,
      'NiveauEtude': NiveauEtude,
      'Sexe': Sexe,
      'dateNais': dateNais,
      'Cin': Cin,
      'rendezvous':rendezvous,
      'heuresRdv':heuresRdv
    };
    await docUser.set(json);
  }
}
