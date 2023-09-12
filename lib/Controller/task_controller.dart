import '../Model/task_model.dart';


// CONTROLLER PARA ADICIONAR, MARCAR COMO FEITA E EXCLUIR TAREFAS
class TaskController {
  List<Task> tasks = [];

  void addTask(String title) {
    final newTask =
        Task(id: tasks.length + 1, title: title);
    tasks.add(newTask);
  }

  void toggleTaskCompletion(int taskId) {
    Task task = tasks.firstWhere((t) => t.id == taskId);
    task.isCompleted = !task.isCompleted;
  }

  void deleteTask(int taskId) {
    tasks.removeWhere((t) => t.id == taskId);
  }
}
