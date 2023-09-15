import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc/Controller/location_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MapWidget> {
  late GoogleMapController mapController;
  LatLng center = const LatLng(-27.5927967, -48.5446916);
  late LocationData local;
  @override
  void initState() {
    _initMap();
    super.initState();
  }

  Future<void> _initMap() async {
    try {
      local = await getLocation();
      setState(() {
        center = LatLng(local.latitude as double, local.longitude as double);
      });
      // mapController.moveCamera(CameraUpdate.newLatLng(center));
    } catch (e) {
      print("Erro ao obter a localização: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-27.5927967, -48.5446916), // alterar para center
          zoom: 22.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _initMap();
        },
      ),
    );
  }
}
