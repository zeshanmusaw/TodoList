import 'package:flutter/material.dart';
import 'package:todolist/db/dbhelper.dart';
import '../Model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Fetch tasks from the database
  Future<void> loadTasks() async {
    _tasks = await DBHelper.getTasks();
    notifyListeners();
  }
  Future<List<Task>> getTasks() async {
    try {
      // Replace with actual database call to fetch tasks
      final taskList = await DBHelper.getTasks();
      _tasks = taskList; // Update the internal list
      notifyListeners(); // Notify listeners if needed
      return _tasks;
    } catch (e) {
      throw Exception("Failed to load tasks");
    }
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    await DBHelper.insertTask(task);
    loadTasks(); // Reload tasks after adding
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await DBHelper.updateTask(task);
    loadTasks(); // Reload tasks after updating
  }


  // Delete a task
  Future<void> deleteTask(Task task) async {
    await DBHelper.deleteTask(task.id);
    loadTasks(); // Reload tasks after deleting
  }
}
