import 'package:flutter/material.dart';

class Maestry extends StatelessWidget {
  final int maestryLevel;

  const Maestry({required this.maestryLevel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (maestryLevel == 0)
              ? Colors.blue
              : maestryLevel == 1
                  ? Colors.green
                  : maestryLevel == 2
                      ? Colors.yellow
                      : maestryLevel == 3
                          ? Colors.orange
                          : maestryLevel == 4
                              ? Colors.redAccent
                              : maestryLevel == 5
                                  ? Colors.pink
                                  : maestryLevel > 5
                                      ? Colors.black
                                      : Colors.blue),
      height: 140,
    );
  }
}
