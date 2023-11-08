import 'dart:developer';
import 'dart:io';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_campus/Services/UserDataService.dart';
import 'package:in_campus/widgets/reusableWidgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../helper/hexColors.dart';

class CreeCompte extends StatefulWidget {
  const CreeCompte({Key? key}) : super(key: key);

  @override
  _CreeCompte createState() => _CreeCompte();
}

TextEditingController _passwordTextController = TextEditingController();
TextEditingController _dateTextController = TextEditingController();
TextEditingController _emailTextController = TextEditingController();
TextEditingController _nomprenomTextController = TextEditingController();
TextEditingController _cinTextController = TextEditingController();
String Etabitements = '';
String NiveauEtude = '';
String Sexe = '';
String DatNaiss = '';
//**FocusNode**
final FocusNode _emailFocusNode = FocusNode();
final FocusNode _passwordFocusNode = FocusNode();
final FocusNode _nomprenomFocusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode2 = FocusNode();
final FocusNode _birthdateFocusNode = FocusNode();
final FocusNode _keyboardfocusnode = FocusNode();
final FocusNode _cinFocusNode = FocusNode();

final scaffoldKey = GlobalKey<ScaffoldState>();

var currentFocus;
const IconData school = IconData(0xe559, fontFamily: 'MaterialIcons');

class _CreeCompte extends State<CreeCompte> {
  File? image;
  bool hidden_password = true;
  final _key2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable

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

    unfocus() {
      currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    initState() async {
      final _formkey = GlobalKey<FormState>();
      final scaffoldKey = GlobalKey<ScaffoldState>();
      bool hiddenPassword = true;
      super.initState();
    }

    void dispoe() {
      _passwordFocusNode.dispose();
      _emailFocusNode.dispose();
      _nomprenomFocusNode.dispose();
      _birthdateFocusNode.dispose();
      _nomprenomTextController.dispose();
      _emailTextController.dispose();
      _dateTextController.dispose();
      _passwordTextController.dispose();
      _nomprenomFocusNode.dispose();
      super.dispose();
    }

    DateTime selection = DateTime.now();

    return SafeArea(
      top: true,
      child: GestureDetector(
        onTap: unfocus,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                child: Form(
                  key: _key2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: w,
                        height: h * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image:
                              const AssetImage('img/undraw_details_8k13.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        )),
                        child: Text(
                          "Crée votre compte",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'BebasNeue-Regular',
                            color: HexColor.fromHex('2F2E41'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileImage(context),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: HexColor.fromHex('01579B'),
                        style: TextStyle(color: HexColor.fromHex('01579B')),
                        focusNode: _nomprenomFocusNode,
                        //autofocus: true,
                        enabled: true,
                        keyboardType: TextInputType.name,
                        // keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        controller: _nomprenomTextController,
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
                            labelText: 'Nom Prénom',
                            hintText: 'Nom Prénom',
                            labelStyle:
                                TextStyle(color: HexColor.fromHex('01579B')),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: HexColor.fromHex('E6E6E6'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            )),
                        onFieldSubmitted: (term) {
                          _nomprenomFocusNode.unfocus();
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
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        hint: Text(
                          'Selectionner votre Etablissement.',
                          style: TextStyle(
                              fontSize: 16,
                              color: HexColor.fromHex('01579B'),
                              fontStyle: FontStyle.normal),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: HexColor.fromHex('01579B')),
                        items: Etabitems.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor.fromHex('01579B'),
                                ),
                              ),
                            )).toList(),
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
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        hint: Text(
                          "Selectionner votre Niveau d'étude",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: HexColor.fromHex('01579B'),
                              fontStyle: FontStyle.normal),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: HexColor.fromHex('01579B')),
                        items: NiveauEtuditems.map(
                            (item2) => DropdownMenuItem<String>(
                                  value: item2,
                                  child: Text(
                                    item2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor.fromHex('01579B'),
                                    ),
                                  ),
                                )).toList(),
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
                        //maxLength: 8,
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
                          Validators.patternString(
                              r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{2,4}(?=.*?[a-zA-Z]).{2,4}(?=.*?[0-9]).{2,4}|| ^(?=.*?[0-9]).{8}$',
                              'Carte CIN ou Identifiant  invalide')
                          //Maroc22MA2000
                        ]),

                        //  autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box,
                              color: HexColor.fromHex('01579B'),
                            ),
                            labelText: "CIN ou Identifiant(étrangers) ",
                            hintText: "********",
                            labelStyle:
                                TextStyle(color: HexColor.fromHex('01579B')),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: HexColor.fromHex('E6E6E6'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            )),
                        onFieldSubmitted: (term) {
                          _cinFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                        validator: Validators.compose([
                          Validators.email('adresse email non valide'),
                          Validators.required('Mail est requis')
                        ]),
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: HexColor.fromHex('01579B'),
                            ),
                            labelText: 'Email',
                            hintText: 'example@domain.com',
                            labelStyle:
                                TextStyle(color: HexColor.fromHex('01579B')),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: HexColor.fromHex('E6E6E6'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            )),
                        onFieldSubmitted: (term) {
                          _emailFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                          Validators.patternString(
                              r'^(?=.*?[a-zA-Z])(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              'Mot de passe invalide ')
                        ]),
                        /*
                          Vignesh123! : true
                          Yassine123[!@#\$&*~]: true
                          vignesh123 : false
                          VIGNESH123! : false
                          vignesh@ : false
                          12345678? : false*/
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
                              icon: Icon(Icons.visibility,
                                  color: HexColor.fromHex('01579B')),
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
                            labelStyle:
                                TextStyle(color: HexColor.fromHex('01579B')),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: HexColor.fromHex('E6E6E6'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DateTimeField(
                        cursorColor: HexColor.fromHex('01579B'),
                        style: TextStyle(color: HexColor.fromHex('01579B')),
                        // focusNode: _birthdateFocusNode,
                        // ignore: body_might_complete_normally_nullable
                        validator: (selectedDateTime) {
                          if (selectedDateTime == null) {
                            return ('Veuillez saisir votre date de naissance.');
                          } else {
                            final now = DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day);
                            final dateSelected = DateTime(selectedDateTime.year,
                                selectedDateTime.month, selectedDateTime.day);
                            // If the DateTime difference is negative,
                            // this indicates that the selected DateTime is in the past
                            if (dateSelected.compareTo(now) == 0) {
                              AlertDialog(
                                title: Text("Error"),
                                backgroundColor: Colors.red,
                                titleTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                              return ('Veuillez saisir votre date de naissance.');
                            } else if (!selectedDateTime
                                .difference(DateTime.now())
                                .isNegative) {
                              return ('Date sélectionnée dans le futur.');
                            } else if (DateTime.now().year -
                                    selectedDateTime.year <
                                18) {
                              return ('Veuillez saisir une date de naissance valide.');
                            }
                          }
                        },
                        controller: _dateTextController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: HexColor.fromHex('01579B'),
                                fontStyle: FontStyle.normal),
                            filled: true,
                            fillColor: HexColor.fromHex('E6E6E6'),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: HexColor.fromHex('01579B'),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Entrez votre date de naissance ",
                            labelStyle:
                                TextStyle(color: HexColor.fromHex('01579B')),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            )),
                        format: DateFormat("yyyy-MM-dd"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
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
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
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
                        if (_key2.currentState!.validate()) {
                          try {
                            UserCredential user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email:
                                        _emailTextController.value.text.trim(),
                                    password: _passwordTextController.value.text
                                        .trim());
                            User? updateUser =
                                FirebaseAuth.instance.currentUser;
                            updateUser?.updateProfile(
                                displayName: _nomprenomTextController.text,
                                photoURL: image!.path);
                            await addUserData(
                                    uid: FirebaseAuth.instance.currentUser!.uid
                                    //  uid: _cinTextController.text.trim(),
                                    )
                                .createUser(
                                    _nomprenomTextController.text.trim(),
                                    Etabitements,
                                    NiveauEtude,
                                    Sexe,
                                    DatNaiss,
                                    _cinTextController.text.trim(), [], []);
                            Navigator.of(context).pushNamed('/HomeScreen');
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == "weak-password") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 199, 56, 45),
                                      duration: Duration(seconds: 1),
                                      content: Text('mot de passe faible')));
                            } else if (ex.code == "email-already-in-use") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 199, 56, 45),
                                      duration: Duration(seconds: 1),
                                      content: Text('e-mail déjà utilisé')));
                            }
                          } finally {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: HexColor.fromHex('2F88FF'),
                                duration: Duration(seconds: 1),
                                content: Text('compte crée avec succès')));
                            Navigator.of(context).pushNamed('/HomeScreen');
                          }
                          //  }
                        }
                      })
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    return HexColor.fromHex('01579B');
  }

  Future pickImage(BuildContext context, ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source)
          .then((value) => setState(() => this.image = File(value!.path)));
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('faild to pick image ya looo :$e');
    }
  }

  Future<File> saveImage(String imagePath) async {
    final Directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    image = File('${Directory.path}/$name');
    return File(imagePath).copy(imagePath);
  }

  Widget ProfileImage(BuildContext context) {
    log("************image****************");
    log(image.toString());
    return Center(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: this.context,
                  builder: ((builder) => bottomSheet(context)));
            },
            child: CircleAvatar(
              radius: 53,
              backgroundImage: image == null
                  ? const AssetImage("img/avatar-placeholder.jpg")
                  : FileImage(image!) as ImageProvider,
            ),
          ),
          Positioned(
              bottom: -1.0,
              right: 1.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: this.context,
                      builder: ((builder) => bottomSheet(context)));
                },
                child: Icon(
                  Icons.camera,
                  color: HexColor.fromHex('01579B'),
                  size: 35.0,
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(this.context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Choisir votre photo de profile",
              style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
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
                  onPressed: () {
                    pickImage(context, ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    color: HexColor.fromHex('01579B'),
                  ),
                  label: Text(
                    "Camera",
                    style: TextStyle(color: HexColor.fromHex('01579B')),
                  )),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              ElevatedButton.icon(
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
                  onPressed: () {
                    pickImage(context, ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: HexColor.fromHex('01579B'),
                  ),
                  label: Text(
                    "Gallerie",
                    style: TextStyle(color: HexColor.fromHex('01579B')),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
