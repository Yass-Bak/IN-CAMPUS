import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../Services/UserDataService.dart';
import '../../helper/hexColors.dart';
import '../../models/User.dart';
import '../../widgets/reusableWidgets.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
  static String userCIN = "";
}

List<String>? Etabitems = [
  " FSEGS , Faculté des Sciences Economiques et de Gestion de Sfax",
  " FMS   , Faculté de Médecine de Sfax",
  " FDSF  , Faculté de droit de Sfax",
  " ISAMS , Institut Supérieur des Arts et Métiers de Sfax",
  " ENET'Com , Institut Supérieur d'Electronique et de Communication de Sfax",
  " ISGIS , Institut Supérieur de Gestion Industrielle de Sfax",
  " IHEC  , Institut des Hautes Etudes Commerciales de Sfax",
  " FSS   , Faculté des Sciences de Sfax",
  " ENIS  , Ecole Nationale d'Ingénieurs de Sfax",
  " ESC   , Ecole Supérieure de Commerce de Sfax",
  " ISAAS , Institut Supérieur d'Administration des Affaires de Sfax",
  " ISIMSF , Institut Supérieur d'Informatique et de Multimédia de Sfax",
  " ISMSF , Institut Supérieur de Musique de Sfax",
  " IPEIS , Institut Préparatoire aux Etudes d'Ingénieurs de Sfax",
  " ISSEPS , Institut Supérieur du Sport et de l'Education Physique de Sfax",
  " ISBS  , Institut Supérieur de Biotechnologies de Sfax",
  " FLSHS , Sfax Faculté des Lettres et Sciences Humaines de Sfax",
  " ESSTSS , Ecole Supérieure des Sciences et Techniques de la Santé de Sfax",
  " ISSI  , Institut Supérieur des Sciences infirmières de Sfax",
];

List<String>? NiveauEtuditems = [
  " 1ére année licence",
  " 2éme année licence",
  " 3éme année licence",
  " 1ére année Master",
  " 2éme année Master",
  "Doctorant",
];
TextEditingController _passwordTextController = TextEditingController();
TextEditingController _dateTextController = TextEditingController();
TextEditingController _emailTextController = TextEditingController();
TextEditingController _nomprenomTextController = TextEditingController();
TextEditingController _cinTextController = TextEditingController();
String Etabitements = '';
String NiveauEtude = '';
String Sexe = '';
String DatNaiss = '';
String Cin = "";
//**FocusNode**
final FocusNode _emailFocusNode = FocusNode();
final FocusNode _passwordFocusNode = FocusNode();
final FocusNode _nomprenomFocusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode2 = FocusNode();
final FocusNode _birthdateFocusNode = FocusNode();
final FocusNode _keyboardfocusnode = FocusNode();
final FocusNode _cinFocusNode = FocusNode();

final user = FirebaseAuth.instance.currentUser!;
var currentFocus;

class _profileState extends State<profile> {
  final _key4 = GlobalKey<FormState>();
  final _key12 = GlobalKey<FormState>();
  bool hidden_password = true;

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    final String url = user.photoURL.toString();
    final Uri _url = Uri.parse('https://www.oous.rnu.tn/oous_new/index.php');
    void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Probleme de connexion $_url';
    }

    unfocus() {
      currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    ImageProvider setBackgroundimage() {
      if (user.photoURL == null) {
        return const AssetImage("img/avatar-placeholder.jpg");
      } else {
        return NetworkImage(url);
      }
    }

    returnPage(user) {
      if (user == null) {
        return getupdatePage(context);
      } else
        return buildUser(user, context);
    }

    return SafeArea(
      child: GestureDetector(
        //  onTap: unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PROFIL'),
            centerTitle: true,
            backgroundColor: HexColor.fromHex('2F2E41'),
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
              child: FutureBuilder<Uuser?>(
                future: readUser(),
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  return returnPage(user);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getupdatePage(BuildContext context) => Form(
        key: _key12,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('img/undraw_Updated_resume_re_q1or.png'),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
              child: Align(
                alignment: Alignment.bottomLeft + const Alignment(0.2, -0.1),
                child: Text(
                  " Mettre à jour votre profil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BebasNeue-Regular',
                    color: HexColor.fromHex('2F2E41'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '' + FirebaseAuth.instance.currentUser!.displayName.toString(),
              style: TextStyle(color: HexColor.fromHex('01579B'), fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ('' + FirebaseAuth.instance.currentUser!.email.toString()),
              style: TextStyle(color: HexColor.fromHex('01579B'), fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: Text(
                'Selectionner votre Etablissement.',
                style: TextStyle(fontSize: 16, color: HexColor.fromHex('01579B'), fontStyle: FontStyle.normal),
              ),
              icon: Icon(Icons.arrow_drop_down, color: HexColor.fromHex('01579B')),
              items: Etabitems!
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
                  Etabitements = value.toString();
                });
                (term) {
                  //    _nomprenomFocusNode.unfocus();
                  //FocusScope.of(context).requestFocus(_emailFocusNode);
                };
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                setState(() {
                  Etabitements = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField2(
              focusNode: _DropdownButtonFormFoucusNode2,
              //  value: NiveauEtude,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.school,
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
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: Text(
                "Selectionner votre Niveau d'étude",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: HexColor.fromHex('01579B'), fontStyle: FontStyle.normal),
              ),
              icon: Icon(Icons.arrow_drop_down, color: HexColor.fromHex('01579B')),
              items: NiveauEtuditems!
                  .map((item2) => DropdownMenuItem<String>(
                        value: item2,
                        child: Text(
                          item2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor.fromHex('01579B'),
                          ),
                        ),
                      ))
                  .toList(),
              validator: (DropdownButtonFormField2validator) {
                if (DropdownButtonFormField2validator == null) {
                  return "Veuillez selectionner niveau d'étude";
                }
                return null;
              },
              onChanged: (value2) {
                setState(() {
                  NiveauEtude = value2.toString();
                });
                (term) {
                  FocusScope.of(context).requestFocus(_cinFocusNode);
                };
                //Do something when changing the item if you want.
              },
              onSaved: (value2) {
                setState(() {
                  NiveauEtude = value2.toString();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLength: 8,
              cursorColor: HexColor.fromHex('01579B'),
              style: TextStyle(color: HexColor.fromHex('01579B')),
              focusNode: _cinFocusNode,
              // autofocus: true,
              enabled: true,
              keyboardType: TextInputType.text,
              // keyboardAppearance: Brightness.light,
              textInputAction: TextInputAction.next,
              controller: _cinTextController,
              onTap: () => setState(() {
                //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
              }),

              validator: Validators.compose([
                Validators.required('Cin ou identifiant est requis'),
                Validators.patternString(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{2,4}(?=.*?[a-zA-Z]).{2,4}(?=.*?[0-9]).{2,4}|| ^(?=.*?[0-9]).{8}$', 'Carte CIN ou Identifiant  invalide')
                //Maroc22MA2000
              ]),

              //  autocorrect: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: HexColor.fromHex('01579B'),
                  ),
                  labelText: "CIN ou Identifiant(étrangers) ",
                  hintText: "11111111 | Maroc22MA2000'",
                  labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: HexColor.fromHex('E6E6E6'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                  )),
              onFieldSubmitted: (term) {
                _cinFocusNode.unfocus();
                //    FocusScope.of(context).requestFocus(_emailFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DateTimeField(
              cursorColor: HexColor.fromHex('01579B'),
              style: TextStyle(color: HexColor.fromHex('01579B')),
              // focusNode: _birthdateFocusNode,
              validator: (selectedDateTime) {
                if (selectedDateTime == null) {
                  return ('Veuillez saisir votre date de naissance.');
                } else {
                  final now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                  final dateSelected = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day);
                  // If the DateTime difference is negative,
                  // this indicates that the selected DateTime is in the past
                  if (dateSelected.compareTo(now) == 0) {
                    AlertDialog(
                      title: Text("Error"),
                      backgroundColor: Colors.red,
                      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    );
                    return ('Veuillez saisir votre date de naissance.');
                  } else if (!selectedDateTime.difference(DateTime.now()).isNegative) {
                    return ('Date sélectionnée dans le futur.');
                  } else if (DateTime.now().year - selectedDateTime.year < 18) {
                    return ('Veuillez saisir une date de naissance valide.');
                  }
                }
              },
              controller: _dateTextController,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 16, color: HexColor.fromHex('01579B'), fontStyle: FontStyle.normal),
                  filled: true,
                  fillColor: HexColor.fromHex('E6E6E6'),
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: HexColor.fromHex('01579B'),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Entrez votre date de naissance ",
                  labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                  )),
              format: DateFormat("yyyy-MM-dd"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
              },
              onChanged: (value) {
                setState(() {
                  DatNaiss = value.toString();
                });

                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                setState(() {
                  DatNaiss = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: CustomRadioButton(
                elevation: 0,
                absoluteZeroSpacing: true,
                unSelectedColor: HexColor.fromHex('E6E6E6'),
                unSelectedBorderColor: Colors.white,
                selectedBorderColor: HexColor.fromHex('01579B'),
                buttonLables: const [
                  'Masculin',
                  'Féminin',
                ],
                buttonValues: const [
                  "Masculin",
                  "Féminin",
                ],
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: HexColor.fromHex('01579B'),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                radioButtonValue: (value) {
                  setState(() {
                    Sexe = value.toString();
                  });
                  // print(value);
                },
                selectedColor: HexColor.fromHex('01579B'),
              ),
            ),
            signInSignUpButton(context, false, () async {
              if (_key12.currentState!.validate()) {
                try {
                  await addUserData(
                    uid: FirebaseAuth.instance.currentUser!.email.toString(),
                    //  uid: _cinTextController.text.trim(),
                  ).createUser(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    Etabitements,
                    NiveauEtude,
                    Sexe,
                    DatNaiss,
                    _cinTextController.text.trim(),
                    [],[]
                  );
                  Navigator.of(context).pushNamed('/HomeScreen');
                } on FirebaseAuthException catch (ex) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(backgroundColor: Color.fromARGB(255, 199, 56, 45), duration: Duration(seconds: 1), content: Text('Veuillez réessayer ultérieurement')));
                } finally {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  Navigator.of(context).pushNamed('/HomeScreen');
                }
                //  }
              }
            })
          ],
        ),
      );

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Stream<List<Uuser>> readusers() => FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => Uuser.fromJson(doc.data())).toList());

  Future<Uuser?> readUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      profile.userCIN = Uuser.fromJson(snapshot.data()!).Cin!;
      log(profile.userCIN);
      return Uuser.fromJson(snapshot.data()!);
    }
  }

  Widget buildUser(Uuser user, BuildContext context) => Form(
        key: _key4,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('img/undraw_Updated_resume_re_q1or.png'),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
              child: Align(
                alignment: Alignment.bottomLeft + const Alignment(0.2, -0.1),
                child: Text(
                  " Mettre à jour votre profil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BebasNeue-Regular',
                    color: HexColor.fromHex('2F2E41'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Text('${user.displayName}'),
            Text(
              '' + FirebaseAuth.instance.currentUser!.displayName.toString(),
              style: TextStyle(color: HexColor.fromHex('01579B'), fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ('${user.Cin}'),
              style: TextStyle(color: HexColor.fromHex('01579B'), fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField2(
              // value: Etabitements,
              buttonHeight: 32,
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
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: Text(
                '${user.Etablissement}',
                style: TextStyle(fontSize: 16, color: HexColor.fromHex('01579B'), fontStyle: FontStyle.normal),
              ),
              icon: Icon(Icons.arrow_drop_down, color: HexColor.fromHex('01579B')),
              items: Etabitems!
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
                  if (value != null) {
                    Etabitements = value.toString();
                  } else {
                    Etabitements = '${user.Etablissement}';
                  }
                });
                (term) {
                  //    _nomprenomFocusNode.unfocus();
                  //FocusScope.of(context).requestFocus(_emailFocusNode);
                };
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                setState(() {
                  if (value != null) {
                    Etabitements = value.toString();
                  } else {
                    Etabitements = '${user.Etablissement}';
                  }
                });
              },
            ),
            //         Text('${user.Etablissement}'),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField2(
              focusNode: _DropdownButtonFormFoucusNode2,
              //        value: NiveauEtude,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.school,
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
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: Text(
                '${user.NiveauEtude}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: HexColor.fromHex('01579B'), fontStyle: FontStyle.normal),
              ),
              icon: Icon(Icons.arrow_drop_down, color: HexColor.fromHex('01579B')),
              items: NiveauEtuditems!
                  .map((item2) => DropdownMenuItem<String>(
                        value: item2,
                        child: Text(
                          item2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor.fromHex('01579B'),
                          ),
                        ),
                      ))
                  .toList(),
              validator: (DropdownButtonFormField2validator) {
                if (DropdownButtonFormField2validator == null) {
                  return "Veuillez selectionner niveau d'étude";
                }
                return null;
              },
              onChanged: (value2) {
                setState(() {
                  if (value2 != null) {
                    Etabitements = value2.toString();
                  } else {
                    Etabitements = '${user.NiveauEtude}';
                  }
                });
                (term) {
                  FocusScope.of(context).requestFocus(_cinFocusNode);
                };
                //Do something when changing the item if you want.
              },
              onSaved: (value2) {
                setState(() {
                  if (value2 != null) {
                    Etabitements = value2.toString();
                  } else {
                    Etabitements = '${user.NiveauEtude}';
                  }
                });
              },
            ),
            //      Text('${user.NiveauEtude}'),
            const SizedBox(
              height: 20,
            ),
            //        Text('${user.Sexe}'),
            //   Text('${user.dateNais}'),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              /*  inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")),
                                    ],*/
              enabled: true,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocusNode,
              controller: _emailTextController,
              cursorColor: HexColor.fromHex('01579B'),
              style: TextStyle(color: HexColor.fromHex('01579B')),
              onTap: () => setState(() {}),
              // keyboardType: TextInputType.emailAddress,
              validator: Validators.compose([Validators.email('adresse email non valide'), Validators.required('Mail est requis')]),
              autocorrect: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: HexColor.fromHex('01579B'),
                  ),
                  labelText: '' + FirebaseAuth.instance.currentUser!.email.toString(),
                  hintText: 'example@domain.com',
                  labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: HexColor.fromHex('E6E6E6'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                  )),
              onFieldSubmitted: (term) {
                _emailFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),

            //Text('${user.Cin}'),

            TextFormField(
              enabled: true,
              cursorColor: HexColor.fromHex('01579B'),
              style: TextStyle(color: HexColor.fromHex('01579B')),
              focusNode: _passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              /*  inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$')),
                                    ],*/
              onFieldSubmitted: (term) {
                _passwordFocusNode.unfocus();
                //        FocusScope.of(context).requestFocus(_birthdateFocusNode);
              },
              controller: _passwordTextController,
              obscureText: hidden_password,
              onTap: () => setState(() {}),
              validator: Validators.compose([
                Validators.required('mot de passe est requis'),
                Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Mot de passe invalide ')
                /*
                          Vignesh123! : true
                          Yassine123/: true
                          Yassine123@: true
                          Yassine123#: true
                          Yassine123!: true
                          Yassine123?: true
                          Yassine123=: true
                          Yassine123\: true
                          Yassine123~: true
                          Yassine123.: true
                          Yassine123& : true
                          vignesh123 : false
                          VIGNESH123! : false
                          vignesh@ : false
                          12345678? : false*/
              ]),
              /* (Passvalidate) {
                                      if (Passvalidate!.isEmpty) {
                                        return 'Veuillez saisir un mot de passe';
                                      } else if (Passvalidate.length < 8) {
                                        return 'Le mot de passe doit compter au moins 8 caractères';
                                      } else if (Passvalidate.length > 32) {
                                        return 'Le mot de passe doit compter maximum 32 caractères';
                                      }
                                      return null;
                                    },*/
              autocorrect: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility, color: HexColor.fromHex('01579B')),
                    onPressed: () => setState(() {
                      hidden_password = !hidden_password;
                    }),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: HexColor.fromHex('01579B'),
                  ),
                  labelText: 'Mot de passe',
                  hintText: 'Exemple : Vignesh123! ',
                  labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: HexColor.fromHex('E6E6E6'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  final String Etabitementuser = '${user.Etablissement}';
                  final String NiveauEtudeuser = '${user.NiveauEtude}';
                  //   this.CIN = user.Cin;
                  if (_passwordTextController.text != '' && _emailTextController.text != '' && Etabitements != '' && NiveauEtude != '') {
                    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({
                      'Etablissement': Etabitements,
                      'NiveauEtude': NiveauEtude,
                    });
                    FirebaseAuth.instance.currentUser!.updateEmail(_emailTextController.text.trim());
                    FirebaseAuth.instance.currentUser!.updatePassword(_passwordTextController.text.trim());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text == '' && _emailTextController.text == '' && Etabitements != '' && NiveauEtude != '') {
                    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({
                      'Etablissement': Etabitements,
                      'NiveauEtude': NiveauEtude,
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text != '' && _emailTextController.text != '' && Etabitements == '' && NiveauEtude == '') {
                    FirebaseAuth.instance.currentUser!.updateEmail(_emailTextController.text.trim());
                    FirebaseAuth.instance.currentUser!.updatePassword(_passwordTextController.text.trim());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text != '' && _emailTextController.text == '' && Etabitements == '' && NiveauEtude == '') {
                    FirebaseAuth.instance.currentUser!.updatePassword(_passwordTextController.text.trim());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text == '' && _emailTextController.text != '' && Etabitements == '' && NiveauEtude == '') {
                    FirebaseAuth.instance.currentUser!.updateEmail(_emailTextController.text.trim());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text == '' && _emailTextController.text == '' && Etabitements != '' && NiveauEtude == '') {
                    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({
                      'Etablissement': Etabitements,
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text == '' && _emailTextController.text == '' && Etabitements == '' && NiveauEtude != '') {
                    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({
                      'NiveauEtude': NiveauEtude,
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('profil mis à jour avec succès')));
                  } else if (_passwordTextController.text == '' && _emailTextController.text == '' && Etabitements == '' && NiveauEtude == '') {
                    /*  setState(() {
                      Cin = user.Cin;
                      Globals.changeCin(Cin);
                      print(user.Cin);
                    });*/
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Color.fromARGB(255, 199, 56, 45), duration: Duration(seconds: 1), content: Text('Veuillez modifier au moins une information ')));
                  }
                },
                child: Text(
                  'sauvegarder',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: HexColor.fromHex('01579B')),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return HexColor.fromHex('FFFFFF');
                      }
                      return HexColor.fromHex('FFD15B');
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    elevation: 24.0,
                    backgroundColor: Colors.white,
                    title: const Text("Voulez-vous supprimer cette compte ?"),
                    //  content: Text("Choose one"),
                    actions: <Widget>[
                      FlatButton(
                        color: HexColor.fromHex('2F2E41'),
                        child: const Text("Oui",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!.delete();
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).delete();

                          /*  docUser.update({
                            'displayName': FieldValue.delete(),
                            'Etablissement': FieldValue.delete(),
                            'NiveauEtude': FieldValue.delete(),
                            'Sexe': FieldValue.delete(),
                            'dateNais': FieldValue.delete(),
                            'Cin': FieldValue.delete(),
                          });*/
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
              child: const Text(
                'Supprimer compte',
                style: TextStyle(color: Color.fromARGB(255, 159, 14, 11), fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //         FirebaseAuth.instance.currentUser.updateEmail(newEmail)
          ],
        ),
      );
}
