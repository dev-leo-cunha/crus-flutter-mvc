import 'dart:convert';
import 'package:http/http.dart' as http;
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
