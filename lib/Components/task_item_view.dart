import 'package:flutter/material.dart';
import '../Controller/task_controller.dart';
import '../Model/task_model.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final TaskController taskController;
  final Function(List<Task>) updateTasks;

  const TaskListView({
    Key? key,
    required this.tasks,
    required this.taskController,
    required this.updateTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: Key(task.id.toString()),
          direction:
              DismissDirection.endToStart,
          background: Container(
            color: Colors.red, 
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            taskController.deleteTask(task.id);
            updateTasks(tasks);
          },
          child: ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                taskController.toggleTaskCompletion(task.id);
                updateTasks(tasks);
              },
            ),
          ),
        );
      },
    );
  }
}
