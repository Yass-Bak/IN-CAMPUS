import 'package:cloud_firestore/cloud_firestore.dart';

class Etat {
  String Cin;
  String EtatDossier;
  String Etudiant;
  Etat({required this.Cin, required this.EtatDossier, required this.Etudiant});
  Map<String, dynamic> toJson() => {
        'Cin': Cin,
        'EtatDossier': EtatDossier,
        'Etudiant': Etudiant,
      };
  static Etat fromJson(Map<String, dynamic> json) => Etat(
        Cin: json['Cin'],
        EtatDossier: json['EtatDossier'],
        Etudiant: json['Etudiant'],
      );
}
