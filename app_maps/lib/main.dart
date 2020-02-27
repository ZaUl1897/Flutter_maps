import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  String buscarDir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            options: GoogleMapOptions(
                cameraPosition: CameraPosition(
                    target: LatLng(21.1193733, -86.809402), zoom: 15.0)),
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ingrese direccion: ',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: barraBusqueda,
                      iconSize: 35.0,
                    ),
                  ),
                ),
                onChanged: (val){
                  setState(() {
                    buscarDir= val;
                  });
                }
              ),
            ),
          )
        ],
      ),
    );
  }

  //Funcion para crear la busqueda por direccion
  barraBusqueda(){
    //importamos la libreria Geolocator
    Geolocator().placemarkFromAddress(buscarDir).then((result){
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(result[0].position.latitude,result[0].position.longitude),
        zoom: 10.0))); //Posicion de la camara
    });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
