import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_campus/Pages/extraction_doc/DemandeExtractionCerfiff.dart';
import 'package:in_campus/Pages/extraction_doc/DemandeExtractionCertiffNonBenif.dart';
import 'package:in_campus/Pages/home/AddPost.dart';
import 'package:in_campus/Services/API_google_Sign_Service.dart';
import 'package:in_campus/pages/chat/chat_page.dart';
import 'package:in_campus/pages/demande/C%C3%A9rationDemandeBourse.dart';
import 'package:in_campus/pages/demande/Cr%C3%A9ationDemandeAide.dart';
import 'package:in_campus/pages/demande/Cr%C3%A9ationDemandePrets.dart';
import 'package:in_campus/pages/demande/CreationDemandeH%C3%A9berg.dart';
import 'package:in_campus/pages/dossier/ConsulterDossierAideSocial.dart';
import 'package:in_campus/pages/dossier/ConsulterDossierBOURSE.dart';
import 'package:in_campus/pages/dossier/ConsulterDossierHebergement.dart';
import 'package:in_campus/pages/dossier/ConsulterDossierPrets.dart';
import 'package:in_campus/pages/dossier/TypeDossier.dart';
import 'package:in_campus/pages/dossier/d%C3%A9poserDossier.dart';
import 'package:in_campus/pages/extraction_doc/DemandeExtractionDoc.dart';
import 'package:in_campus/pages/home/HomeScreen.dart';
import 'package:in_campus/pages/login/Profile.dart';
import 'package:in_campus/pages/login/login_page.dart';
import 'package:in_campus/pages/randezvous/BookingCalendar.dart';
import 'package:in_campus/pages/randezvous/randezvous_page.dart';
import 'package:in_campus/pages/reclamation/Reclamtion.dart';
import 'package:provider/provider.dart';
import 'Pages/randezvous/mesRendezVousPage.dart';
import 'Services/Google_Map_Service.dart';
import 'models/User.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static String cin="";
  static Uuser? uuser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IN-CAMPUS',
          routes: {
            "/": (context) => const LoginPage(),
            "/AddPost": (context) => const AddPost(),
            "/HomeScreen": (context) => const HomeScreen(),
            "/MesRendezVousPage": (context) => const MesRendezVousPage(),
            "/RendezVousPage": (context) => const RendezVousPage(),
            "/Deposerdossier": (context) => const Deposerdossier(),
            "/DemandeExtractionCerfiff": (context) =>
                const DemandeExtractionCerfiff(),
            "/DemandeExtractionCertiffNonBenif": (context) =>
                const DemandeExtractionCertiffNonBenif(),
            "/Profile": (context) => const profile(),
            "/CerationDemande": (context) => const CerationDemandeBourse(),
            "/CerationDemandePrets": (context) => const CerationDemandePrets(),
            "/CerationDemandeHeberg": (context) =>
                const CerationDemandeHeberg(),
            "/CerationDemandeAide": (context) => const CerationDemandeAide(),
            "/Chat_page": (context) => ChatPage(),
            "/MapSample": (context) => MapSample(),
            "/Reclamation": (context) => Reclamation(),
            "/TypeDossier": (context) => TypeDossier(),
            "/ConsulterDossierBourse": (context) => ConsulterDossierBourse(),
            "/DemandeExtarctionDoc": (context) => DemandeExtarctionDoc(),
            "/ConsulterDossierHebergement": (context) =>
                ConsulterDossierHebergement(),
            "/ConsulterDossierPrets": (context) => ConsulterDossierPrets(),
            "/ConsulterDossierAideSocial": (context) =>
                ConsulterDossierAideSocial(),
            //  "/BookingCalendarDemoApp": (context) => BookingCalendarDemoApp(),
          }),
    );
  }
}
