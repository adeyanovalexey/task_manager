import 'package:firebase_core/firebase_core.dart';
import 'package:injector/injector.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/data/services/auth_service.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/interfaces/task_repository_interface.dart';
import 'package:task_manager/domain/interfaces/user_repository_interface.dart';
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
    _injector.registerSingleton<TaskRepositoryInterface>((){
      FirebaseDatabaseService firebaseDatabaseService = _injector.get<FirebaseDatabaseService>();
      return TaskRepository(firebaseDatabaseService);
    });
    _injector.registerSingleton<UserRepositoryInterface>((){
      FirebaseDatabaseService firebaseDatabaseService = _injector.get<FirebaseDatabaseService>();
      AuthService authService = _injector.get<AuthService>();
      return UserRepository(firebaseDatabaseService, authService);
    });
  }

  void _registerUseCase(){
    _injector.registerSingleton<UserUseCase>((){
      UserRepositoryInterface userRepository = _injector.get<UserRepositoryInterface>();
      return UserUseCase(userRepository);
    });

    _injector.registerSingleton<TaskUseCase>((){
      TaskRepositoryInterface taskRepository = _injector.get<TaskRepositoryInterface>();
      return TaskUseCase(taskRepository);
    });

    _injector.registerSingleton<FullTaskUseCase>((){
      UserUseCase userUseCase = _injector.get<UserUseCase>();
      TaskUseCase taskUseCase = _injector.get<TaskUseCase>();
      return FullTaskUseCase(userUseCase, taskUseCase);
    });
  }
}