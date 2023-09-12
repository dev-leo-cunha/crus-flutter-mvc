import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repository/user_repository.dart';
import '../View/task_add_list.dart';
import '../View/user_login.dart';

// CONTROLLER DE LOGIN E LOGOUT DO USUÁRIO;

Future<void> login(BuildContext context, String email, String password) async {
  SharedPreferences _SharedPreferences = await SharedPreferences.getInstance();
  try {
    final user = await authenticate(email, password);
    if (user != null) {
      _SharedPreferences.setString('token', 'Token ${user.token}');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const Tarefas(), // Substitua por sua tela principal
        ),
      );
      // Faça alguma coisa com o usuário autenticado
      print('Usuário autenticado: ${user.fullName}');
    } else {
      // Caso o usuário não seja autenticado, exiba uma mensagem
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email ou senha inválidos'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
    }
  } catch (e) {
    // Lidar com exceções, se houver alguma
    print('Erro durante a autenticação: $e');
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences _SharedPreferences = await SharedPreferences.getInstance();
  _SharedPreferences.remove('token');
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => UserLogin(), // Substitua por sua tela principal
    ),
  );
}
