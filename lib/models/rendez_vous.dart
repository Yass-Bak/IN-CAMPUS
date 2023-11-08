// To parse this JSON data, do
//
//     final rendezVous = rendezVousFromJson(jsonString);

import 'dart:convert';

List<RendezVous> rendezVousFromJson(String str) => List<RendezVous>.from(json.decode(str).map((x) => RendezVous.fromJson(x)));

String rendezVousToJson(List<RendezVous> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RendezVous {
  RendezVous({
    this.date,
    this.heures,
  });

  DateTime? date;
  List<Heure>? heures;

  factory RendezVous.fromJson(Map<String, dynamic> json) => RendezVous(
    date: json["date"],
    heures: List<Heure>.from(json["heures"].map((x) => Heure.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "heures": List<dynamic>.from(heures!.map((x) => x.toJson())),
  };
}

class Heure {
  Heure({
    this.heure,
    this.etudiant,
    this.type,
  });

  String? heure;
  String? etudiant;
  String? type;

  factory Heure.fromJson(Map<String, dynamic> json) => Heure(
    heure: json["heure"],
    etudiant: json["etudiant"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "heure": heure,
    "etudiant": etudiant,
    "type": type,
  };
}
