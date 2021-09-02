import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Arguments{
  // String title;
  String path;
  String? arg;
  Arguments(this.path, [this.arg]);
}

class TaskManager{
  TaskManager._privateConstructor();
  static final TaskManager _instance = TaskManager._privateConstructor();
  static TaskManager get instance => _instance;

  static final String homePath = '/home';
  static final String authorizationPath = '/authorization';
  static final String registrationPath = '/registration';
  static final String taskPath = '/task';
  static final String profilePath = '/profile';


  FirebaseApp? app;

  static void goPage(String path, BuildContext context, [String? arg]){
    if(path == authorizationPath)
      Navigator.of(context).pushNamed(homePath, arguments: Arguments(authorizationPath));
    else if(path == registrationPath)
      Navigator.of(context).pushNamed(homePath, arguments: Arguments(registrationPath));
    else if(path == taskPath)
      Navigator.of(context).pushNamed(homePath, arguments: Arguments(taskPath, arg ?? ''));
    else if(path == profilePath)
      Navigator.of(context).pushNamed(homePath, arguments: Arguments(profilePath));
    else
      Navigator.of(context).pushNamed(homePath, arguments: Arguments(homePath));
  }
}