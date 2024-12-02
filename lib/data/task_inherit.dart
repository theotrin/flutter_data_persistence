import 'package:flutter/material.dart';
import 'package:project/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  final List<Task> taskList = [
    Task('Estudar Flutter', 'assets/images/dash.png', 3),
    Task('Andar de Bike', 'assets/images/bike.webp', 2),
    Task('Ler 50 páginas', 'assets/images/livro.jpg', 1),
    Task('Meditar', 'assets/images/meditar.jpeg', 4),
    Task('Jogar', 'assets/images/jogar.jpg', 0),
  ];

  void addTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  final Widget child;

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
