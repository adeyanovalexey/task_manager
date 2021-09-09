import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/interfaces/repository/task_repository_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/task_use_case_interface.dart';

class TaskUseCase implements TaskUseCaseInterface{

  TaskUseCase(this._taskRepository);
  final TaskRepositoryInterface _taskRepository;

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

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
  }
}