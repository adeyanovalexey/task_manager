import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/usecase/full_task_use_case_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/task_use_case_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';

class FullTaskUseCase implements FullTaskUseCaseInterface{
  final UserUseCaseInterface _userUseCaseInterface;
  final TaskUseCaseInterface _taskUseCaseInterface;

  FullTaskUseCase(this._userUseCaseInterface, this._taskUseCaseInterface);

  List<FullTask> _fullTaskList = [];

  Future<void> requestFullTaskLIst() async {
    _fullTaskList.clear();
    List<Task> taskList = await _taskUseCaseInterface.getTaskList();
    for(Task task in taskList){
      User? user = await _userUseCaseInterface.getUserById(task.getIdAuthor);
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
    User? user = await _userUseCaseInterface.getUserById(idAuthor);
    if(user != null){
      Task task = await _taskUseCaseInterface.addTask(name: name, description: description, idAuthor: idAuthor);
      FullTask fullTask = FullTask(id: task.getId, name: task.getName, description: task.getDescription,
          nameAuthor: user.getName + ' ' + user.getSurname, status: task.getStatus);
      return fullTask;
    }
    else
      return null;
  }
}