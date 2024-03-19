import 'package:flutter/material.dart';
import 'package:nosso_primeiro_proj/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, 0),
    Task('Andar de Bike', 'assets/images/cycling.jpg', 2, 0),
    Task('Meditar', 'assets/images/meditating.jpeg', 5, 0),
    Task('Ler', 'assets/images/reading.jpg', 1, 0),
    Task('Jogar', 'assets/images/playing.jpg', 1, 0),
  ];

  void newTask(String name, String image, int difficulty, int level) {
    taskList.add(Task(name, image, difficulty, level));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  // oldWidget => Estado anterior da nossa lista
  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
