import 'package:task_manager/data/repositories/user_rep.dart';
import 'package:task_manager/domain/entities/user.dart';

class UserUseCase{

  UserUseCase(this._userRepository);
  final UserRepository _userRepository;

  Future<User?> authUser(String email, String password) async{
    return await _userRepository.authUser(email, password);
  }

  Future<User?> getUser(String id) async{
    return await _userRepository.getUser(id);
  }

  Future<User?> getCurrentUser() async{
    return await _userRepository.getCurrentUser();
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