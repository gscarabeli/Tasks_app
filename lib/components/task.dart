import 'package:flutter/material.dart';
import 'package:nosso_primeiro_proj/components/difficulty.dart';
import 'package:nosso_primeiro_proj/components/maestry.dart';
import 'package:nosso_primeiro_proj/data/task_dao.dart';

class Task extends StatefulWidget {
  final String nome;
  final String img;
  final int dificuldade;
  int nivel = 0;

  Task(this.nome, this.img, this.dificuldade, this.nivel, {Key? key})
      : super(key: key);

  double dificuldadePorNivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int maestria = 0;

  bool assetOrNetwotk() {
    if (widget.img.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Maestry(maestryLevel: maestria),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: assetOrNetwotk()
                            ? Image.asset(widget.img, fit: BoxFit.cover)
                            : Image.network(
                                widget.img,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Difficulty(
                          difficultyLevel: widget.dificuldade,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: const [
                                        Text('Deletar'),
                                        Icon(Icons.delete_forever)
                                      ],
                                    ),
                                    content: const Text(
                                        'Tem certeza de que deseja deletar essa Tarefa?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Não'),
                                          child: const Text('Não')),
                                      TextButton(
                                          onPressed: () {
                                            TaskDAO().delete(widget.nome);
                                            Navigator.pop(context, 'Sim');
                                          },
                                          child: const Text('Sim')),
                                    ],
                                  );
                                });
                          },
                          onPressed: () {
                            setState(() {
                              if ((widget.nivel / widget.dificuldade) / 10 <
                                  1) {
                                widget.nivel++;
                                widget.dificuldadePorNivel =
                                    widget.dificuldade / widget.nivel;
                              } else if ((widget.nivel / widget.dificuldade) /
                                          10 ==
                                      1 &&
                                  maestria == 6) {
                                maestria = 6;
                              } else {
                                widget.nivel = 0;
                                maestria++;
                              }
                            });
                            // print(nivel);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Nível: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
