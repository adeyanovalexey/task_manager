import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/presentation/screens/home/cubit/home_cubit.dart';
import 'package:task_manager/presentation/screens/home/ui/task_widget.dart';
import 'package:task_manager/task_manager.dart';

class HomeScreen extends StatelessWidget{
  @override
  StatelessElement createElement(){
    HomeCubit.instance.downloadData();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<HomeCubit>(
        create: (_) => HomeCubit.instance,
        child: BlocBuilder<HomeCubit, HomeState>(
            bloc: HomeCubit.instance,
            builder: (context, snapshot){
              if(snapshot is DataUploadedState)
                return TabBarView(
                  children: [
                    Scaffold(body: getView(BlocProvider.of<HomeCubit>(context).state.toDoList),
                      floatingActionButton: getFloatingActionButton(context),),
                    getView(BlocProvider.of<HomeCubit>(context).state.inProgressList),
                    getView(BlocProvider.of<HomeCubit>(context).state.testingList),
                    getView(BlocProvider.of<HomeCubit>(context).state.doneList),
                  ],
                );
              else
                return Center(child: CircularProgressIndicator());
            }
        ));
  }

  Widget getView(List<FullTask> taskList){
    return Align(
      child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView.builder(
              itemCount: taskList.length,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemBuilder: (BuildContext context, int index){
                return Taskwidget(taskList.elementAt(index));
              }
          )),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      onPressed: (){
        TaskManager.goPage(TaskManager.taskPath, context);
      },
      child: Icon(Icons.add, color: Colors.white,),
      backgroundColor: Color.fromRGBO(29, 212, 243, 1),
    );
  }

}