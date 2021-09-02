import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/entities/task.dart';

abstract class TaskRepositoryInterface{
  Future<List<Task>> getTaskList();
  void addTask(Task task);
  Future<void> updateTask(Task task);
}

class TaskRepository implements TaskRepositoryInterface{

  TaskRepository._privateConstructor() : super();
  static final TaskRepository _instance = TaskRepository._privateConstructor();
  static TaskRepository get instance => _instance;

  final String _path = 'task';
  FirebaseDatabaseService _firebaseDatabaseService = FirebaseDatabaseService.instance;

  @override
  Future<void> addTask(Task task) async{
    _firebaseDatabaseService.write(_path, task.toJson(false));
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