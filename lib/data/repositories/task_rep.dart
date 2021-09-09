import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/interfaces/repository/task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface{

  final String _path = 'task';
  FirebaseDatabaseService _firebaseDatabaseService;

  TaskRepository(this._firebaseDatabaseService);

  @override
  Future<void> addTask(Task task) async{
    await _firebaseDatabaseService.write(_path, task.toJson(false));
  }

  @override
  Future<List<Task>> getTaskList() async{
    Map taskMaps = await _firebaseDatabaseService.read(_path);
    List<Task> taskList = [];

    for(String keys in taskMaps.keys){
      Map<String, dynamic> taskMap = new Map<String, dynamic>.from(taskMaps[keys]);
      taskList.add(Task.fromJson(taskMap, id: keys));
    }
    return taskList;
  }

  @override
  Future<void> updateTask(Task task) async{
    final dbRefTask = FirebaseDatabase.instance.reference().child('task/' + task.getId);
    await dbRefTask.update(task.toJson(false));
  }
}