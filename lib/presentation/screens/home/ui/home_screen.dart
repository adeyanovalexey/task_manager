import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/presentation/screens/home/cubit/home_cubit.dart';
import 'package:task_manager/presentation/screens/home/cubit/task_widget_cubit.dart';
import 'package:task_manager/presentation/screens/home/ui/task_widget.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/task_screen/ui/task_screen.dart';
import 'package:task_manager/presentation/widgets/navigation_widget/navigation_widget.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    if(homeCubit.state is StartHomeState)
      homeCubit.downloadData();
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, snapshot){
          if(snapshot is DataUploadedState)
            return DefaultTabController(
              length: 4,
              child: Scaffold(
              body: TabBarView(
                  children: [
                    Scaffold(body: getView(BlocProvider.of<HomeCubit>(context).state.toDoList),
                        floatingActionButton: getFloatingActionButton(context)),
                    getView(BlocProvider.of<HomeCubit>(context).state.inProgressList),
                    getView(BlocProvider.of<HomeCubit>(context).state.testingList),
                    getView(BlocProvider.of<HomeCubit>(context).state.doneList),
                  ],
                ),
                bottomNavigationBar: NavigationWidget(),
                appBar: AppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  bottom: getHomeTabBar(context),
                ),
              ),
            );
          else
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
    );
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
                return BlocProvider<TaskWidgetCubit>(create: (create) => TaskWidgetCubit(taskList.elementAt(index)),
                    child: Taskwidget());
              }
          )),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      onPressed: (){
        PathManager.goPage(TaskScreen.ROUTE_NAME, context);
      },
      child: Icon(Icons.add, color: Colors.white,),
      backgroundColor: Theme.of(context).buttonColor,
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

}