import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repository/user_repository.dart';
import '../View/menu.dart';
import '../View/User/user_login.dart';

// CONTROLLER DE LOGIN E LOGOUT DO USUÁRIO;

Future<void> login(BuildContext context, String email, String password) async {
  SharedPreferences _SharedPreferences = await SharedPreferences.getInstance();
  try {
    final user = await authenticate('leo@leo.com', '1'); // ALTERAR
    if (user != null) {
      _SharedPreferences.setString('token', 'Bearer ${user.token}');
      _SharedPreferences.setString('fullName', user.fullName);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Menu(),
        ),
      );
      // Faça alguma coisa com o usuário autenticado
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
      builder: (context) => UserLogin(),
    ),
  );
}

Future<Set<String>?> updateUser(String newName, String newPassword,
    String newPasswordRepeat, String password) async {
  final results =
      await update(newName, newPassword, newPasswordRepeat, password);

  if (results != null) {
    return results;
  }
  return null;
}
