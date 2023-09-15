import 'package:flutter/material.dart';
import '../../Controller/task_controller.dart';
import 'task_add.dart';
import '../../Components/task_item_view.dart';
import '../../Model/task_model.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({Key? key}) : super(key: key);

  @override
  TarefasState createState() => TarefasState();
}

class TarefasState extends State<Tarefas> {
  final TaskController _taskController = TaskController();
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    // Chame updateTasks aqui, dentro do método build
    updateTasks(_taskController.tasks);

    return Scaffold(
      body: _tasks.isEmpty
          ? const Center(
              child: Text("Não há tarefas para fazer"),
            )
          : TaskListView( //Componente que exibe a lista de tarefas
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
        ],
      ),
    );
  }

  void updateTasks(List<Task> updatedTasks) {
    setState(() {
      _tasks = updatedTasks;
    });
  }
}
