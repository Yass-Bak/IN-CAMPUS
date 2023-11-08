import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  String? Contenu;
  DateTime? Created_at;
  String? Created_by;

  Posts(
    this.Contenu,
    this.Created_at,
    this.Created_by,
  );
  Map<String, dynamic> toJson() => {
        'Contenu': Contenu,
        'Created_at': Created_at,
        'Created_by': Created_by,
      };
  static Posts fromJson(Map<String, dynamic> json) => Posts(
        json['Contenu'],
        json['Created_at'],
        json['Created_by'],
      );
}
