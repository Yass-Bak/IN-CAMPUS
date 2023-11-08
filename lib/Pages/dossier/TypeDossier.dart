import 'package:flutter/material.dart';

import '../../helper/hexColors.dart';

class TypeDossier extends StatefulWidget {
  const TypeDossier({Key? key}) : super(key: key);

  @override
  _TypeDossierState createState() => _TypeDossierState();
}

class _TypeDossierState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      top: true,
      child: Scaffold(
          //  backgroundColor: Colors.yellow,
          appBar: AppBar(
            title: const Text('SERVICES OFFICE'),
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
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: const AssetImage('img/undraw_Terms_re_6ak4.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    ))),
              ),
              Container(
                height: h * 0.1,
                width: w,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.1, 20, 0),
                child: Column(
                  children: [
                    Text("CHOISIR LE TYPE DE DOSSIER À CONSULTER",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'BebasNeue-Regular',
                          color: HexColor.fromHex('43434E'),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: h * 0.1,
                      width: w,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.local_atm,
                          color: HexColor.fromHex('6C63FF'),
                          size: 50.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/ConsulterDossierBourse");
                        },
                        label: Text(
                          'Consultez Votre Dossier Bourse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex('000000')),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return HexColor.fromHex('FFFFFF');
                              }
                              return HexColor.fromHex('C4C4C4');
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: h * 0.1,
                      width: w,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.accessibility,
                          color: HexColor.fromHex('6C63FF'),
                          size: 50.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/ConsulterDossierAideSocial");
                        },
                        label: Text(
                          'Consultez votre dossier Aide Social',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex('000000')),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return HexColor.fromHex('FFFFFF');
                              }
                              return HexColor.fromHex('C4C4C4');
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: h * 0.1,
                      width: w,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.credit_score,
                          color: HexColor.fromHex('6C63FF'),
                          size: 50.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/ConsulterDossierPrets");
                        },
                        label: Text(
                          'Consultez votre dossier de Prêt universitaire',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex('000000')),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return HexColor.fromHex('FFFFFF');
                              }
                              return HexColor.fromHex('C4C4C4');
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: h * 0.1,
                      width: w,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.apartment,
                          color: HexColor.fromHex('6C63FF'),
                          size: 50.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/ConsulterDossierHebergement");
                        },
                        label: Text(
                          "Consultez votre dossier d'hébergement",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex('000000')),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return HexColor.fromHex('FFFFFF');
                              }
                              return HexColor.fromHex('C4C4C4');
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
