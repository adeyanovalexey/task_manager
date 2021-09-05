import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/presentation/screens/main/ui/main_screen.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/task_screen/cubit/task_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';

class TaskScreen extends StatelessWidget{

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();
  final TextEditingController authorEditingController = TextEditingController();
  final TextEditingController statusEditingController = TextEditingController();

  final List<String> statusStrList = ['ToDO', 'InProgress', 'Testing', 'Done'];
  static const String ROUTE_NAME = "task_screen";


  void setTextEditingController(FullTask? task){
    if(task != null){
      nameEditingController.text = task.getName;
      descriptionEditingController.text = task.getDescription;
      authorEditingController.text = task.getNameAuthor;
      statusEditingController.text = task.getName;
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
    setTextEditingController(taskCubit.fullTask);
    return BlocBuilder<TaskCubit, TaskState>(
        bloc: taskCubit,
        builder: (context, snapshot){
          GlobalKey<FormState> _key = GlobalKey<FormState>();
          return Form(
              key: _key,
              child:Container(
                  color: Theme.of(context).backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Привычка', style: Theme.of(context).textTheme.headline2,),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      TextFormField(
                        enabled: taskCubit.fullTask != null ? false : true,
                        validator: Validator.validateName,
                        controller: nameEditingController,
                        style: Theme.of(context).textTheme.headline1,
                        decoration: new InputDecoration(
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                          counterStyle: Theme.of(context).textTheme.headline1,
                          labelStyle: Theme.of(context).textTheme.headline1,
                          labelText: "Название",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),),
                        onChanged: (value){

                        },),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: Validator.validateName,
                        enabled: taskCubit.fullTask != null ? false : true,
                        controller: descriptionEditingController,
                        style: Theme.of(context).textTheme.headline1,
                        decoration: new InputDecoration(
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                          counterStyle: Theme.of(context).textTheme.headline1,
                          labelStyle: Theme.of(context).textTheme.headline1,
                          labelText: "Описание",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),),
                        onChanged: (value){},),
                      SizedBox(height: 10),
                      taskCubit.fullTask != null ?
                      TextField(
                        enabled: false,
                        controller: authorEditingController,
                        style: Theme.of(context).textTheme.headline1,
                        decoration: new InputDecoration(
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                          counterStyle: Theme.of(context).textTheme.headline1,
                          labelStyle: Theme.of(context).textTheme.headline1,
                          labelText: "Автор",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),),
                        onChanged: (value){},) : Container(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Статус', style: Theme.of(context).textTheme.headline1,),
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            value: getStrStatus(BlocProvider.of<TaskCubit>(context).state.status),
                            elevation: 8,
                            isDense: false,
                            dropdownColor: Colors.blue,
                            icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                            items: statusStrList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value, style: Theme.of(context).textTheme.headline1,),
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
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).buttonColor,
                                  minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                              ),
                              onPressed: () => PathManager.goPage(MainScreen.ROUTE_NAME, context)),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            child: Text('Сохранить',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).buttonColor,
                                minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                            ),
                            onPressed: () async{
                              if(_key.currentState!.validate() && !(BlocProvider.of<TaskCubit>(context).state is LoadingState)){
                                if(taskCubit.fullTask != null)
                                  await BlocProvider.of<TaskCubit>(context).updateTask(
                                      taskCubit.fullTask!.getId, taskCubit.fullTask!.getName, taskCubit.fullTask!.getDescription);
                                else
                                  await BlocProvider.of<TaskCubit>(context).createTask(nameEditingController.text,
                                      descriptionEditingController.text);
                                PathManager.goPage(MainScreen.ROUTE_NAME, context);
                              }
                            },),
                        ],)
                    ],
                  )
              ));
        });}

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