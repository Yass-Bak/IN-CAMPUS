import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:in_campus/main.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:intl/intl.dart';
import '../../helper/hexColors.dart';
import '../../PdfGenerator/GeneratePDF(Etaranger).dart';
import '../../PdfGenerator/GeneratePDF(Locaux).dart';
import '../../Services/Pdf_Api_Service.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Services/UploadFileService.dart';
import '../login/login_page.dart';

class CerationDemandePrets extends StatefulWidget {
  const CerationDemandePrets({Key? key}) : super(key: key);

  @override
  static String CINDemP = "";
  State<CerationDemandePrets> createState() => _CerationDemandePretsState();
}

TextEditingController _passwordTextController = TextEditingController();
TextEditingController _dateTextController = TextEditingController();
TextEditingController _emailTextController = TextEditingController();
TextEditingController _nomprenomTextController = TextEditingController();
TextEditingController _cinTextController = TextEditingController();
TextEditingController _adresseTextController = TextEditingController();
TextEditingController _numerotlfTextController = TextEditingController();
TextEditingController _ResultatTextController = TextEditingController();
TextEditingController _LieudenaissanceTextController = TextEditingController();
TextEditingController _PassportTextController = TextEditingController();
TextEditingController _NationaliteTextController = TextEditingController();
String Etabitements = '';
String NiveauEtude = '';
String DatNaiss = '';
String Typebac = "";
//**FocusNode**
final FocusNode _emailFocusNode = FocusNode();
final FocusNode _passwordFocusNode = FocusNode();
final FocusNode _nomprenomFocusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode = FocusNode();
final FocusNode _DropdownButtonFormFoucusNode2 = FocusNode();
final FocusNode _birthdateFocusNode = FocusNode();
final FocusNode _keyboardfocusnode = FocusNode();
final FocusNode _cinFocusNode = FocusNode();
final FocusNode _adresseFocusNode = FocusNode();
final FocusNode _numerotlfFocusNode = FocusNode();
final FocusNode _ResultatFocusNode = FocusNode();
final FocusNode _LieudenaissanceFocusNode = FocusNode();
final FocusNode _PassportFocusNode = FocusNode();
final FocusNode _NationaliteFocusNode = FocusNode();

var currentFocus;
const IconData school = IconData(0xe559, fontFamily: 'MaterialIcons');

class _CerationDemandePretsState extends State<CerationDemandePrets> {
  final _key11 = GlobalKey<FormState>();
  final _key12 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
    List<String>? Bac = [
      " Mathématiques",
      " Sciences expérimentales",
      " Économie et gestion",
      " Sciences techniques",
      " Lettres",
      "Sport",
      "Sciences de l'informatique",
    ];
    unfocus() {
      currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    initState() async {
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
      _PassportFocusNode.dispose();
      _PassportTextController.dispose();
      _LieudenaissanceTextController.dispose();
      _LieudenaissanceFocusNode.dispose();
      _NationaliteFocusNode.dispose();
      _NationaliteTextController.dispose();
      super.dispose();
    }

    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 2,
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
            bottom: const TabBar(tabs: [
              Text(
                'Locaux',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Etrangers',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                    child: Form(
                      key: _key11,
                      child: Column(children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: w,
                          height: h * 0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: const AssetImage(
                                'img/undraw_Upload_re_pasx.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                const Color.fromARGB(255, 248, 246, 246)
                                    .withOpacity(0.5),
                                BlendMode.dstATop),
                          )),
                          child: Text(
                            "Demande Prêts",
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
                              labelText: 'Nom Prénom | الإسم و اللقب',
                              hintText: 'Nom Prénom | الإسم و اللقب',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            _nomprenomFocusNode.unfocus();
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
                              final now = DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day);
                              final dateSelected = DateTime(
                                  selectedDateTime.year,
                                  selectedDateTime.month,
                                  selectedDateTime.day);
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
                          initialValue: DateTime.now(),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "Date de naissance | تاريخ الولادة",
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
                        TextFormField(
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
                            Validators.required(
                                'Cin ou identifiant est requis'),
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
                              labelText: "CIN  | بطاقة التعريف الوطنية ",
                              hintText: "11111111 | Maroc22MA2000'",
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            _cinFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: HexColor.fromHex('01579B'),
                          style: TextStyle(color: HexColor.fromHex('01579B')),
                          focusNode: _adresseFocusNode,
                          //autofocus: true,
                          enabled: true,
                          keyboardType: TextInputType.name,
                          // keyboardAppearance: Brightness.light,
                          textInputAction: TextInputAction.next,
                          controller: _adresseTextController,
                          onTap: () => setState(() {
                            //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                          }),

                          validator: Validators.compose([
                            Validators.required(' Adresse est requis'),
                            // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                          ]),
                          //  autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.house,
                                color: HexColor.fromHex('01579B'),
                              ),
                              labelText: ' Adresse  |  العنوان القار',
                              hintText: ' Adresse  | العنوان القار',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            _adresseFocusNode.unfocus();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: HexColor.fromHex('01579B'),
                          style: TextStyle(color: HexColor.fromHex('01579B')),
                          focusNode: _numerotlfFocusNode,
                          //autofocus: true,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          // keyboardAppearance: Brightness.light,
                          textInputAction: TextInputAction.next,
                          controller: _numerotlfTextController,
                          onTap: () => setState(() {
                            //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                          }),

                          validator: Validators.compose([
                            Validators.required('Numéro Téléphone est requis'),
                            Validators.patternString(r'^(?=.*?[0-9]).{8}$',
                                'Numéro de téléphone invalide')
                            // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                          ]),
                          //  autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: HexColor.fromHex('01579B'),
                              ),
                              labelText: ' Numéro Téléphone | الهاتف',
                              hintText: ' Numéro Téléphone | الهاتف',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            _numerotlfFocusNode.unfocus();
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
                              labelText: 'Email | البريد الإلكتروني',
                              hintText: 'example@domain.com',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                            'Etablissement | مؤسسة التعليم العالي',
                            style: TextStyle(
                                fontSize: 16,
                                color: HexColor.fromHex('01579B'),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.arrow_drop_down,
                              color: HexColor.fromHex('01579B')),
                          items:
                              Etabitems.map((item) => DropdownMenuItem<String>(
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
                            "Niveau d'étude | سنة الدراسة",
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
                              FocusScope.of(context)
                                  .requestFocus(_cinFocusNode);
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
                          keyboardType: TextInputType.number,
                          /*  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")),
                                      ],*/
                          enabled: true,
                          textInputAction: TextInputAction.next,
                          focusNode: _ResultatFocusNode,
                          controller: _ResultatTextController,
                          cursorColor: HexColor.fromHex('01579B'),
                          style: TextStyle(color: HexColor.fromHex('01579B')),
                          onTap: () => setState(() {}),
                          // keyboardType: TextInputType.emailAddress,
                          validator: Validators.compose(
                              [Validators.required('Résultat est requis')]),
                          autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.feed,
                                color: HexColor.fromHex('01579B'),
                              ),
                              labelText:
                                  'Résultat Année derniére | النتيجة العام الماضي',
                              hintText:
                                  'Résultat Année derniére | النتيجة العام الماضي',
                              labelStyle:
                                  TextStyle(color: HexColor.fromHex('01579B')),
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
                            _ResultatFocusNode.unfocus();
                            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                              Icons.document_scanner_rounded,
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
                            "Bac | بكالوريا",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: HexColor.fromHex('01579B'),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.arrow_drop_down,
                              color: HexColor.fromHex('01579B')),
                          items: Bac.map((item2) => DropdownMenuItem<String>(
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
                              return "Veuillez selectionner Type Bac";
                            }
                            return null;
                          },
                          onChanged: (value3) {
                            setState(() {
                              Typebac = value3.toString();
                            });
                            (term) {
                              FocusScope.of(context)
                                  .requestFocus(_cinFocusNode);
                            };
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value3) {
                            setState(() {
                              Typebac = value3.toString();
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
                              if (_key11.currentState!.validate()) {
                                /*       final pdfFile =
                                    await PdfApi.generateCenteredText(
                                        _numerotlfTextController.text.trim());*/
                                final pdfFile;

                                pdfFile = await PdfParagraphApi.generate(
                                  "Demande Prets Dossier N°:" +
                                      _cinTextController.text.trim(),
                                  _nomprenomTextController.text.trim(),
                                  _cinTextController.text.trim(),
                                  _adresseTextController.text.trim(),
                                  _numerotlfTextController.text.trim(),
                                  _emailTextController.text.trim(),
                                  Etabitements,
                                  NiveauEtude,
                                  _ResultatTextController.text.trim(),
                                  Typebac,
                                );

                                uploadDemande(pdfFile);
                                PdfApi.openFile(pdfFile);
                                //    _cinTextController.text =CerationDemandePrets.CINDemP;
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
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                    )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                  child: Column(children: <Widget>[
                    Form(
                      key: _key12,
                      child: Container(
                        alignment: Alignment.center,
                        width: w,
                        height: h * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image:
                              const AssetImage('img/undraw_Upload_re_pasx.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              const Color.fromARGB(255, 248, 246, 246)
                                  .withOpacity(0.5),
                              BlendMode.dstATop),
                        )),
                        child: Text(
                          "Demande Bourse",
                          style: TextStyle(
                            fontSize: 40,
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
                    TextFormField(
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      focusNode: _PassportFocusNode,
                      // autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.text,
                      // keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      controller: _PassportTextController,
                      onTap: () => setState(() {
                        //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                      }),

                      validator: Validators.compose([
                        Validators.required(
                            ' Le numéro du passepor est requis'),
                        Validators.patternString(r'^(?!^0+$)[a-zA-Z0-9]{3,20}$',
                            'Le numéro du passeport invalide')
                        //Maroc22MA2000
                      ]),

                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.assignment_ind,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: "Le numéro du passeport | رقم جواز السفر",
                          hintText: "Le numéro du passeport | رقم جواز السفر",
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
                        _PassportFocusNode.unfocus();
                        //  FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      focusNode: _NationaliteFocusNode,
                      // autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.text,
                      // keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      controller: _NationaliteTextController,
                      onTap: () => setState(() {
                        //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                      }),

                      validator: Validators.compose([
                        Validators.required(' Nationalité est requis'),

                        //Maroc22MA2000
                      ]),

                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_pin_outlined,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: "Nationalité | الجنسية",
                          hintText: "Nationalité | الجنسية",
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
                        _NationaliteFocusNode.unfocus();
                        //    FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                    ),
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
                          labelText: 'Nom Prénom | الإسم و اللقب',
                          hintText: 'Nom Prénom | الإسم و اللقب',
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
                    DateTimeField(
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      // focusNode: _birthdateFocusNode,
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
                      initialValue: DateTime.now(),
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
                          labelText: "Date de naissance | تاريخ الولادة",
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
                    TextFormField(
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      focusNode: _LieudenaissanceFocusNode,
                      //autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.name,
                      // keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      controller: _LieudenaissanceTextController,
                      onTap: () => setState(() {
                        //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                      }),

                      validator: Validators.compose([
                        Validators.required(' Adresse est requis'),
                        // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                      ]),
                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.house,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: 'Lieu de naissance | مكانها',
                          hintText: 'Lieu de naissance  | مكانها',
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
                        _LieudenaissanceFocusNode.unfocus();
                        //    FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                        Validators.required(' Identifiant est requis'),
                        Validators.patternString(
                            r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{2,4}(?=.*?[a-zA-Z]).{2,4}(?=.*?[0-9]).{2,4}|| ^(?=.*?[0-9]).{8}$',
                            'Carte CIN ou Identifiant  invalide')
                        //Maroc22MA2000
                      ]),

                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.how_to_reg,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: " IDENTIFIANT  |  المعرِّف",
                          hintText: "11111111 | Maroc22MA2000'",
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
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      focusNode: _adresseFocusNode,
                      //autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.name,
                      // keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      controller: _adresseTextController,
                      onTap: () => setState(() {
                        //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                      }),

                      validator: Validators.compose([
                        Validators.required(' Adresse est requis'),
                        // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                      ]),
                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.maps_home_work,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: 'Adresse en Tunisie  |  العنوان بتونس',
                          hintText: ' Adresse en Tunisie  |  العنوان بتونس',
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
                        _adresseFocusNode.unfocus();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: HexColor.fromHex('01579B'),
                      style: TextStyle(color: HexColor.fromHex('01579B')),
                      focusNode: _numerotlfFocusNode,
                      //autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      // keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      controller: _numerotlfTextController,
                      onTap: () => setState(() {
                        //  FocusScope.of(context).requestFocus(_keyboardfocusnode);
                      }),

                      validator: Validators.compose([
                        Validators.required('Numéro Téléphone est requis'),
                        Validators.patternString(r'^(?=.*?[0-9]).{8}$',
                            'Numéro de téléphone invalide')
                        // Validators.min(5, 'Valeur inférieure à 5 non autorisée')
                      ]),
                      //  autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: HexColor.fromHex('01579B'),
                          ),
                          labelText: ' Numéro Téléphone | الهاتف',
                          hintText: ' Numéro Téléphone | الهاتف',
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
                        _numerotlfFocusNode.unfocus();
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
                          labelText: 'Email | البريد الإلكتروني',
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
                        //   FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                        'Etablissement | مؤسسة التعليم العالي',
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
                        "Niveau d'étude | سنة الدراسة",
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
                    SizedBox(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_key12.currentState!.validate()) {
                            /*       final pdfFile =
                                      await PdfApi.generateCenteredText(
                                          _numerotlfTextController.text.trim());*/
                            final pdfFile;

                            pdfFile = await PdfParagraphApiEtranger.generate(
                                "Demande Bourse Dossier N°:" +
                                    _cinTextController.text.trim(),
                                _nomprenomTextController.text.trim(),
                                _cinTextController.text.trim(),
                                _adresseTextController.text.trim(),
                                _numerotlfTextController.text.trim(),
                                _emailTextController.text.trim(),
                                Etabitements,
                                NiveauEtude,
                                _dateTextController.text.trim(),
                                _LieudenaissanceTextController.text.trim(),
                                _passwordTextController.text.trim(),
                                _NationaliteTextController.text.trim());

                            uploadDemande(pdfFile);
                            PdfApi.openFile(pdfFile);
                            //    CerationDemandePrets.CINDemP =_cinTextController.text;
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
            ],
          ),
        ),
      ),
    );
  }

  Future uploadDemande(File file) async {
    if (file == null) return;

    final fileName = (MyApp.cin +
        file.path
            .substring(file.path.indexOf('app_flutter/'))
            .replaceAll('app_flutter', ""));
    final destination = 'Les Demandes/Demandes Prets/$fileName';
    FirebaseApi.uploadDemande(destination, file);
  }
}
