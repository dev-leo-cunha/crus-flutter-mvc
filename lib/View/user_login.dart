import 'package:flutter/material.dart';
import '../Controller/user_controller.dart';

// WIDGET DE LOGIN
class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  UserLoginState createState() => UserLoginState();
}

class UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'exemplo@exemplo.com',
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewPassword,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha...',
                      suffixIcon: IconButton(
                          icon: Icon(viewPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              viewPassword = !viewPassword;
                            });
                          })),
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Senha inválida';
                    }
                    return null;
                  }),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(context, _emailController.text,
                        _passwordController.text);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
