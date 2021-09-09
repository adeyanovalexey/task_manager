import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/use_cases/task_use_case.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';

abstract class TaskState extends Equatable{
  final Status status;
  TaskState(this.status);

  @override
  List<Object> get props => [status];
}

class StartState extends TaskState{
  StartState(Status status) : super(status);
}

class LoadingState extends TaskState{
  LoadingState(Status status) : super(status);
}

class DoneState extends TaskState{
  DoneState(Status status) : super(status);
}

class FailState extends TaskState{
  FailState(Status status) : super(status);
}

class TaskCubit extends Cubit<TaskState>{
  final TaskUseCase _taskUseCase;
  final UserUseCase _userUseCase;
  final FullTask? fullTask;

  TaskCubit(this._taskUseCase, this._userUseCase, this.fullTask) : super(StartState(Status.ToDo));

  Future<void> createTask(String name, String description) async{
    emit(LoadingState(state.status));
    User? user = _userUseCase.getUser();
    if(user != null){
      await _taskUseCase.addTask(name: name, description: description, idAuthor: user.getId);
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
    emit(LoadingState(state.status));
    User? user = _userUseCase.getUser();
    if(user != null){
      Task task = Task(id: id, name: name, description: description, idAuthor: user.getId, status: state.status);
      await _taskUseCase.updateTask(task);
      emit(DoneState(state.status));
    }
    else
      emit(FailState(state.status));
  }
}