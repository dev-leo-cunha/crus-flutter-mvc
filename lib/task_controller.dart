import 'task_model.dart';

class TaskController {
  List<Task> tasks = [];

  void addTask(String title) {
    final newTask = Task(id: tasks.length + 1, title: title);
    tasks.add(newTask);
  }

  void toggleTaskCompletion(int taskId) {
    final task = tasks.firstWhere((t) => t.id == taskId);
    task.isCompleted = !task.isCompleted;
  }

  void deleteTask(int taskId) {
    tasks.removeWhere((t) => t.id == taskId);
  }
}
