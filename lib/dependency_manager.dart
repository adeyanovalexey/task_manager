import 'package:firebase_core/firebase_core.dart';
import 'package:injector/injector.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/data/services/auth_service.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/use_cases/full_task_use_case.dart';
import 'package:task_manager/domain/use_cases/task_use_case.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';

class DependencyManager{
  static final Injector _injector = Injector.appInstance;

  T get<T>({String dependencyName = ""}) => _injector.get<T>(dependencyName: dependencyName);

   void startRegister(FirebaseApp? app){
     _registerServices(app);
     _registerRepositories();
     _registerUseCase();
  }

  void _registerServices(FirebaseApp? app) {
    _injector.registerSingleton<AuthService>(() => AuthService());
    _injector.registerSingleton<FirebaseDatabaseService>(() => FirebaseDatabaseService(app));
  }

  void _registerRepositories() {
    _injector.registerSingleton<TaskRepository>((){
      FirebaseDatabaseService firebaseDatabaseService = _injector.get<FirebaseDatabaseService>();
      return TaskRepository(firebaseDatabaseService);
    });
    _injector.registerSingleton<UserRepository>((){
      FirebaseDatabaseService firebaseDatabaseService = _injector.get<FirebaseDatabaseService>();
      AuthService authService = _injector.get<AuthService>();
      return UserRepository(firebaseDatabaseService, authService);
    });
  }

  void _registerUseCase(){
    _injector.registerSingleton<UserUseCase>((){
      UserRepository userRepository = _injector.get<UserRepository>();
      return UserUseCase(userRepository);
    });

    _injector.registerSingleton<TaskUseCase>((){
      TaskRepository taskRepository = _injector.get<TaskRepository>();
      return TaskUseCase(taskRepository);
    });

    _injector.registerSingleton<FullTaskUseCase>((){
      UserUseCase userUseCase = _injector.get<UserUseCase>();
      TaskUseCase taskUseCase = _injector.get<TaskUseCase>();
      return FullTaskUseCase(userUseCase, taskUseCase);
    });



  }
}