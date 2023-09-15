import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/menu.dart';
import '../View/User/user_login.dart';

// FAZ A VERIFICAÇÃO DO TOKEN, SE EXISTIR, MANDA PARA A PÁGINA DE TAREFAS
// CASO NÃO EXISTA TOKEN, MANDA PARA A PÁGINA DE LOGIN

class SplashScreen extends State {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkToken(), // Função que verifica a presença do token
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return const Menu();
        } else {
          return const UserLogin();
        }
      },
    );
  }
}

Future<bool> checkToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null;
}
