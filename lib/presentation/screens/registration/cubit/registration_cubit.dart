import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/user.dart';

enum RegistrationState{start, done, error}

class RegistrationCubit extends Cubit<RegistrationState>{

  RegistrationCubit._privateConstructor()  : super(RegistrationState.start);
  static final RegistrationCubit _instance = RegistrationCubit._privateConstructor();
  static RegistrationCubit get instance => _instance;
  final UserRepository _userRepository = UserRepository.instance;

  Future<void> registration({required String name, required String surname, required String email,
    required String password}) async{
    bool result = await _userRepository.registrationUser(RegistrationUser(name, surname, email, password));
    if(result)
      emit(RegistrationState.done);
    else
      emit(RegistrationState.error);
  }
}