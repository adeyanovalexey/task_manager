import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/use_cases/full_task_use_case.dart';

abstract class HomeState{
    //extends Equatable{
  final List<FullTask> toDoList;
  final List<FullTask> inProgressList;
  final List<FullTask> testingList;
  final List<FullTask> doneList;
  HomeState({required this.toDoList, required this.inProgressList, required this.testingList, required this.doneList});

  @override
  bool operator ==(Object other) {
    if(other is HomeState){
      HomeState homeState = other;
      print(homeState.toDoList.toString());
      print(homeState.inProgressList.toString());
      print(homeState.testingList.toString());
      print(homeState.doneList.toString());

      Function deepEq = const DeepCollectionEquality().equals;
      if(deepEq(toDoList, homeState.toDoList)){
        return true;
      }


      // if(deepEq(toDoList, homeState.toDoList) && deepEq(inProgressList, homeState.inProgressList)
      // && deepEq(testingList, homeState.testingList) && deepEq(doneList, homeState.doneList))
      //   return true;
    }
    return false;
  }
  @override
  int get hashCode => super.hashCode;
  // @override
  // List<Object> get props => [toDoList, inProgressList, testingList, doneList];


}

class StartHomeState extends HomeState{
  StartHomeState({required List<FullTask> toDoList, required List<FullTask> inProgressList, required List<FullTask> testingList, required List<FullTask> doneList})
      : super(toDoList: toDoList, inProgressList: inProgressList, testingList: testingList, doneList: doneList);

}
class DataUploadedState extends HomeState{
  DataUploadedState({required List<FullTask> toDoList, required List<FullTask> inProgressList, required List<FullTask> testingList, required List<FullTask> doneList})
      : super(toDoList: toDoList, inProgressList: inProgressList, testingList: testingList, doneList: doneList);
}
class LoadingErrorState extends HomeState{
  LoadingErrorState({required List<FullTask> toDoList, required List<FullTask> inProgressList, required List<FullTask> testingList, required List<FullTask> doneList})
      : super(toDoList: toDoList, inProgressList: inProgressList, testingList: testingList, doneList: doneList);
}

class HomeCubit extends Cubit<HomeState>{

  final FullTaskUseCase _fullTaskUseCase;
  HomeCubit(this._fullTaskUseCase) : super(StartHomeState(
    toDoList: [], inProgressList: [], testingList: [], doneList: [],));

  Future<void> downloadData() async{
    await _fullTaskUseCase.requestFullTaskLIst(); // Запрос списка задач с Firebase
    List<FullTask> toDoList = _fullTaskUseCase.getFullTaskList(Status.ToDo);
    List<FullTask> inProgressList = _fullTaskUseCase.getFullTaskList(Status.InProgress);
    List<FullTask> testingList = _fullTaskUseCase.getFullTaskList(Status.Testing);
    List<FullTask> doneList = _fullTaskUseCase.getFullTaskList(Status.Done);

    emit(DataUploadedState(
        toDoList: toDoList, inProgressList: inProgressList, testingList: testingList, doneList: doneList));
  }

  Future<void> addTask({required String name, required String description, required String idAuthor}) async{
    FullTask? newTask = await _fullTaskUseCase.addTask(name: name, description: description, idAuthor: idAuthor);
    List<FullTask> newToDoList = state.toDoList;

    if(newTask != null)
      state.toDoList.add(newTask);

    emit(DataUploadedState(
        toDoList: newToDoList, inProgressList: state.inProgressList, testingList: state.testingList, doneList: state.doneList));
  }
}