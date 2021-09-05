import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/presentation/screens/home/cubit/task_widget_cubit.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/task_screen/ui/task_screen.dart';

class Taskwidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    FullTask task = BlocProvider.of<TaskWidgetCubit>(context).fullTask;
    return BlocBuilder<TaskWidgetCubit, TaskWidgetCubitState>(
        bloc: BlocProvider.of<TaskWidgetCubit>(context),
        builder: (context, snapshot){
          return InkWell(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.only(top: 1),
                  child: Card(
                      color: Theme.of(context).cardColor,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        task.getName,
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                      alignment: Alignment.centerLeft,),
                                    Container(child: Text(
                                      task.getNameAuthor,
                                      style: TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                      alignment: Alignment.centerLeft,),
                                  ],
                                ),
                                Container(child: IconButton(icon: Icon(Icons.info), color: Colors.white, onPressed: (){
                                  PathManager.goPage(TaskScreen.ROUTE_NAME, context, task);
                                },),)
                              ]))
                  )));
        });

  }

}