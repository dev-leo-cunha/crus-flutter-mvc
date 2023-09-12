import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'task_controller.dart';
import 'task_model.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TaskController _taskController = TaskController();
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas'),
        ),
        body: TaskListView(
          tasks: _tasks,
          taskController: _taskController,
          updateTasks: _updateTasks, // Passa a função de atualização
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addTask(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addTask(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: TextField(
            controller: _controller,
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
                final taskDescription = _controller.text;
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

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final TaskController taskController;
  final Function(List<Task>) updateTasks; // Função de atualização

  const TaskListView({
    super.key,
    required this.tasks,
    required this.taskController,
    required this.updateTasks,
  });

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
              taskController.toggleTaskCompletion(task.id);
              task.isCompleted = value!;
              // Chama a função de atualização para atualizar a lista
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
