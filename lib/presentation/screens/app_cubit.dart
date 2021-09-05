import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:task_manager/dependency_manager.dart';

class AppCubitState{}
class AppCubit extends Cubit<AppCubitState>{

  FirebaseApp? app;
  final Injector injector = Injector.appInstance;

  AppCubit() : super(AppCubitState());

  DependencyManager dependencyManager = DependencyManager();

  Future<void> init() async{
    try{
      app = await Firebase.initializeApp(name: 'taskmanager', options: FirebaseOptions(
          apiKey: "AIzaSyA0-L2XMQAyNgkzWta-dx-FNhtly3WSJAY",
          authDomain: "task-manager-8ef07.firebaseapp.com",
          databaseURL: "https://task-manager-8ef07-default-rtdb.europe-west1.firebasedatabase.app",
          projectId: "task-manager-8ef07",
          storageBucket: "task-manager-8ef07.appspot.com",
          messagingSenderId: "44647081248",
          appId: "1:44647081248:web:a8904c2cc6b3df21c9e345",
          measurementId: "G-30QY7BQ0NW"
      ));
    }
    catch(e){}
    dependencyManager.startRegister(app);
  }
}