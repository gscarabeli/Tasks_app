import 'package:flutter/material.dart';
import 'package:nosso_primeiro_proj/components/task.dart';

class GlobalLevel extends StatefulWidget implements PreferredSizeWidget {
  List<Task> taskList;

  GlobalLevel(this.taskList, {Key? key}) : super(key: key);

  @override
  State<GlobalLevel> createState() => _GlobalLevelState();

  @override
  Size get preferredSize => const Size.fromHeight(12.5);
}

class _GlobalLevelState extends State<GlobalLevel> {
  double sumTaskLevels() {
    double globalLevel = 0;
    for (var element in widget.taskList) {
      globalLevel += element.nivel;
    }
    return globalLevel;
  }

  double sumTaskDifficulties() {
    double globalDifficulty = 0;
    for (var element in widget.taskList) {
      globalDifficulty += element.dificuldade;
    }
    return globalDifficulty;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(12.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 8),
              child: SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  color: Colors.white,
                  value: (sumTaskDifficulties() > 0)
                      ? (sumTaskLevels() / sumTaskDifficulties()) / 10
                      : 1,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
              child: Text(
                'Nível: ${(sumTaskLevels() / sumTaskDifficulties() * 10).toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
