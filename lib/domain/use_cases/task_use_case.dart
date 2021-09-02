import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/domain/entities/task.dart';

class TaskUseCase{

  TaskUseCase._privateConstructor();
  static final TaskUseCase _instance = TaskUseCase._privateConstructor();
  static TaskUseCase get instance => _instance;

  final TaskRepository _taskRepository = TaskRepository.instance;

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