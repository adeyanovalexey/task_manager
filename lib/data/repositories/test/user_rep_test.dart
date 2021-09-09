import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/repository/user_repository_interface.dart';

class UserRepositoryTest implements UserRepositoryInterface{
  User? _user;
  UserRepositoryTest();
  UserRepositoryTest.createUser(this._user);

  @override
  Future<User?> authUser(String email, String password) async{
    _user = User(id: "1", name: "name", surname: "surname", email: "email@gmail.com");
    return _user;
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  Future<User?> getUserById(String id) async{
    if(_user != null){
      if(_user!.getId == id)
        return _user;
    }
    return null;
  }

  @override
  Future<bool> registrationUser(RegistrationUser registrationUser) async{
    return true;
  }

  @override
  void updatePasswordUser(String password) {}

  @override
  void updateUser(User user) {
    _user = user;
  }

}