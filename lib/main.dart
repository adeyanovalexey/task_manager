import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/global_page.dart';
import 'package:task_manager/task_manager.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp? app;
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

  runApp(MyApp(app));
}

class MyApp extends StatelessWidget {

  MyApp([this.firebaseApp]);
  final FirebaseApp? firebaseApp;
  // This widget is the root of your application.
  @override
  StatelessElement createElement() {
    TaskManager.instance.app = firebaseApp;
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GlobalPage(firebaseApp != null ? true : false),
      routes: {TaskManager.homePath: (context) => GlobalPage(firebaseApp != null ? true : false)},
    );
  }
}