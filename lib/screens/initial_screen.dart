import 'package:flutter/material.dart';
import 'package:nosso_primeiro_proj/components/global_level.dart';
import 'package:nosso_primeiro_proj/components/task.dart';
import 'package:nosso_primeiro_proj/data/task_dao.dart';
import 'package:nosso_primeiro_proj/data/task_inherited.dart';
import 'package:nosso_primeiro_proj/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.add_task),
        title: const Text('Flutter: Primeiros Passos'),
        bottom: GlobalLevel(TaskInherited.of(context).taskList),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.5),
            child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.cached_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDAO().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );

                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            return tarefa;
                          });
                    }
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // não implementado em vídeo por descuido meu, desculpem.
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // essa linha de layout deixa o conteudo totalmente centralizado.
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Não há nenhuma Tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ));
                  }
                  return const Text('Erro ao carregar tarefas');
              }
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 150),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(
                  taskContext: context,
                ),
              ),
            ).then((value) => setState(() {
                  print('Recarregando a tela inicial');
                }));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
