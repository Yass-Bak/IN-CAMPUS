// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../helper/hexColors.dart';

class resetPassword extends StatefulWidget {
  resetPassword({Key? key}) : super(key: key);

  @override
  _resetPassword createState() => _resetPassword();
}

TextEditingController _emailTextController = TextEditingController();
var currentFocus;
final FocusNode _emailFocusNode = FocusNode();

initState() async {
  final _formmkey = GlobalKey<FormState>();
}

class _resetPassword extends State<resetPassword> {
  final GlobalKey<FormState> _key = GlobalKey();

  void dispoe() {
    _emailTextController.dispose();
    super.dispose();
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
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: w,
                      height: h * 0.3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('img/undraw_Forgot_password_re_hxwm (2).png'),
                        fit: BoxFit.cover,
                      )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Réinitialiser le mot de passe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        // fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('01579B'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _key,
                      child: TextFormField(
                        //  autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        /*  inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(
                                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")),
                                        ],*/
                        enabled: true,
                        textInputAction: TextInputAction.next,
                        //  focusNode: _emailFocusNode,
                        controller: _emailTextController,
                        cursorColor: HexColor.fromHex('01579B'),
                        style: TextStyle(color: HexColor.fromHex('01579B')),
                        onTap: () => setState(() {}),
                        // keyboardType: TextInputType.emailAddress,
                        validator: Validators.compose([Validators.email('Adresse email non valide'), Validators.required('Mail est requis')]),
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: HexColor.fromHex('01579B'),
                            ),
                            labelText: 'Email',
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
                          if (_key.currentState!.validate()) {
                            resetPassword();
                            _emailTextController.clear();
                          }
                          // _emailFocusNode.unfocus();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          resetPassword();
                          _emailTextController.clear();
                        }
                      },
                      child: Text(
                        'Envoyer email',
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
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(context: context, barrierDismissible: false, builder: (Context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: HexColor.fromHex('2F88FF'), duration: Duration(seconds: 1), content: Text('Mail envoyé')));
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushNamed('/');
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(backgroundColor: Color.fromARGB(255, 199, 56, 45), duration: Duration(seconds: 1), content: Text('un problème survenu')));
      Navigator.of(context).pop();
      print(e);
    }
  }
}
