import '../Model/task_model.dart';

abstract class TaskEvent {

}

class LoadTasks extends TaskEvent {
  LoadTasks();
}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final Task task;
  DeleteTask(this.task);
}

class ToggleTaskCompletion extends TaskEvent {
  final Task task;
  ToggleTaskCompletion(this.task);
}
