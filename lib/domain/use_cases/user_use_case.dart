import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/user.dart';

class UserUseCase{
  UserUseCase._privateConstructor();
  static final UserUseCase _instance = UserUseCase._privateConstructor();
  static UserUseCase get instance => _instance;

  final UserRepository _userRepository = UserRepository.instance;

  Future<User?> authUser(String email, String password) async{
    return await _userRepository.authUser(email, password);
  }

  Future<User?> getUser(String id) async{
    return await _userRepository.getUser(id);
  }

  Future<void> saveCurrentUser(User user) async{
    await _userRepository.saveCurrentUser(user);
  }

  void updateUser(User user) async{
    _userRepository.updateUser(user);
  }

  void updatePasswordUser(String password){
    _userRepository.updatePasswordUser(password);
  }
}