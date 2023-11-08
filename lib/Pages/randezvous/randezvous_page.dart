import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_campus/Pages/home/HomeScreen.dart';
import 'package:in_campus/helper/hexColors.dart';
import 'package:in_campus/pages/randezvous/BookingCalendar.dart';

import 'package:responsive_grid/responsive_grid.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({Key? key}) : super(key: key);

  @override
  _RendezVousPageState createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) => (HomeScreen()))),
            child: Icon(FontAwesomeIcons.arrowLeft),
          ),
          backgroundColor: HexColor.fromHex('2F2E41'),
          title: Text("SERVICES OFFICE"),
          centerTitle: true,
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              /*   Image(
                height: h * 0.2,
                image: AssetImage("img/undraw_Booking_re_gw4j.png"),
              ),*/
              Container(
                alignment: Alignment.center,
                width: w,
                height: h * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: const AssetImage("img/undraw_Booking_re_gw4j.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(1), BlendMode.dstATop),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "COMMENT PEUT-ON VOUS AIDER ?",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: HexColor.fromHex('2F2E41')),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 8.0),
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                      xs: 6,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BookingCalendar(type: "Dossier Bourse")));
                          },
                          child: Card(
                              child: Icon(
                            Icons.account_balance_outlined,
                            color: HexColor.fromHex('2F88FF'),
                            size: 100,
                          )))),
                  ResponsiveGridCol(
                      xs: 6,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (_) => BookingCalendar(type: "Dossier Hébergement",)));
                          },
                          child: Card(
                            child: Icon(
                              Icons.apartment,
                              color: HexColor.fromHex('2F88FF'),
                              size: 100,
                            ),
                          )))
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 8.0),
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                      xs: 6,
                      child: Text(
                        "BOURSE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor.fromHex('2F2E41')),
                      )),
                  ResponsiveGridCol(
                      xs: 6,
                      child: Text(
                        "HEBERGEMENT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor.fromHex('2F2E41')),
                      ))
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 8.0),
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                      xs: 6,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (_) => BookingCalendar(type: "Dossier Prêt Universitaire",)));
                          },
                          child: Card(
                            child: Icon(
                              Icons.credit_score,
                              color: HexColor.fromHex('2F88FF'),
                              size: 100,
                            ),
                          ))),
                  ResponsiveGridCol(
                      xs: 6,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (_) => BookingCalendar(type: "Autre Dossier")));
                          },
                          child: Card(
                            child: Icon(
                              Icons.add,
                              color: HexColor.fromHex('2F88FF'),
                              size: 100,
                            ),
                          )))
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.0, 20, 8.0),
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                      xs: 6,
                      child: Text(
                        "PRÊT UNIVERSITAIRE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor.fromHex('2F2E41')),
                      )),
                  ResponsiveGridCol(
                      xs: 6,
                      child: Text(
                        "AUTRE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor.fromHex('2F2E41')),
                      )),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
