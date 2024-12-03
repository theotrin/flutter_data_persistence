import 'package:project/components/task.dart';
import 'package:project/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT,'
      '$_difficulty INTEGER,'
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    print('Iniciando save...');
    final Database bancoDeDados = await getDatabase();

    var itemExists = await find(task.nome);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      print('A taréfa não existia');
      return await bancoDeDados.insert(
        _tablename,
        taskMap,
      );
    } else {
      print('A tarefa já existe...');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task task) {
    print('Convertendo tarefa em map');

    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = task.nome;
    mapaDeTarefas[_difficulty] = task.dificuldade;
    mapaDeTarefas[_image] = task.foto;

    print('Nosso mapa de tarefas: $mapaDeTarefas');

    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... Econtrado: $result');

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo lista de tarefas...');
    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }

    print('Lista de tarefas: $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String taskName) async {
    print('Acessando find...');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskName],
    );

    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String taskName) async {}
}
