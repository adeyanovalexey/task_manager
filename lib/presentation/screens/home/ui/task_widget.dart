import 'package:flutter/material.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/task_manager.dart';

class Taskwidget extends StatelessWidget{

  final FullTask task;
  Taskwidget(this.task);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(top: 1),
            child: Card(
                color: Colors.blue,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child:
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            //mainAxisSize: MainAxisSize.max,
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
                            TaskManager.goPage(TaskManager.taskPath, context, task.toString());
                          },),)
                        ]))
            )));
  }

}