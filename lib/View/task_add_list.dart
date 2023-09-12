import 'package:flutter/material.dart';
import 'package:mvc/View/user_location.dart';
import '../Controller/location_controller.dart';
import '../Controller/task_controller.dart';
import '../Controller/user_controller.dart';
import 'task_list_view.dart';
import '../Model/task_model.dart';

// WIDGET PARA EXIBIÇÃO DAS TAREFAS E BOTAO DE ADICIONAR
class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  TarefasState createState() => TarefasState();
}

class TarefasState extends State<Tarefas> {
  final TaskController _taskController = TaskController();
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
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
          updateTasks: _updateTasks, // Passa a função de atualização
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _addTask(context);
              },
              child: const Icon(Icons.add_rounded),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const UserLocation(), // Substitua por sua tela principal
                    ),
                  );
                },
                child: const Text('Pegar Localização do usuário'))
          ],
        ),
      ),
    );
  }

  void _addTask(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    // WIDGET PARA ADICIONAR TAREFA
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Descrição da tarefa'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final taskDescription = controller.text;
                if (taskDescription.isNotEmpty) {
                  _taskController.addTask(taskDescription);
                  _updateTasks(_taskController.tasks);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para atualizar as tarefas
  void _updateTasks(List<Task> updatedTasks) {
    setState(() {
      _tasks = updatedTasks;
    });
  }
}
