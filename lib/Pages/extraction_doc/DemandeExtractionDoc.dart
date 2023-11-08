// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_campus/Pages/login/login_page.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/main.dart';
import 'package:in_campus/main.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/UploadFileService.dart';
import '../../helper/hexColors.dart';

class DemandeExtarctionDoc extends StatefulWidget {
  const DemandeExtarctionDoc({Key? key}) : super(key: key);

  @override
  _DemandeExtarctionDoc createState() => _DemandeExtarctionDoc();
}

UploadTask? task;
File? file;

class _DemandeExtarctionDoc extends State<DemandeExtarctionDoc> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    final String url = user.photoURL.toString();
    final Uri _url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.adobe.scan.android&hl=fr_CA&gl=US');
    void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Probleme de connexion $_url';
    }

    final fileName =
        file != null ? basename(file!.path) : 'Aucun fichier sélectionné';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //   backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Text(
            'EXTRACTION DOCUMENT',
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
          bottom: TabBar(tabs: <Widget>[
            Icon(
              Icons.check,
              color: HexColor.fromHex('01A28D'),
              size: 45.0,
            ),
            Icon(
              Icons.remove_done,
              color: HexColor.fromHex('F50057'),
              size: 45.0,
            )
          ]),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: w,
                    height: h * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: const AssetImage('img/undraw_Upload_re_pasx.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 248, 246, 246)
                              .withOpacity(0.5),
                          BlendMode.dstATop),
                    )),
                    child: Text(
                      " Certificat de bénéficiant d’une bourse",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('2F2E41'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed("/DemandeExtractionCerfiff"),
                    child: Text(
                      "Créer Votre demande d'abord",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        // fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('01579B'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton.icon(
                        onPressed: (() {
                          selectFile();
                        }),
                        icon: const Icon(Icons.attach_file),
                        label: const Text(
                          'Attacher Document',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor.fromHex('2F2E41'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton.icon(
                        onPressed: (() {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              elevation: 24.0,
                              backgroundColor: Colors.white,
                              title:
                                  const Text("Voulez-vous déposer maintenant?"),
                              //  content: Text("Choose one"),
                              actions: <Widget>[
                                FlatButton(
                                  color: HexColor.fromHex('2F2E41'),
                                  child: const Text("Oui",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    uploadDemandeExtarction(context);
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
                        }),
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text(
                          'Déposer Document',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                  const SizedBox(height: 8),
                  task != null
                      ? buildUploadStatus(task!)
                      : const SizedBox(
                          width: 8,
                        ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: InkWell(
                        child: Image.asset("img/unnamed.png",
                            height: 40, width: 40),
                        onTap: () {
                          _launchUrl();
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Veuillez télecharger cette application pour puvoir  scanner les documents.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        // fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('2F2E41'),
                      )),
                ]),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 0),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: w,
                    height: h * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: const AssetImage('img/undraw_Upload_re_pasx.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 248, 246, 246)
                              .withOpacity(0.5),
                          BlendMode.dstATop),
                    )),
                    child: Text(
                      "Certificat  de ne bénéficiant pas d’une Bourse",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('2F2E41'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed("/DemandeExtractionCertiffNonBenif"),
                    child: Text(
                      "Créer Votre demande d'abord",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        // fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('01579B'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton.icon(
                        onPressed: (() {
                          selectFile();
                        }),
                        icon: const Icon(Icons.attach_file),
                        label: const Text(
                          'Attacher Document',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor.fromHex('2F2E41'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton.icon(
                        onPressed: (() {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              elevation: 24.0,
                              backgroundColor: Colors.white,
                              title:
                                  const Text("Voulez-vous déposer maintenant?"),
                              //  content: Text("Choose one"),
                              actions: <Widget>[
                                FlatButton(
                                  color: HexColor.fromHex('2F2E41'),
                                  child: const Text("Oui",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    uploadDemandeExtarction2(context);
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
                        }),
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text(
                          'Déposer Document',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                  const SizedBox(height: 8),
                  task != null
                      ? buildUploadStatus(task!)
                      : SizedBox(
                          width: 8,
                        ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: InkWell(
                        child: Image.asset("img/unnamed.png",
                            height: 40, width: 40),
                        onTap: () {
                          _launchUrl();
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Veuillez télecharger cette application pour puvoir  scanner les documents.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        // fontFamily: 'BebasNeue-Regular',
                        color: HexColor.fromHex('2F2E41'),
                      )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadDemandeExtarction(context) async {
    if (file == null) return;
    print("heyy print it --------" + MyApp.cin);
    final fileName = basename(file!.path);
    final destination = '/DemandeExtarction/Certificat deGrant/' +
        MyApp.cin +
        '/' +
        '$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text:
            'Demande Envoyée vous recevrai la certificat aprés 24h consulter votre Mail !',
        autoCloseDuration: Duration(seconds: 15),
      );
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uploadDemandeExtarction2(context) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = '/DemandeExtarction/Certificat de non-Grant/' +
        MyApp.cin +
        '/' +
        '$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text:
            'Demande Envoyée vous recevrai la certificat aprés 24h consulter votre Mail !',
        autoCloseDuration: Duration(seconds: 20),
      );
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  void main() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            );
          } else {
            return const SizedBox(
              height: 5,
              width: 5,
            );
          }
        },
      );
}
