import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/main.dart';
import '../../helper/hexColors.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import '../../models/EtatDossier.dart';
import '../login/login_page.dart';
import 'déposerDossier.dart';
import '../login/Profile.dart';

class ConsulterDossierBourse extends StatefulWidget {
  const ConsulterDossierBourse({Key? key}) : super(key: key);

  @override
  State<ConsulterDossierBourse> createState() => _ConsulterDossierBourseState();
}

final user = FirebaseAuth.instance.currentUser!;

class _ConsulterDossierBourseState extends State<ConsulterDossierBourse> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(profile.userCIN);

    return SafeArea(
      child: GestureDetector(
        //  onTap: unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'DOSSIER BOURSE',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
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
          body: Column(children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('img/undraw_Crypto_flowers_re_dyqo.png'),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
              child: Align(
                alignment: Alignment.bottomLeft + const Alignment(0.2, -0.1),
                child: Text(
                  "Voila !",
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
            SizedBox(
              height: 100,
              width: w,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, h * 0.0, 10, 0),
              child: FutureBuilder<Etat?>(
                future: readEtat(),
                builder: (context, snapshot) {
                  final etat = snapshot.data;
                  return etat == null
                      ? NoDATAFOUND(context, w, h)
                      : buildEtat(etat, context, h, w);
                },
              ),
            ),
            SizedBox(
              height: 160,
              width: w,
            ),
            Text(
              "MERCI D'AVOIR UTILISER IN-CAMPUS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,

                /// fontFamily: 'BebasNeue-Regular',
                color: HexColor.fromHex('2F2E41'),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<Etat?> readEtat() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print("************************************" + MyApp.cin);
    final doc = db.collection('EtatBourse').doc(MyApp.cin);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      try {
        print("data:+++:" + Etat.fromJson(snapshot.data()!).EtatDossier);
        return Etat.fromJson(snapshot.data()!);
      } on FirebaseException catch (error) {
        print("error triggering to firestore: ${error.toString()}");
      }
    }
  }

  Widget buildEtat(Etat etat, BuildContext context, double h, double w) =>
      Container(
        padding:
            const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 30),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(32),
          ),
          color: HexColor.fromHex('2F88FF'),
        ),
        child: Text(
          'Dossier N°: ' +
              '${etat.Cin}' +
              '\n' +
              'Nom : ' +
              '${etat.Etudiant}' +
              '\n' +
              'Etat: ' +
              '${etat.EtatDossier}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            //fontFamily: 'BebasNeue-Regular',
            color: HexColor.fromHex('2F2E41'),
          ),
        ),
      );

  Widget NoDATAFOUND(BuildContext context, double w, double h) => Container(
        height: h * 0.2,
        width: w,
        /*  padding:
            const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 30),*/
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //   backgroundColor: Colors.blue,
        child: GradientProgressIndicator(
          radius: 45,
          duration: 4,
          strokeWidth: 12,
          gradientStops: const [
            0.2,
            0.8,
          ],
          gradientColors: const [
            Colors.white,
            Colors.grey,
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Aucun dossier Trouver',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                height: 10,
                width: w,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Deposerdossier()));
                },
                child: Text(
                  'Veuillez Déposer un dossier',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
}
