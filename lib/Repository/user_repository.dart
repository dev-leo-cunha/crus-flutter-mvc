import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/user_model.dart';

// REPOSITÓRIO PARA FAZER A REQUISIÇÃO A API PARA AUTENTICAÇÃO DE USUÁRIO
Future<User?> authenticate(String email, String password) async {
  const url = 'https://sistemaloginback-production.up.railway.app/login';
  final response = await http.post(
    Uri.parse(url),
    body: {'email': email, 'password': password},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    // Verifique se os campos necessários estão presentes no JSON antes de acessá-los
    if (responseData.containsKey('token') &&
        responseData.containsKey('email') &&
        responseData.containsKey('fullName')) {
      final String token = responseData['token'];
      final String userEmail = responseData['email'];
      final String userFullname = responseData['fullName'];

      final user = User(token: token, email: userEmail, fullName: userFullname);
      return user;
    } else {
      // Trate o caso em que os campos estão ausentes no JSONr
      return null;
    }
  } else {
    // Se a resposta não for 200 (OK), trate o erro de acordo com suas necessidades
    return null; // Ou lance uma exceção, dependendo do seu caso
  }
}

Future<Set<String>?> update(String newName, String newPassword,
    String newPasswordRepeat, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  Map<String, String> requestHeaders = {'Authorization': '$token'};
  const url = 'https://sistemaloginback-production.up.railway.app/update';
  final response = await http.put(Uri.parse(url),
      body: {
        'newName': newName,
        'newPassword': newPassword,
        'newPasswordRepeat': newPasswordRepeat,
        'password': password
      },
      headers: requestHeaders);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData.containsKey('token') &&
        responseData.containsKey('fullName')) {
      final String token = responseData['token'];
      final String newName = responseData['fullName'];
      return {token, newName};
    }
  }
  return {'', ' '};
}
