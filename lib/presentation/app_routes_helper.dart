import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/full_task.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';
import 'package:task_manager/presentation/screens/app_cubit.dart';
import 'package:task_manager/presentation/screens/authorization/cubit/authorization_cubit.dart';
import 'package:task_manager/presentation/screens/authorization/ui/authorization_screen.dart';
import 'package:task_manager/presentation/screens/main/cubit/main_cubit.dart';
import 'package:task_manager/presentation/screens/main/ui/main_screen.dart';
import 'package:task_manager/presentation/screens/no_connection/no_connection_screen.dart';
import 'package:task_manager/presentation/screens/registration/cubit/registration_cubit.dart';
import 'package:task_manager/presentation/screens/registration/ui/registration_screen.dart';
import 'package:task_manager/presentation/screens/task_screen/cubit/task_cubit.dart';
import 'package:task_manager/presentation/screens/task_screen/ui/task_screen.dart';

class AppRoutesHelper {

  static String getRoute(bool availabilityConnect){
    if(availabilityConnect)
      return AuthorizationScreen.ROUTE_NAME;
    else
      return NoConnectionScreen.ROUTE_NAME;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    if(routeSettings.name == AuthorizationScreen.ROUTE_NAME)
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return BlocProvider<AuthorizationCubit>(
              create: (context) =>
                  AuthorizationCubit(BlocProvider.of<AppCubit>(context).dependencyManager.get<UserUseCase>()),
              child: Scaffold(body: AuthorizationScreen())
          );
        },
      );
    else if(routeSettings.name == RegistrationScreen.ROUTE_NAME)
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return BlocProvider<RegistrationCubit>(
              create: (context) =>
                  RegistrationCubit(BlocProvider.of<AppCubit>(context).dependencyManager.get<UserRepository>()),
              child: Scaffold(body: RegistrationScreen())
          );
        },
      );
    else if(routeSettings.name == TaskScreen.ROUTE_NAME){
      FullTask? task = routeSettings.arguments as FullTask?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return BlocProvider<TaskCubit>(
              create: (context) =>
                  TaskCubit(BlocProvider.of<AppCubit>(context).dependencyManager.get<TaskRepository>(),
                      BlocProvider.of<AppCubit>(context).dependencyManager.get<UserRepository>(),
                      task),
              child: Scaffold(body: TaskScreen())
          );
        },
      );
    }
    else if (routeSettings.name == MainScreen.ROUTE_NAME) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return BlocProvider<MainCubit>(
              create: (context) => MainCubit(routeSettings.arguments != null ? routeSettings.arguments as int : null),
              child: Scaffold(body: MainScreen(),)
          );
        },
      );
    }
    else if (routeSettings.name == NoConnectionScreen.ROUTE_NAME) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return NoConnectionScreen();
        },
      );
    }
    return null;
  }
}