import 'package:flutter/material.dart';
import 'package:mvc/View/task_add_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  UserLoginState createState() => UserLoginState();
}

class UserLoginState extends State<UserLocation> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização do usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Longitude $longitude'),
            Text('Latitude $latitude'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const Tarefas(), // Substitua por sua tela principal
                    ),
                  );
                },
                child: const Text('Voltar para tarefas')),
          ],
        ),
      ),
    );
  }
}
