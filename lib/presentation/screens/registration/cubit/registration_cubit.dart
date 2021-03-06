import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';

enum RegistrationState{start, done, error}

class RegistrationCubit extends Cubit<RegistrationState>{

  RegistrationCubit(this._userUseCaseInterface) : super(RegistrationState.start);
  final UserUseCaseInterface _userUseCaseInterface;

  Future<void> registration({required String name, required String surname, required String email,
    required String password}) async{
    bool result = await _userUseCaseInterface.registrationUser(RegistrationUser(name, surname, email, password));
    if(result)
      emit(RegistrationState.done);
    else
      emit(RegistrationState.error);
  }
}