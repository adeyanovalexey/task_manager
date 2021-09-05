import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/use_cases/full_task_use_case.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';
import 'package:task_manager/presentation/screens/app_cubit.dart';
import 'package:task_manager/presentation/screens/home/cubit/home_cubit.dart';
import 'package:task_manager/presentation/screens/home/ui/home_screen.dart';
import 'package:task_manager/presentation/screens/main/cubit/main_cubit.dart';
import 'package:task_manager/presentation/screens/profile/cubit/profile_cubit.dart';
import 'package:task_manager/presentation/screens/profile/ui/profile_screen.dart';
import '../../../widgets/navigation_widget/navigation_widget.dart';

class MainScreen extends  StatelessWidget{
  static const String ROUTE_NAME = "main_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainCubitState>(
        bloc: BlocProvider.of<MainCubit>(context),
        builder: (context, state) {
          return getScaffold(context, state);
        });
  }

  Widget getScaffold(BuildContext context, MainCubitState state){
    if(state.tabIndex == 0)
      return DefaultTabController(
          length: 4,
          child: BlocProvider<HomeCubit>(create: (context) =>
              HomeCubit(BlocProvider.of<AppCubit>(context).dependencyManager.get<FullTaskUseCase>()),
              child: Scaffold(body: HomeScreen(),
                bottomNavigationBar: NavigationWidget(),
                appBar: AppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  bottom: getHomeTabBar(context),
                ),
              )));
    else if(state.tabIndex == 1)
      return BlocProvider<ProfileCubit>(create: (context) =>
          ProfileCubit(BlocProvider.of<AppCubit>(context).dependencyManager.get<UserUseCase>()),
          child: Scaffold(body: ProfileScreen(),
              bottomNavigationBar: NavigationWidget()));
    else
      return Scaffold(
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Theme.of(context).buttonColor,
        ),
        bottomNavigationBar: NavigationWidget(),
      );
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