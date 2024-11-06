import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Model/task_model.dart';

class DBHelper {
  static Database? _database;

  // Initialize the database
  static Future<Database> initializeDB() async {
    if (_database != null) return _database!;

    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          isCompleted INTEGER
        )
      ''');
    });
  }

  // Insert a task into the database
  static Future<int> insertTask(Task task) async {
    final db = await initializeDB();
    return await db.insert('tasks', task.toMap());
  }

  // Get all tasks
  static Future<List<Task>> getTasks() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // Update a task
  static Future<int> updateTask(Task task) async {
    final db = await initializeDB();
    return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // Delete a task
  static Future<int> deleteTask(int? id) async {
    final db = await initializeDB();
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
