import 'package:flutter/material.dart';
import '../../Controller/task_controller.dart';
import '../../Model/task_model.dart';

void addTask(BuildContext context, TaskController taskController,
    Function(List<Task>) updateTasks) {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adicione a nova Tarefa'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Descrição da tarefa'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite a descrição da tarefa.';
              }
              return null;
            },
          ),
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
              if (_formKey.currentState!.validate()) {
                final taskDescription = controller.text;
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
