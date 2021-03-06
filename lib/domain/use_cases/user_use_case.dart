import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/repository/user_repository_interface.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';

class UserUseCase implements UserUseCaseInterface{

  UserUseCase(this._userRepository);
  final UserRepositoryInterface _userRepository;

  Future<User?> authUser(String email, String password) async{
    return await _userRepository.authUser(email, password);
  }

  Future<User?> getUserById(String id) async{
    return await _userRepository.getUserById(id);
  }

  User? getUser(){
    return _userRepository.getUser();
  }

  void updateUser(User user) async{
    _userRepository.updateUser(user);
  }

  void updatePasswordUser(String password){
    _userRepository.updatePasswordUser(password);
  }

  Future<bool> registrationUser(RegistrationUser registrationUser) async{
    return await _userRepository.registrationUser(registrationUser);
  }
}