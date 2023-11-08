import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../helper/hexColors.dart';

class Reclamation extends StatefulWidget {
  const Reclamation({Key? key}) : super(key: key);

  @override
  _ReclamationState createState() => _ReclamationState();
}

class _ReclamationState extends State<StatefulWidget> {
  List<String>? CauseReclama = [
    " Probleme concernat bourse",
    " Probléme concernat Hébergelent",
    " Probléme concernat Prets",
    " Probléme concernat Aide Social",
    " Probléme concernat Foyer",
    " Autre",
  ];
  final _key13 = GlobalKey<FormState>();
  String Cause = '';

  // ignore: non_constant_identifier_names

  final FocusNode _RecFocusNode = FocusNode();
  final TextEditingController _RecTextController = TextEditingController();
  final FocusNode _DropdownButtonFormFoucusNode2 = FocusNode();

  void dispoe() {
    _RecFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: unfocus,
        child: Form(
          key: _key13,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('RÉCLAMATION'),
                centerTitle: true,
                backgroundColor: HexColor.fromHex('2F2E41'),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: w,
                          height: h * 0.2,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image:
                                AssetImage('img/undraw_Completed_re_cisp.png'),
                            fit: BoxFit.cover,
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField2(
                          focusNode: _DropdownButtonFormFoucusNode2,
                          //  value: NiveauEtude,
                          decoration: InputDecoration(
                            /*prefixIcon: Icon(
                              Icons.school,
                              color: HexColor.fromHex('01579B'),
                              size: 25,
                            ),*/

                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            filled: true,
                            fillColor: HexColor.fromHex('E6E6E6'),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint: Text(
                            "Cause",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: HexColor.fromHex('6C63FF'),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.arrow_drop_down,
                              color: HexColor.fromHex('6C63FF')),
                          items: CauseReclama!
                              .map((item2) => DropdownMenuItem<String>(
                                    value: item2,
                                    child: Text(
                                      item2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: HexColor.fromHex('6C63FF'),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (DropdownButtonFormField2validator) {
                            if (DropdownButtonFormField2validator == null) {
                              return "Veuillez selectionner le cause";
                            }
                            return null;
                          },
                          onChanged: (value2) {
                            setState(() {
                              Cause = value2.toString();
                            });
                            (term) {
                              //  FocusScope.of(context).requestFocus(_cinFocusNode);
                            };
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value2) {
                            setState(() {
                              Cause = value2.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 20,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          cursorColor: HexColor.fromHex('6C63FF'),
                          style: TextStyle(color: HexColor.fromHex('6C63FF')),
                          focusNode: _RecFocusNode,
                          controller: _RecTextController,
                          onTap: () => setState(() {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(_RecFocusNode);
                          }),
                          // ignore: non_constant_identifier_names
                          validator: Validators.compose(
                              [Validators.required('Veuillez Expliquez')]),
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: "Expliquez-vous",
                              hintText: 'Expliquez-vous',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('6C63FF')),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              fillColor: HexColor.fromHex('E6E6E6'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                  // color: HexColor.fromHex('6C63FF')
                                ),
                              )),
                          onFieldSubmitted: (term) async {
                            if (_key13.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 24.0,
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                      "Voulez-vous Envoyer Cette réclamation ?"),
                                  //  content: Text("Choose one"),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: HexColor.fromHex('2F2E41'),
                                      child: const Text("Oui",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      onPressed: () {
                                        SaveClaim(
                                            Cause,
                                            _RecTextController.text.trim(),
                                            FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString(),
                                            FirebaseAuth.instance.currentUser!
                                                .displayName
                                                .toString());
                                        _RecTextController.clear();
                                        Navigator.pop(context);
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
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key13.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 24.0,
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                      "Voulez-vous Envoyer Cette réclamation ?"),
                                  //  content: Text("Choose one"),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: HexColor.fromHex('2F2E41'),
                                      child: const Text("Oui",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      onPressed: () {
                                        SaveClaim(
                                            Cause,
                                            _RecTextController.text.trim(),
                                            FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString(),
                                            FirebaseAuth.instance.currentUser!
                                                .displayName
                                                .toString());
                                        _RecTextController.clear();
                                        Navigator.pop(context);
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
                            }
                          },
                          child: Text(
                            'Envoyer',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('FFFFFF')),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return HexColor.fromHex('2F2E41');
                                }
                                return HexColor.fromHex('6C63FF');
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }

  Future SaveClaim(
      String cause, String explication, String mail, String etudiant) async {
    final docUser = FirebaseFirestore.instance.collection('Reclamtion').doc();
    final json = {
      'mail': mail,
      'date': DateTime.now(),
      'etudiant': etudiant,
      'cause': cause,
      'explication': explication,
    };
    await docUser.set(json);
  }
}
