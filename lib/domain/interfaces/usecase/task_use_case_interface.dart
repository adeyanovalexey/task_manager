import 'package:task_manager/domain/entities/task.dart';

abstract class TaskUseCaseInterface{
  Future<List<Task>> getTaskList();
  Future<Task> addTask({required name, required description, required idAuthor});
  Future<void> updateTask(Task task);
}