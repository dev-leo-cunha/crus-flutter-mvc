import 'package:flutter/material.dart';

import '../Controller/location_controller.dart';
import 'task_list_tarefas.dart'; // Importe o controller

class UserLocation extends StatefulWidget {
  const UserLocation({Key? key}) : super(key: key);

  @override
  UserLocationState createState() => UserLocationState();
}

class UserLocationState extends State<UserLocation> {
  LocationController locationController =
      LocationController(); // Crie uma instância do controller

  @override
  void initState() {
    super.initState();
    locationController.locationStream.listen((locationData) {
      // Atualize a interface do usuário com os novos valores de localização
      setState(() {
        locationController.latitude = locationData.latitude;
        locationController.longitude = locationData.longitude;
      });
    });
  }

  @override
  void dispose() {
    locationController
        .dispose(); // Certifique-se de chamar dispose quando o widget for descartado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Localização do usuário'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Tarefas(),
                ));
              })),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Longitude ${locationController.longitude ?? ''}'),
            Text('Latitude ${locationController.latitude ?? ''}'),
          ],
        ),
      ),
    );
  }
}
