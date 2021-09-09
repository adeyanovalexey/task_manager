import 'package:task_manager/domain/entities/task.dart';

abstract class TaskRepositoryInterface{
  Future<List<Task>> getTaskList();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
}