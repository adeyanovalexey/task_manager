import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/presentation/screens/task_screen/cubit/task_cubit.dart';
import 'package:task_manager/task_manager.dart';

class TaskScreen extends StatelessWidget{
  final FullTask? task;
  final TaskCubit cubit = TaskCubit.instance;

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();
  final TextEditingController authorEditingController = TextEditingController();
  final TextEditingController statusEditingController = TextEditingController();

  TaskScreen(this.task);
  final List<String> statusStrList = ['ToDO', 'InProgress', 'Testing', 'Done'];


  @override
  StatelessElement createElement() {
    if(task != null){
      nameEditingController.text = task!.getName;
      descriptionEditingController.text = task!.getDescription;
      authorEditingController.text = task!.getNameAuthor;
      statusEditingController.text = task!.getName;
    }
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<TaskCubit>(
        create: (_) => cubit,
        child: BlocBuilder<TaskCubit, TaskState>(
            bloc:   cubit,
            builder: (context, snapshot){
              return Form(
                  child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            enabled: task != null ? false : true,
                            controller: nameEditingController,
                            decoration: new InputDecoration(
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Название",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){

                            },),
                          SizedBox(height: 10),
                          TextField(
                            enabled: task != null ? false : true,
                            controller: descriptionEditingController,
                            decoration: new InputDecoration(
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Описание",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),
                          SizedBox(height: 10),
                          task != null ?
                          TextField(
                            enabled: false,
                            controller: authorEditingController,
                            decoration: new InputDecoration(
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Автор",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},) : Container(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Статус', style: TextStyle(fontSize: 17),),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: getStrStatus(BlocProvider.of<TaskCubit>(context).state.status),
                                elevation: 8,
                                isDense: false,
                                dropdownColor: Colors.blue,
                                items: statusStrList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                    onTap: (){
                                      BlocProvider.of<TaskCubit>(context).setStatus(getCurrentStatus(value));
                                    },
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ],),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  child: Text('Отмена',
                                    style: TextStyle(fontSize: 17, color: Colors.white, ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                                  ),
                                  onPressed: () => TaskManager.goPage(TaskManager.homePath, context)),
                              SizedBox(width: 20,),
                              ElevatedButton(
                                child: Text('Сохранить',
                                  style: TextStyle(fontSize: 17, color: Colors.white, ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                                ),
                                onPressed: () async{
                                  if(task != null)
                                    BlocProvider.of<TaskCubit>(context).updateTask(
                                        task!.getId, task!.getName, task!.getDescription);
                                  else
                                    BlocProvider.of<TaskCubit>(context).createTask(nameEditingController.text,
                                        descriptionEditingController.text);
                                  TaskManager.goPage(TaskManager.homePath, context);
                                },),
                            ],)
                        ],
                      )
                  ));
            }));}

  Status getCurrentStatus(String value){
    if(statusStrList.elementAt(0).contains(value))
      return Status.ToDo;
    else if(statusStrList.elementAt(1).contains(value))
      return Status.InProgress;
    else if(statusStrList.elementAt(2).contains(value))
      return Status.Testing;
    else if(statusStrList.elementAt(3).contains(value))
      return Status.Done;
    else
      return Status.ToDo;
  }

  String getStrStatus(Status status){
    switch(status){
      case Status.ToDo:
        return statusStrList.elementAt(0);
      case Status.InProgress:
        return statusStrList.elementAt(1);
      case Status.Testing:
        return statusStrList.elementAt(2);
      case Status.Done:
        return statusStrList.elementAt(3);
      default:
        return statusStrList.elementAt(0);
    }
  }
}