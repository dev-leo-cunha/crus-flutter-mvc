import 'package:flutter/material.dart';

void changePassword(BuildContext context) {
  final TextEditingController controller = TextEditingController();
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
                const Text('Alterar Senha'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller,
                        decoration:
                            const InputDecoration(labelText: 'Nova senha'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a senha...';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                            labelText: 'Repita a nova senha'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a senha...';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller,
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
                          Navigator.of(context).pop();
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
