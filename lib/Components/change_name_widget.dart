import 'package:flutter/material.dart';
import 'package:mvc/Controller/user_controller.dart';

void changeName(BuildContext context) {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: BoxConstraints(maxWidth: 300.0),
            child: Column(
              children: [
                const Text('Alterar Nome'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerName,
                        decoration:
                            const InputDecoration(labelText: 'Novo Nome'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite o novo nome...';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controllerPassword,
                        decoration:
                            const InputDecoration(labelText: 'Senha Atual'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a senha...';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Faça algo quando o botão "Salvar" for pressionado
                          updateUser(controllerName.text, '', '',
                              controllerPassword.text);
                           // Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
