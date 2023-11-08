import 'package:cloud_firestore/cloud_firestore.dart';

class Uuser {
  String? displayName;
  String? Etablissement;
  String? NiveauEtude;
  String? Sexe;
  String? dateNais;
  String? Cin;
  List<dynamic>? rendezvous;
  List<dynamic>? heuresRdv;
  Uuser(this.displayName, this.Etablissement, this.NiveauEtude, this.Sexe,
      this.dateNais, this.Cin,this.rendezvous,this.heuresRdv);
  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'Etablissement': Etablissement,
        'NiveauEtude': NiveauEtude,
        'Sexe': Sexe,
        'dateNais': dateNais,
        'Cin': Cin,
        'rendezvous': rendezvous,
        'heuresRdv': heuresRdv

      };
  static Uuser fromJson(Map<String, dynamic> json) => Uuser(
        json['displayName'],
        json['Etablissement'],
        json['NiveauEtude'],
        json['Sexe'],
        json['dateNais'],
        json['Cin'],
        json['rendezvous'],
        json['heuresRdv'],
      );
}
