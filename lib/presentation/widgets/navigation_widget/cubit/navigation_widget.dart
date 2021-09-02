import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/widgets/navigation_widget/ui/navigation_widget_cubit.dart';
import 'package:task_manager/task_manager.dart';

class NavigationWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<NavigationWidgetCubit>(
        create: (_) => NavigationWidgetCubit.instance,
        child: BlocBuilder<NavigationWidgetCubit, NavigationWidgetState>(
            bloc:   NavigationWidgetCubit.instance,
            builder: (context, snapshot){
              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Color(0xFF651FFF),
                  unselectedItemColor: Color.fromRGBO(29, 212, 243, 1),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 25,
                  selectedFontSize: 15.0,
                  unselectedFontSize: 15.0,
                  currentIndex: BlocProvider.of<NavigationWidgetCubit>(context).state.index,
                  selectedIconTheme: IconThemeData(
                      color: Color(0xFFE040FB),
                      opacity: 1,
                      size: 30),
                  unselectedIconTheme: IconThemeData(
                      color: Color.fromRGBO(29, 212, 243, 1),
                      opacity: 1,
                      size: 25),
                  onTap: (index) {
                    NavigationWidgetState newState = NavigationWidgetState.values[index];
                    if(BlocProvider.of<NavigationWidgetCubit>(context).state != newState){
                      BlocProvider.of<NavigationWidgetCubit>(context).changeState(NavigationWidgetState.values[index]);
                      TaskManager.goPage(newState == NavigationWidgetState.home ? TaskManager.homePath : TaskManager.profilePath, context);
                    }
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: ''
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_box),
                        label: ''
                    ),
                  ]);
            }));
  }
}