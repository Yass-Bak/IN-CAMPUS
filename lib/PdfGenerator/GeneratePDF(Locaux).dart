import 'dart:io';

//import 'package:flutter/material.dart' as dm;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../Services/Pdf_Api_Service.dart';

class PdfParagraphApi {
  static Future<File> generate(
    String TitreDossier,
    String NomEtudiant,
    String Cin,
    String Adresse,
    String Telephone,
    String Mail,
    String Etab,
    String Niveau,
    String Res,
    String Bac,
  ) async {
    final pdf = Document();

    MemoryImage Image = MemoryImage(
      (await rootBundle.load('img/téléchargement.png')).buffer.asUint8List(),
    );
    final customFont =
        Font.ttf(await rootBundle.load('img/BebasNeue-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader(Image),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Paragraph(
            text: "" + TitreDossier,
            style: TextStyle(font: customFont, fontSize: 20),
          ),
          buildCustomHeadline(NomEtudiant),
          Header(
              child: Text(
            'Demande Bourse ',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: PdfColors.black,
            ),
          )),
          Paragraph(text: "Numéro Carte d'identité | Identifiant :" + Cin),
          Paragraph(text: "Adresse :" + Adresse),
          Paragraph(text: "Numéro de Téléphone :" + Telephone),
          Paragraph(text: "Adresse Mail :" + Mail),
          Paragraph(text: "Etablissement Universitaire :" + Etab),
          Paragraph(text: "Niveau D'étude :" + Niveau),
          Paragraph(text: "Résultat d'année Derniére :" + Res),
          Paragraph(text: "Bac :" + Bac),
          SizedBox(height: 8 * PdfPageFormat.cm),
          ...buildBulletPoints(),
          SizedBox(height: 19 * PdfPageFormat.cm),
          buildLink(),
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );
    return PdfApi.saveDocument(
        name: 'Demande Bourse N° :' + Cin + '.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader(MemoryImage image) => Container(
        padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [
            //   PdfLogo(),
            Image(image, height: 24, width: 24),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'Office des oeuvres universitaire pour le sud',
              style: TextStyle(
                  fontSize: 20,
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline(String NomEtudiant) => Header(
        child: Text(
          '' + NomEtudiant,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.blue600),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://www.oous.rnu.tn/oous_new/index.php',
        child: Text(
          "Office des oeuvres universitaire pour le sud \n" +
              "Route de l'aéroport Km 0,5 B.P 1094 Sfax 3018 \n" +
              "Tel : (+216) 74 243 614 - Fax : (+216) 74 243 735",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: PdfColors.black,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(
            text: "Copie du certificat de démarcation d" +
                "'" +
                "un établissement d" +
                "'" +
                "enseignement supérieur pour l" +
                "'" +
                "année (2022/2021)."),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Bullet(
            text:
                "Copie du certificat de réussite ou de la divulgation de deux ans"),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Bullet(text: "Copie Fiche Résultat du  baccalauréat "),
      ];
}
