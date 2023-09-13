import 'package:flutter/material.dart';
import '../Controller/task_controller.dart';
import '../Model/task_model.dart';

void addTask(BuildContext context, TaskController taskController,
    Function(List<Task>) updateTasks) {
  final TextEditingController controller = TextEditingController();

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
                taskController.addTask(taskDescription);
                updateTasks(taskController.tasks);
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
