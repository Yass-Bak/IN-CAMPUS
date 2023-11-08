import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_campus/Pages/login/login_page.dart';
import 'package:in_campus/PdfGenerator/Extractionpdfgenerate.dart';
import 'package:in_campus/helper/hexColors.dart';
import 'package:flutter/services.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/main.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../Services/Pdf_Api_Service.dart';
import '../../Services/UploadFileService.dart';

class DemandeExtractionCerfiff extends StatefulWidget {
  const DemandeExtractionCerfiff({Key? key}) : super(key: key);

  @override
  State<DemandeExtractionCerfiff> createState() =>
      _DemandeExtractionCerfiffState();
}

TextEditingController _NameTextController = TextEditingController();
final FocusNode _NameFocusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode = FocusNode();
String Rais = "";
List<String>? Raison = [
  "A consulter par un Opérateur",
  "Pour obtenir la pension d'orphelin",
  " pour obtenir une subvention",
  "Pour obtenir une bourse de recherche ou d'échange",
  "Pour obtenir un contrat de travail",
];

class _DemandeExtractionCerfiffState extends State<DemandeExtractionCerfiff> {
  final _key19 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('CREÉ UNE DEMANDE'),
        centerTitle: true,
        backgroundColor: HexColor.fromHex('2F2E41'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
          child: Form(
            key: _key19,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: h * 0.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: const AssetImage('img/undraw_Upload_re_pasx.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 248, 246, 246).withOpacity(0.5),
                      BlendMode.dstATop),
                )),
                child: Text(
                  "Demande Extraction doucument",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BebasNeue-Regular',
                    color: HexColor.fromHex('2F2E41'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: HexColor.fromHex('01579B'),
                style: TextStyle(color: HexColor.fromHex('01579B')),
                focusNode: _NameFocusNode,
                //autofocus: true,
                enabled: true,
                keyboardType: TextInputType.name,
                // keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.next,
                controller: _NameTextController,
                onTap: () => setState(() {
                  //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                }),

                validator: Validators.compose([
                  Validators.required(' Nom et Prénom est requis'),
                  // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                ]),
                //  autocorrect: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.group,
                      color: HexColor.fromHex('01579B'),
                    ),
                    labelText: 'Nom Prénom | الإسم و اللقب',
                    hintText: 'Nom Prénom | الإسم و اللقب',
                    labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: HexColor.fromHex('E6E6E6'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    )),
                onFieldSubmitted: (term) {
                  _NameFocusNode.unfocus();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField2(
                // value: Etabitements,
                buttonHeight: 30,
                focusNode: _DropdownButtonFormFoucusNode,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_balance_outlined,
                    color: HexColor.fromHex('01579B'),
                    size: 25,
                  ),

                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  filled: true,
                  fillColor: HexColor.fromHex('E6E6E6'),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: Text(
                  'Objet du certif | الغرض من الشهادة',
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor.fromHex('01579B'),
                      fontStyle: FontStyle.normal),
                ),
                icon: Icon(Icons.arrow_drop_down,
                    color: HexColor.fromHex('01579B')),
                items: Raison!
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: HexColor.fromHex('01579B'),
                            ),
                          ),
                        ))
                    .toList(),
                validator: (DropdownButtonFormField2validator) {
                  if (DropdownButtonFormField2validator == null) {
                    return 'Veuillez selectionner votre Etablissement.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    Rais = value.toString();
                  });
                  (term) {
                    //    _nomprenomFocusNode.unfocus();
                    //FocusScope.of(context).requestFocus(_emailFocusNode);
                  };
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  setState(() {
                    Rais = value.toString();
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 160,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_key19.currentState!.validate()) {
                      log(MyApp.cin.toString() +
                          "--" +
                          MyApp.uuser!.dateNais!.substring(0, 10) +
                          "--" +
                          MyApp.uuser!.Etablissement!.toString());
                      final pdfFile = await PdfExtractionOUI.generate(
                        "Demande d'extraction d'un document de bénéficiant d’une Bourse ",
                        _NameTextController.text.trim(),
                        MyApp.cin.toString(),
                        MyApp.uuser!.Etablissement!.toString(),
                        MyApp.uuser!.dateNais!.substring(0, 11).toString(),
                        Rais.toString(),
                        FirebaseAuth.instance.currentUser!.email.toString(),
                      );

                      uploadDemandeExtarction(pdfFile);
                      PdfApi.openFile(pdfFile);
                    }
                  },
                  child: Text(
                    'Valider',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor.fromHex('01579B')),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return HexColor.fromHex('FFFFFF');
                        }
                        return HexColor.fromHex('FFD15B');
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Future uploadDemandeExtarction(File file) async {
    if (file == null) return;

    final fileName = (MyApp.cin +
        file.path
            .substring(file.path.indexOf('app_flutter/'))
            .replaceAll('app_flutter', ""));
    final destination = '/DemandeExtarction/Certificat deGrant/$fileName';
    FirebaseApi.uploadDemande(destination, file);
  }
}
