import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/entities/user.dart';

abstract class TaskState{
  Status status;
  TaskState(this.status);
}

class StartState extends TaskState{
  StartState(Status status) : super(status);
}

class DoneState extends TaskState{
  DoneState(Status status) : super(status);
}

class FailState extends TaskState{
  FailState(Status status) : super(status);
}

class TaskCubit extends Cubit<TaskState>{
  TaskCubit._privateConstructor() : super(StartState(Status.ToDo));
  static final TaskCubit _instance = TaskCubit._privateConstructor();
  static TaskCubit get instance => _instance;

  TaskRepository _taskRepository = TaskRepository.instance;
  UserRepository _userRepository = UserRepository.instance;

  TaskCubit() : super(StartState(Status.ToDo));

  void createTask(String name, String description) async{
    User? user = await _userRepository.getCurrentUser();
    if(user != null){
      Task newTask = Task.newTask(name: name, description: description, status: state.status, idAuthor: user.getId);
      await _taskRepository.addTask(newTask);
      emit(DoneState(state.status));
    }
    else
      emit(FailState(state.status));
  }

  setStatus(Status status){
    if(state is StartState)
      emit(StartState(status));
    else if(state is DoneState)
      emit(DoneState(status));
    else
      emit(FailState(status));
  }

  Future<void> updateTask(String id, String name, String description) async{
    User? user = await _userRepository.getCurrentUser();
    if(user != null){
      Task task = Task(id: id, name: name, description: description, idAuthor: user.getId, status: state.status);
      await _taskRepository.updateTask(task);
      emit(DoneState(state.status));
    }
    else
      emit(FailState(state.status));
  }
}