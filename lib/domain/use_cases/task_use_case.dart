import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/domain/entities/task.dart';

class TaskUseCase{

  TaskUseCase(this._taskRepository);
  final TaskRepository _taskRepository;

  Future<List<Task>> getTaskList() async{
    List<Task> _taskList =  await _taskRepository.getTaskList();
    return _taskList;
  }

  Future<Task> addTask({required name, required description, required idAuthor}) async{
    Task newTask = Task.newTask(name: name, description: description, idAuthor: idAuthor,
        status: Status.ToDo);
    await _taskRepository.addTask(newTask);
    return newTask;
  }
}