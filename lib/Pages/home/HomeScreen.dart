import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/models/Posts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_campus/widgets/reusableWidgets.dart';
import '../../Services/API_google_Sign_Service.dart';
import '../../helper/hexColors.dart';
import '../../models/User.dart';
import '../login/login_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final _controller = ScrollController();
@override
  void initState()  {

  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  docUser.get().then((value) {
    if (value.exists) {
      log("*******---------+++++++++++++-----------**********");
      MyApp.uuser=Uuser(Uuser.fromJson(value.data()!)
          .displayName, Uuser.fromJson(value.data()!)
          .Etablissement!, Uuser.fromJson(value.data()!)
          .NiveauEtude!, Uuser.fromJson(value.data()!)
          .Sexe!, Uuser.fromJson(value.data()!)
          .dateNais!, Uuser.fromJson(value.data()!)
          .Cin!, Uuser.fromJson(value.data()!)
          .rendezvous!, Uuser.fromJson(value.data()!)
          .heuresRdv!);
        log("////************/////////**************");
        log(MyApp.uuser!.rendezvous.toString());
      MyApp.cin =
      Uuser.fromJson(value.data()!)
          .Cin!;
      log("********CIN**********");
      log(MyApp.uuser!.Cin!);
      print('Voila YUPPPI  ' +
          MyApp.uuser!.Cin! +
          MyApp.uuser!.dateNais! +
          MyApp.uuser!.Etablissement! +
          MyApp.uuser!.rendezvous.toString()+
          '  Voila  YUPPPI');}

  });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    final String url = user.photoURL.toString();
    final Uri _url = Uri.parse('https://www.oous.rnu.tn/oous_new/index.php');
    void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Probleme de connexion $_url';
    }

    ImageProvider setBackgroundimage() {
      if (user.photoURL == null) {
        return const AssetImage("img/avatar-placeholder.jpg");
      } else {
        return FileImage(File(user.photoURL!));
      }
      return NetworkImage(url);
    }

    return Scaffold(
      //    extendBodyBehindAppBar: true,
      backgroundColor: HexColor.fromHex('EDEDED'),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: HexColor.fromHex('FFFFFF'),
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft + const Alignment(0, 0.3),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/Profile"),
                      child: CircleAvatar(
                        backgroundImage: setBackgroundimage(),
                        radius: 40.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + const Alignment(0, 0),
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      '' + user.displayName.toString() == null
                          ? 'Aucun Nom'
                          : user.displayName.toString(),
                      style: TextStyle(
                          color: HexColor.fromHex('01579B'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment:
                        Alignment.bottomLeft + const Alignment(0.22, 0.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/Profile"),
                      child: Text(
                        'Profil',
                        style: TextStyle(
                            color: HexColor.fromHex('01579B'),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft + const Alignment(0.0, 0.2),
                    child: InkWell(
                      child: Text(
                        'Office des oeuvres universitaire pour le sud',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HexColor.fromHex('2F2E41'),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        const url =
                            'https://www.oous.rnu.tn/oous_new/index.php';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Image.asset("img/téléchargement.png",
                          height: 40, width: 40),
                      onTap: () async {
                        const url =
                            'https://www.oous.rnu.tn/oous_new/index.php';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight + const Alignment(0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                        MyApp.cin="";
                        Navigator.of(context).pushNamed('/');
                      },
                      child: Text(
                        'Déconnecter',
                        style: TextStyle(
                            fontSize: 14,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.upload_file,
                size: 30,
                color: HexColor.fromHex('2F88FF'),
              ),
              title: Text('DÉPOSER DOSSIER',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      fontFamily: 'Lato-Bold.ttf',
                      color: HexColor.fromHex('2F2E41'))),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, "/Deposerdossier");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book_sharp,
                size: 30,
                color: HexColor.fromHex('2F88FF'),
              ),
              title: Text('CONSULTER DOSSIER',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lato-Bold.ttf',
                      color: HexColor.fromHex('2F2E41'))),
              onTap: () {
                Navigator.pushNamed(context, "/TypeDossier");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                size: 30,
                color: HexColor.fromHex('2F88FF'),
              ),
              title: Text('PRENDRE UN RENDER-VOUS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lato-Bold.ttf',
                      color: HexColor.fromHex('2F2E41'))),
              onTap: () {
                Navigator.pushNamed(context, "/RendezVousPage");

                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.my_library_books_sharp,
                color: HexColor.fromHex('2F88FF'),
                size: 30,
              ),
              title: Text("EXTRACTION DOCUMENT",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lato-Bold.ttf',
                      color: HexColor.fromHex('2F2E41'))),
              onTap: () {
                Navigator.pushNamed(context, "/DemandeExtarctionDoc");

                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                size: 30,
                color: HexColor.fromHex('2F88FF'),
              ),
              title: Text('RÉCLAMATION',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lato-Bold.ttf',
                      color: HexColor.fromHex('2F2E41'))),
              onTap: () {
                /* showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Option Numéro 2'),
                          content: Text('Message a afficher de l\'option 2'),
                        )); */
                Navigator.pushNamed(context, "/Reclamation");
                //Navigator.pop(context);
              },
            ),
            SizedBox(
              height: h * 0.22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.bottomLeft, children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("/MapSample");
                      //Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.map,
                      color: HexColor.fromHex('01A28D'),
                      size: 40,
                    ),
                  ),
                ]),
                SizedBox(
                  width: 55,
                ),
                Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.mail,
                      color: HexColor.fromHex('01A28D'),
                      size: 40,
                    ),
                    onTap: () {
                      // ignore: deprecated_member_use
                      launch(
                          'mailto:<contact@oous.mesrs.tn>?subject=IN-CAMPUS&body=IN-CAMPUS');
                      //Navigator.pop(context);
                    },
                  ),
                ]),
                SizedBox(
                  width: 55,
                ),
                Stack(alignment: Alignment.bottomRight, children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.phone,
                      color: HexColor.fromHex('01A28D'),
                      size: 40,
                    ),
                    onTap: () async {
                      // ignore: deprecated_member_use
                      ///  launch('tel:+216 74 243 614');
                      await FlutterPhoneDirectCaller.callNumber(
                          "+216 74 243 614");
                      //Navigator.pop(context);
                    },
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
      //backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('ACCEUIL'),
        centerTitle: true,
        backgroundColor: HexColor.fromHex('2F2E41'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_to_photos,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/AddPost');
              // do something
            },
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Approve'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),*/
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((posts) {
                  return Container(
                    width: w,
                    padding: const EdgeInsets.only(
                        left: 30, top: 20, bottom: 20, right: 30),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: HexColor.fromHex('FFFFFF'),
                    ),
                    child: Column(children: [
                      Align(
                        alignment:
                            Alignment.centerLeft + const Alignment(0, 0.3),
                        child: Text(
                          posts['Created_by'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: HexColor.fromHex('2F2E41'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Align(
                        alignment:
                            Alignment.centerLeft + const Alignment(0, 0.3),
                        child: Text(
                          posts['Created_at'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: HexColor.fromHex('2F88FF'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        posts['Contenu'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex('2F2E41'),
                        ),
                      ),
                    ]),
                  );
                  // ListTile
                }).toList(),
              );
            } else
              return Center(
                  child: Text('Loading...',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex('01579B'))));
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/Chat_page');
          // Add your onPressed code here!
        },
        label: Text('CHAT',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor.fromHex('01579B'))),
        icon: Icon(
          Icons.chat_rounded,
          color: HexColor.fromHex('01579B'),
        ),
        backgroundColor: HexColor.fromHex('FFD15B'),
      ),
    );
  }

  Stream<List<Posts>> readPosts() => FirebaseFirestore.instance
      .collection('posts')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Posts.fromJson(doc.data())).toList());
}
