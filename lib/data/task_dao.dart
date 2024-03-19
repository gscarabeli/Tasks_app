import 'package:nosso_primeiro_proj/components/task.dart';
import 'package:nosso_primeiro_proj/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      '$_level INTEGER)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _level = 'level';

  save(Task task) async {
    print('Iniciando o save: ');
    final Database dataBase = await getDatabase();

    var itemExists = await find(task.nome);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      print('a Tarefa não Existia.');
      return await dataBase.insert(_tablename, taskMap);
    } else {
      print('a Tarefa existia!');
      return await dataBase.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.nome],
      );
    }
  }

  Future<List<Task>> find(String taskName) async {
    print('Acessando find: ');

    final Database dataBase = await getDatabase();
    print('Procurando tarefa com o nome: $taskName');
    final List<Map<String, dynamic>> result = await dataBase
        .query(_tablename, where: '$_name = ?', whereArgs: [taskName]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database dataBase = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBase.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  delete(String taskName) async {
    print('Deletando tarefa: $taskName');

    final Database dataBase = await getDatabase();

    return await dataBase.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
  }

  Map<String, dynamic> toMap(Task task) {
    print('Convertendo to Map: ');

    final Map<String, dynamic> mappedTask = Map();
    mappedTask[_name] = task.nome;
    mappedTask[_difficulty] = task.dificuldade;
    mappedTask[_image] = task.img;
    mappedTask[_level] = task.nivel;
    print('Mapa de Tarefas: $mappedTask');

    return mappedTask;
  }

  List<Task> toList(List<Map<String, dynamic>> mappedTasks) {
    print('Convertendo to List: ');
    final List<Task> tasks = [];

    for (Map<String, dynamic> row in mappedTasks) {
      final Task task = Task(
        row[_name],
        row[_image],
        row[_difficulty],
        row[_level]
      );
      tasks.add(task);
    }

    print('Tarefa listadas: $tasks');
    return tasks;
  }
}
