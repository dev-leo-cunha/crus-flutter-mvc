import 'package:flutter/material.dart';
import 'package:mvc/View/user_location.dart';
import '../Controller/location_controller.dart';
import '../Controller/task_controller.dart';
import '../Controller/user_controller.dart';
import 'task_add.dart';
import 'task_list_view.dart';
import '../Model/task_model.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({Key? key}) : super(key: key);

  @override
  TarefasState createState() => TarefasState();
}

class TarefasState extends State<Tarefas> {
  final TaskController _taskController = TaskController();
  List<Task> _tasks = [];
  LocationController locationController = LocationController();

  @override
  Widget build(BuildContext context) {
    // Chame updateTasks aqui, dentro do método build
    updateTasks(_taskController.tasks);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                logout(context);
              }),
        ),
        body: TaskListView(
          tasks: _tasks,
          taskController: _taskController,
          updateTasks: updateTasks,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                addTask(context, _taskController, updateTasks);
              },
              child: const Icon(Icons.add_rounded),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const UserLocation(),
                    ),
                  );
                },
                child: const Text('Pegar Localização do usuário'))
          ],
        ),
      ),
    );
  }

  void updateTasks(List<Task> updatedTasks) {
    setState(() {
      _tasks = updatedTasks;
    });
  }
}
