import 'package:flutter/material.dart';
import 'package:mvc/Components/mapWidget.dart';
import 'package:mvc/View/User/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/user_controller.dart';
import 'Task/task_list_tarefas.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  String userName = '';
  String fullName = '';
  Future<void> getUser() async {
    SharedPreferences _SharedPreferences =
        await SharedPreferences.getInstance();
    fullName = _SharedPreferences.getString('fullName') ?? '';

    setState(() {
      userName = fullName.split(' ')[0];
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                logout(context);
              }),
          bottom: TabBar(
            tabs: <Widget>[
              const Tab(
                icon: Icon(Icons.map_outlined),
                text: 'Mapa',
              ),
              const Tab(
                icon: Icon(Icons.task_alt_outlined),
                text: 'Tarefas',
              ),
              Tab(
                icon: const Icon(Icons.account_circle_rounded),
                text: userName,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              child: MapWidget(),
            ),
            Center(
              child: Tarefas(),
            ),
            Center(
              child: AccountUser(),
            ),
          ],
        ),
      ),
    );
  }
}
