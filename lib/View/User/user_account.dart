import 'package:flutter/material.dart';
import 'package:mvc/Components/change_name_widget.dart';

import '../../Components/change_password_widget.dart';

class AccountUser extends StatelessWidget {
  const AccountUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  changePassword(context);
                },
                child: const Text('Alterar Senha'),
              ),
              ElevatedButton(
                onPressed: () {
                  changeName(context);
                },
                child: const Text('Alterar nome'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
