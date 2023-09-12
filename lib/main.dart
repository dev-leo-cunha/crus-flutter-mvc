import 'package:flutter/material.dart';
import 'package:mvc/Controller/auth_user_login.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  SplashScreen createState() => SplashScreen(); // inicia a tela pelo Splash para verificar se o usuário está logado
}