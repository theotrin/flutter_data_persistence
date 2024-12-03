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

  save(Task task) async {}
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

  Future<List<Task>> find(String taskName) async {}
  delete(String taskName) async {}
}
