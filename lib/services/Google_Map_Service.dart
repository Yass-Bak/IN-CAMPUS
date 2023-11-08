import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_campus/helper/hexColors.dart';

class MapSample extends StatefulWidget {
  MapSample({Key? key}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng currentLatLng = LatLng(34.73621788356316, 10.74393192411975);
  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition markerPosition = CameraPosition(
    target: LatLng(34.756613335018805, 10.763178643122),
    zoom: 17.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('2F2E41'),
        title: Text("GOOGLE MAPS"),
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
      body: GoogleMap(
        markers: {
          Marker(
            markerId: MarkerId(
                ' Faculté des sciences économiques et de gestion de Sfax'),
            infoWindow: InfoWindow(title: 'FSEGS'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: LatLng(34.73465060455293, 10.709969383637914),
          ),
          Marker(
            markerId: MarkerId('Office des oeuvres universitaire pour le sud'),
            infoWindow: InfoWindow(title: 'OOUS'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: LatLng(34.73621788356316, 10.74393192411975),
          ),
          Marker(
            markerId: MarkerId('Ecole Superieure de Commerce ESC Sfax'),
            infoWindow: InfoWindow(title: 'ESC'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: LatLng(34.73396287933482, 10.709175449806656),
          ),
          Marker(
            markerId: MarkerId('ENIS'),
            infoWindow: InfoWindow(title: 'ENIS'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: LatLng(34.72624768021899, 10.717726117101533),
          ),
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: currentLatLng,
          zoom: 17.5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
