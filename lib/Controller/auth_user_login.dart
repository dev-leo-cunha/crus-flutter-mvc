import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/task_add_list.dart';
import '../View/user_login.dart';

// FAZ A VERIFICAÇÃO DO TOKEN, SE EXISTIR, MANDA PARA A PÁGINA DE TAREFAS
// CASO NÃO EXISTA TOKEN, MANDA PARA A PÁGINA DE LOGIN

class SplashScreen extends State {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkToken(), // Função que verifica a presença do token
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Enquanto estiver esperando, você pode exibir um indicador de carregamento
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          // O token está presente, navegue para a página de tarefas
          return const Tarefas();
        } else {
          // O token não está presente, navegue para a página de login
          return UserLogin();
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
