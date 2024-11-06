import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/Model/task_model.dart';
import 'package:todolist/Provider/taskprovider.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskProvider taskProvider;
  TaskBloc({required this.taskProvider}) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      try {
        // Make sure you're getting the tasks properly from the provider
        final tasks = await taskProvider.getTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError("Failed to load tasks"));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await taskProvider.addTask(event.task);
        add(LoadTasks());  // Reload tasks after adding a new task
      } catch (e) {
        emit(TaskError("Failed to add task"));
      }
    });


    on<UpdateTask>((event, emit) async {
      try {
        await taskProvider.updateTask(event.task);
        final tasks = await taskProvider.getTasks(); // Fetch updated list
        emit(TaskLoaded(tasks)); // Emit updated list directly
      } catch (e) {
        emit(TaskError("Failed to update task"));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskProvider.deleteTask(event.task);
        add(LoadTasks());  // Reload tasks after deleting a task
      } catch (e) {
        emit(TaskError("Failed to delete task"));
      }
    });

    on<ToggleTaskCompletion>((event, emit) async {
      try {
        event.task.isCompleted = !event.task.isCompleted;
        await taskProvider.updateTask(event.task);
        final tasks = await taskProvider.getTasks(); // Fetch updated list
        emit(TaskLoaded(tasks)); // Emit updated list directly
      } catch (e) {
        emit(TaskError("Failed to toggle task completion"));
      }
    });
  }
}
