import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_campus/Pages/home/HomeScreen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../helper/hexColors.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<StatefulWidget> {
  final _key20 = GlobalKey<FormState>();
  String Cause = '';

  // ignore: non_constant_identifier_names

  final FocusNode _postFocusNode = FocusNode();
  final TextEditingController _RecTextController = TextEditingController();
  final FocusNode _DropdownButtonFormFoucusNode2 = FocusNode();

  void dispoe() {
    _postFocusNode.dispose();
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
          key: _key20,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('PUBLIER'),
                centerTitle: true,
                backgroundColor: HexColor.fromHex('2F2E41'),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, h * 0.0, 10, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: w,
                          height: h * 0.2,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('img/undraw_Post_re_mtr4.png'),
                            fit: BoxFit.cover,
                          )),
                          child: Align(
                            alignment: Alignment.centerRight +
                                const Alignment(-0.2, -0.9),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_key20.currentState!.validate()) {
                                  SavePost(_RecTextController.text.trim());
                                  _RecTextController.clear();
                                  CoolAlert.show(
                                    onConfirmBtnTap: () => Navigator.of(context)
                                        .push(new MaterialPageRoute(
                                            builder: (_) => (HomeScreen()))),
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: 'Votre publication a été partagée',
                                    autoCloseDuration: Duration(seconds: 15),
                                  );
                                }
                              },
                              child: Text(
                                'Publier',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex('2F2E41')),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return HexColor.fromHex('2F2E41');
                                    }
                                    return HexColor.fromHex('FFD15B');
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 20,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          cursorColor: HexColor.fromHex('2F2E41'),
                          style: TextStyle(color: HexColor.fromHex('2F2E41')),
                          focusNode: _postFocusNode,
                          controller: _RecTextController,
                          onTap: () => setState(() {
                            //   FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(_postFocusNode);
                          }),
                          // ignore: non_constant_identifier_names
                          validator:
                              Validators.compose([Validators.required('Vide')]),
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: "Quoi de neuf , " +
                                  FirebaseAuth.instance.currentUser!.displayName
                                      .toString(),
                              hintText: 'Expliquez-vous',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('2F2E41')),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              fillColor: HexColor.fromHex('E6E6E6'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                  // color: HexColor.fromHex('6C63FF')
                                ),
                              )),
                          onFieldSubmitted: (term) {
                            _postFocusNode.unfocus();
                          },
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

  Future SavePost(
    String Contenu,
  ) async {
    final docUser = FirebaseFirestore.instance.collection('posts').doc();
    final json = {
      'Contenu': Contenu,
      'Created_at': DateTime.now().toString().substring(0, 10),
      'Created_by': FirebaseAuth.instance.currentUser!.displayName.toString(),
    };
    await docUser.set(json);
  }
}
