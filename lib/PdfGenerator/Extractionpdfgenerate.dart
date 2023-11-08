import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../Services/Pdf_Api_Service.dart';

class PdfExtractionNon {
  static Future<File> generate(
      String TitreDossier,
      String NomEtudiant,
      String Cin,
      String Etab,
      String DateNais,
      String Cause,
      String Mail) async {
    final pdf = Document();

    MemoryImage Image = MemoryImage(
      (await rootBundle.load('img/téléchargement.png')).buffer.asUint8List(),
    );
    final customFont =
        Font.ttf(await rootBundle.load('img/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader(Image),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Paragraph(
            text: "" + TitreDossier,
            style: TextStyle(font: customFont, fontSize: 15),
          ),
          buildCustomHeadline(NomEtudiant),
          Header(
              child: Text(
            'Informations :',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: PdfColors.black,
            ),
          )),
          Paragraph(text: "Nom et Prénom :" + NomEtudiant),
          Paragraph(text: "Identifiant :" + Cin),
          Paragraph(text: "Date de naissance :" + DateNais),
          Paragraph(text: "Etablissement Universitaire :" + Etab),
          Paragraph(text: "Adresse Mail  :" + Mail),
          Paragraph(
              text: "Je demande un certificat pour ne pas bénéficier d" +
                  "'" +
                  "une subvention :" +
                  Cause),
          SizedBox(height: 5.5 * PdfPageFormat.cm),
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
        name:
            "Demande d'extraction d'un document de Non bénéficiant d’une Bourse " +
                'N° :' +
                Cin +
                '.pdf',
        pdf: pdf);
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
            text: "Copie d" +
                "'" +
                "une Fiche d" +
                "'" +
                "inscription pour l" +
                "'" +
                "année (2022/2021)."),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Bullet(
            text:
                "Copie du certificat de réussite ou de la divulgation de deux ans"),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
      ];
}

class PdfExtractionOUI {
  static Future<File> generate(
    String TitreDossier,
    String NomEtudiant,
    String Cin,
    String Etab,
    String DateNais,
    String Cause,
    String Mail,
  ) async {
    final pdf = Document();

    MemoryImage Image = MemoryImage(
      (await rootBundle.load('img/téléchargement.png')).buffer.asUint8List(),
    );
    final customFont =
        Font.ttf(await rootBundle.load('img/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader(Image),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Paragraph(
            text: "" + TitreDossier,
            style: TextStyle(font: customFont, fontSize: 15),
          ),
          buildCustomHeadline(NomEtudiant),
          Header(
              child: Text(
            'Informations :',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: PdfColors.black,
            ),
          )),
          Paragraph(text: "Nom et Prénom :" + NomEtudiant),
          Paragraph(text: "Identifiant :" + Cin),
          Paragraph(text: "Date de naissance :" + DateNais),
          Paragraph(text: "Etablissement Universitaire :" + Etab),
          Paragraph(text: "Adresse Mail  :" + Mail),
          Paragraph(
              text: "Je demande une certificat de bénéficier d" +
                  "'" +
                  "une bourse :" +
                  Cause),
          SizedBox(height: 5.5 * PdfPageFormat.cm),
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
        name:
            "Demande d'extraction d'un document de bénéficiant d’une Bourse " +
                'N° :' +
                Cin +
                '.pdf',
        pdf: pdf);
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
            text: "Copied" +
                "'" +
                "une Fiche d" +
                "'" +
                "inscription pour l" +
                "'" +
                "année (2022/2021)."),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Bullet(
            text:
                "Copie du certificat de réussite ou de la divulgation de deux ans"),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        //  Bullet(text: "Copie Fiche Résultat du  baccalauréat "),
      ];
}
