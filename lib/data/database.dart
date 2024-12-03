import 'package:project/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');//encontrar o caminho do banco de dados
  return openDatabase(
    path,
    onCreate: (db, version) { //criar banco caso ele não exista
      db.execute(TaskDao.tableSql);
    },
    version: 1,
  );
}
