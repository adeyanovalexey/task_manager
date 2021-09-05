import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/screens/main/cubit/main_cubit.dart';

class NavigationWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF651FFF),
        unselectedItemColor: Color.fromRGBO(29, 212, 243, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        selectedFontSize: 15.0,
        unselectedFontSize: 15.0,
        currentIndex: BlocProvider.of<MainCubit>(context).state.tabIndex,
        selectedIconTheme: IconThemeData(
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            opacity: 1,
            size: 30),
        unselectedIconTheme: IconThemeData(
            color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            opacity: 1,
            size: 25),
        onTap: (index) {
          if(BlocProvider.of<MainCubit>(context).state.tabIndex != index){
            BlocProvider.of<MainCubit>(context).setTabIndex(index);
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
  }
}