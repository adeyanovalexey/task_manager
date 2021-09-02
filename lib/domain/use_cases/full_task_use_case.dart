import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';
import 'package:task_manager/domain/use_cases/task_use_case.dart';

class FullTaskUseCase {
  final UserUseCase _userUseCase;
  final TaskUseCase _taskUseCase;

  FullTaskUseCase(this._userUseCase, this._taskUseCase);

  List<FullTask> _fullTaskList = [];

  Future<void> requestFullTaskLIst() async {
    _fullTaskList.clear();
    List<Task> taskList = await _taskUseCase.getTaskList();
    for(Task task in taskList){
      User? user = await _userUseCase.getUser(task.getIdAuthor);
      String nameAuthor = user != null ? user.getName + " " +
          user.getSurname : "Нет данных";
      FullTask fullTask = FullTask(id: task.getId,
          name: task.getName,
          description: task.getDescription,
          nameAuthor: nameAuthor,
          status: task.getStatus);
      _fullTaskList.add(fullTask);
    }
  }

  List<FullTask> getFullTaskList(Status status){
    List<FullTask> fullTaskListByStatus = [];
    for (FullTask fullTask in _fullTaskList) {
      if (fullTask.getStatus == status) {
        fullTaskListByStatus.add(fullTask);
      }
    }
    return fullTaskListByStatus;
  }

  Future<FullTask?> addTask({required name, required description, required idAuthor}) async {
    User? user = await _userUseCase.getUser(idAuthor);
    if(user != null){
      Task task = await _taskUseCase.addTask(name: name, description: description, idAuthor: idAuthor);
      FullTask fullTask = FullTask(id: task.getId, name: task.getName, description: task.getDescription,
          nameAuthor: user.getName + ' ' + user.getSurname, status: task.getStatus);
      return fullTask;
    }
    else
      return null;
  }
}