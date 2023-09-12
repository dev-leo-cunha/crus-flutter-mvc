import 'package:flutter/material.dart';

import '../Controller/task_controller.dart';
import '../Model/task_model.dart';


// WIDGET DE CADA TAREFA;
class TaskListView extends StatelessWidget {
  final List<Task> tasks; // Lista de tarefas
  final TaskController taskController; // controlador
  final Function(List<Task>) updateTasks; // Função de atualização

  const TaskListView({
    super.key,
    required this.tasks,
    required this.taskController,
    required this.updateTasks,
  });

  // WIDGET PARA LISTA DE TAREFAS
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              // COLOCA A TAREFA COMO CONCLUIDA OU NÃO
              taskController.toggleTaskCompletion(task.id);
              updateTasks(tasks);
            },
          ),
          onLongPress: () {
            _showDeleteTaskDialog(context, task);
          },
        );
      },
    );
  }

// WIDGET PARA CONFIRMAR EXCLUSAO DA TAREFA
  void _showDeleteTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Tarefa'),
          content: Text('Deseja realmente excluir a tarefa "${task.title}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                taskController.deleteTask(task.id);
                // Remove a tarefa da lista e chama a função de atualização
                tasks.remove(task);
                updateTasks(tasks);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
