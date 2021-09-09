import 'package:firebase_core/firebase_core.dart';
import 'package:injector/injector.dart';
import 'package:task_manager/data/repositories/task_rep.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/data/services/auth_service.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/interfaces/repository/task_repository_interface.dart';
import 'package:task_manager/domain/interfaces/repository/user_repository_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/full_task_use_case_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/task_use_case_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';
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
    _injector.registerSingleton<UserUseCaseInterface>((){
      UserRepositoryInterface userRepository = _injector.get<UserRepositoryInterface>();
      return UserUseCase(userRepository);
    });

    _injector.registerSingleton<TaskUseCaseInterface>((){
      TaskRepositoryInterface taskRepository = _injector.get<TaskRepositoryInterface>();
      return TaskUseCase(taskRepository);
    });

    _injector.registerSingleton<FullTaskUseCaseInterface>((){
      UserUseCaseInterface userUseCaseInterface = _injector.get<UserUseCaseInterface>();
      TaskUseCaseInterface taskUseCaseInterface = _injector.get<TaskUseCaseInterface>();
      return FullTaskUseCase(userUseCaseInterface, taskUseCaseInterface);
    });
  }
}