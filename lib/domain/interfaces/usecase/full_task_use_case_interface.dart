import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';

abstract class FullTaskUseCaseInterface{
  Future<void> requestFullTaskLIst();
  List<FullTask> getFullTaskList(Status status);
  Future<FullTask?> addTask({required name, required description, required idAuthor});
}