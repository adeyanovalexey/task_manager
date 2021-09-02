import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/presentation/screens/authorization/ui/authorization_screen.dart';
import 'package:task_manager/presentation/screens/home/ui/home_screen.dart';
import 'package:task_manager/presentation/screens/profile/ui/profile_screen.dart';
import 'package:task_manager/presentation/screens/registration/ui/registration_screen.dart';
import 'package:task_manager/presentation/screens/task_screen/ui/task_screen.dart';
import 'package:task_manager/task_manager.dart';
import 'widgets/navigation_widget/cubit/navigation_widget.dart';

class GlobalPage extends  StatelessWidget{
  GlobalPage(this.availabilityConnect);
  final bool availabilityConnect;

  @override
  Widget build(BuildContext context) {
    Arguments? args =  ModalRoute.of(context)!.settings.arguments as Arguments?;
    if(availabilityConnect)
      return getScaffold(args, context);
    else
      return Scaffold(body: Container(child: Text('Подключение не выполнено'), alignment: Alignment.center));
  }

  Widget getScaffold(Arguments? args, BuildContext context){
    if(args != null){
      if(args.path == TaskManager.registrationPath)
        return Scaffold(body: RegistrationScreen());
      else if(args.path == TaskManager.profilePath)
        return Scaffold(body: ProfileScreen(),
            bottomNavigationBar: NavigationWidget());
      else if(args.path == TaskManager.homePath)
        return DefaultTabController(
            length: 4, child: Scaffold(body: HomeScreen(),
          bottomNavigationBar: NavigationWidget(),
          appBar: AppBar(
            bottom: getHomeTabBar(context),
          ),
        ));
      else if(args.path == TaskManager.taskPath)
        return Scaffold(body: TaskScreen(getTaskFromArgument(args.arg)), bottomNavigationBar: NavigationWidget());
      else
        return Scaffold(
          body: Container(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Color.fromRGBO(29, 212, 243, 1),
          ),
          bottomNavigationBar: NavigationWidget(),
        );
    }
    else
      return Scaffold(body: AuthorizationScreen());

  }

  TabBar getHomeTabBar(BuildContext context){
    return TabBar(
      tabs: <Widget>[
        Container(width: MediaQuery.of(context).size.width * 0.17,
            child: Tab(
                child: FittedBox(child: Text(
                    'To Do',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    )))
            )),
        Container(width: MediaQuery.of(context).size.width * 0.17,
          child: Tab(
            child:FittedBox(child: Text(
                'In Progress',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                )),),
          ),),
        Container(width: MediaQuery.of(context).size.width * 0.17,
          child:Tab(
              child: FittedBox(child: Text(
                  'Testing',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  )))
          ),),
        Container(width: MediaQuery.of(context).size.width * 0.17,
            child:Tab(
                child: FittedBox(child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    )))
            ))
      ],
    );
  }

  FullTask? getTaskFromArgument(String? arg){
    String argument = arg ?? '';
    if(argument.isNotEmpty){
      Map<String, dynamic> taskMap = jsonDecode(argument) as Map<String, dynamic>;
      FullTask task = FullTask.fromJson(taskMap);
      return task;
    }
    return null;
  }
}