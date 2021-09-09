import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/interfaces/repository/task_repository_interface.dart';

class TaskRepositoryTest implements TaskRepositoryInterface{
  TaskRepositoryTest();
  TaskRepositoryTest.setTaskList(this._taskList);

  List<Task> _taskList = [];

  @override
  Future<void> addTask(Task task) async{
    _taskList.add(task);
  }

  @override
  Future<List<Task>> getTaskList() async{
    return _taskList;
  }

  @override
  Future<void> updateTask(Task task) async{
    for(int i = 0; i < _taskList.length; i++){
      if(_taskList.elementAt(0).getId.compareTo(task.getId) == 0){
        _taskList.removeAt(i);
        _taskList.add(task);
      }
    }
  }
}