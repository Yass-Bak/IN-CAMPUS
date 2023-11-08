import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/pages/login/resetPassword.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../Services/API_google_Sign_Service.dart';
import '../../helper/hexColors.dart';
import '../../models/User.dart';
import '../../widgets/reusableWidgets.dart';
import '../home/HomeScreen.dart';
import '../login/creeCompte.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<StatefulWidget> {
  final _key1 = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  bool hidden_password = true;
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  TextEditingController get passwordTextController {
    return _passwordTextController;
  }

  TextEditingController get emailTextController {
    return _emailTextController;
  }

  void dispoe() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    var currentFocus;
    unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(' un problème survenu',
                style: TextStyle(
                  color: Color.fromARGB(255, 103, 17, 11),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          );
        } else {
          return SafeArea(
            child: GestureDetector(
              onTap: unfocus,
              child: Form(
                key: _key1,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: w,
                                height: h * 0.3,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'img/undraw_Ask_me_anything_re_x7pm.png'),
                                  fit: BoxFit.cover,
                                )),
                                child: Align(
                                    alignment: Alignment.topLeft +
                                        const Alignment(0.0, 0.1),
                                    child: new CircleAvatar(
                                      backgroundImage: new AssetImage(
                                          'img/téléchargement.png'),
                                      radius: 20.0,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "IN-CAMPUS",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('2F2E41'),
                                ),
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
                                style: TextStyle(
                                    color: HexColor.fromHex('01579B')),
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
                                    labelStyle: TextStyle(
                                        color: HexColor.fromHex('01579B')),
                                    filled: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: HexColor.fromHex('01579B'),
                                style: TextStyle(
                                    color: HexColor.fromHex('01579B')),
                                focusNode: _passwordFocusNode,
                                controller: _passwordTextController,
                                obscureText: hidden_password,
                                onTap: () => setState(() {
                                  FocusScope.of(context).unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                }),
                                // ignore: non_constant_identifier_names
                                validator: Validators.compose([
                                  Validators.required(
                                      'mot de passe est requis'),
                                  /*   Validators.patternString(
                                      r'^(?=.*?[a-zA-Z])(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                      'Mot de passe invalide ')*/
                                ]),
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
                                    hintText: 'Mot de passe',
                                    labelStyle: TextStyle(
                                        color: HexColor.fromHex('01579B')),
                                    filled: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: HexColor.fromHex('E6E6E6'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none),
                                    )),
                                onFieldSubmitted: (term) async {
                                  if (_key1.currentState!.validate()) {
                                    try {
                                      UserCredential user = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: _emailTextController.text
                                                  .trim(),
                                              password: _passwordTextController
                                                  .text
                                                  .trim());
                                      final docUser = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.user!.uid);
                                      final snapshot = await docUser.get();
                                      if (snapshot.exists) {
                                        MyApp.uuser!.dateNais =
                                            Uuser.fromJson(snapshot.data()!)
                                                .dateNais!;
                                        MyApp.uuser!.Etablissement =
                                            Uuser.fromJson(snapshot.data()!)
                                                .Etablissement!;
                                        MyApp.uuser!.Cin =
                                            Uuser.fromJson(snapshot.data()!)
                                                .Cin!;
                                        MyApp.cin =
                                            Uuser.fromJson(snapshot.data()!)
                                                .Cin!;
                                        log("********CIN**********");
                                        log(MyApp.uuser!.Cin!);
                                        print('Voila YUPPPI' +
                                            MyApp.uuser!.Cin! +
                                            MyApp.uuser!.dateNais! +
                                            MyApp.uuser!.Etablissement! +
                                            'Voila  YUPPPI');
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  HexColor.fromHex('2F88FF'),
                                              duration: Duration(seconds: 1),
                                              content:
                                                  Text('Connexion établie')));
                                      Navigator.of(context)
                                          .pushNamed('/HomeScreen');
                                    } on FirebaseAuthException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 199, 56, 45),
                                              duration: Duration(seconds: 1),
                                              content: Text(
                                                  'une erreur est survenue veuillez réessayer')));
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  child: Text('Réinitialiser mot de passe',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: HexColor.fromHex('01579B'))),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                resetPassword()));
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  child: Text('Crée Une Compte',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: HexColor.fromHex('01579B'))),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreeCompte()));
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 40,
                                width: 200,
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                        child: Image.asset(
                                            "img/icons8-gmail-48.png",
                                            height: 40,
                                            width: 40),
                                        onTap: () async {
                                          final provider =
                                              Provider.of<GoogleSignInProvider>(
                                                  context,
                                                  listen: false);
                                          provider.googleLogin();
                                          final googleUser =
                                              await provider.user;
                                          final docUser = FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(googleUser.email);
                                          print("++++++++++++++++++++++" +
                                              googleUser.email +
                                              "++++++++++++++++++++++");
                                          final snapshot = await docUser.get();

                                          setState(() {
                                            MyApp.uuser!.Cin =
                                                Uuser.fromJson(snapshot.data()!)
                                                    .Cin!;
                                            print(MyApp.uuser!.Cin! + 'done!!');
                                          });
                                          log(MyApp.uuser!.Cin! + 'done');
                                        }),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    InkWell(
                                        child: Image.asset(
                                            "img/icons8-microsoft-48.png",
                                            height: 40,
                                            width: 40),
                                        onTap: () {}),
                                  ],
                                ),
                              ),
                              signInSignUpButton(context, true, () async {
                                if (_key1.currentState!.validate()) {
                                  try {
                                    UserCredential user = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: _emailTextController.text
                                                .trim(),
                                            password: _passwordTextController
                                                .text
                                                .trim());
                                    final docUser = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.user!.uid);
                                    final snapshot = await docUser.get();
                                    if (snapshot.exists) {
                                      MyApp.uuser!.dateNais =
                                          Uuser.fromJson(snapshot.data()!)
                                              .dateNais!;
                                      MyApp.uuser!.Etablissement =
                                          Uuser.fromJson(snapshot.data()!)
                                              .Etablissement!;
                                      MyApp.uuser!.Cin =
                                          Uuser.fromJson(snapshot.data()!).Cin!;
                                      MyApp.cin =
                                          Uuser.fromJson(snapshot.data()!).Cin!;
                                      log("********CIN**********");
                                      log(MyApp.uuser!.Cin!);
                                      print('Voila YUPPPI' +
                                          MyApp.uuser!.Cin! +
                                          MyApp.uuser!.dateNais! +
                                          MyApp.uuser!.Etablissement! +
                                          'Voila  YUPPPI');
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                HexColor.fromHex('2F88FF'),
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Connexion établie')));
                                    Navigator.of(context)
                                        .pushNamed('/HomeScreen');
                                  } on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Color.fromARGB(
                                                255, 199, 56, 45),
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                'une erreur est survenue veuillez réessayer')));
                                  }
                                }
                              })
                            ],
                          ),
                        ))),
              ),
            ),
          );
          ;
        }
      },
    );
  }
}
