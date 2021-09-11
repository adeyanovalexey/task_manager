import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/presentation/screens/home/ui/home_screen.dart';
import 'package:task_manager/presentation/screens/main/cubit/main_cubit.dart';
import 'package:task_manager/presentation/screens/profile/ui/profile_screen.dart';
import '../../../widgets/navigation_widget/navigation_widget.dart';

class MainScreen extends  StatelessWidget{
  static const String ROUTE_NAME = "main_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainCubitState>(
      //bloc: BlocProvider.of<MainCubit>(context),
        builder: (context, state) {
          return getScaffold(context, state);
        });
  }

  Widget getScaffold(BuildContext context, MainCubitState state){
    if(state.tabIndex == 0)
      return HomeScreen();
    else if(state.tabIndex == 1)
      return ProfileScreen();
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