import 'package:task_manager/data/dto/user_auth.dart';
import 'package:task_manager/data/dto/user_dto.dart';
import 'package:task_manager/data/services/auth_service.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/repository/user_repository_interface.dart';

class UserRepository implements UserRepositoryInterface{

  final FirebaseDatabaseService _firebaseDatabaseService;
  final AuthService _authService;
  final String _path = 'user';
  User? _user;

  UserRepository(this._firebaseDatabaseService, this._authService);

  Future<User?> authUser(String email, String password) async{
    UserAuth? userAuth = await _authService.signInWithEmailAndPassword(email: email, password: password);
    if(userAuth != null){
      _user = await getUserById(userAuth.id);
      return _user;
    }
    return null;
  }

  @override
  Future<User?> getUserById(String id) async{
    UserAuth? userAuth = _authService.getUserAuth();
    if(userAuth != null){
      dynamic value = await _firebaseDatabaseService.read(_path, id);
      Map<String, dynamic> userMap = new Map<String, dynamic>.from(value);
      UserDTO userDTO = UserDTO.fromJson(userMap);
      User user = User(id: userAuth.id, name: userDTO.getName, surname: userDTO.getSurname, email: userAuth.email);
      return user;
    }
    else
      return null;
  }

  @override
  void updateUser(User user) async{
    _user = user;
    UserDTO userDTO = UserDTO(user.getId, user.getName, user.getName);
    await _firebaseDatabaseService.update(_path, user.getId, userDTO.toJson());
  }

  void updatePasswordUser(String password) async{
    await _authService.updatePassword(password: password);
  }

  @override
  Future<bool> registrationUser(RegistrationUser registrationUser) async{
    UserAuth? userAuth =  await _authService.registerWithEmailAndPassword(email: registrationUser.getEmail, password: registrationUser.getPassword);

    if(userAuth != null){
      UserDTO userDTO = UserDTO(userAuth.id, registrationUser.getName, registrationUser.getSurname);
      await _firebaseDatabaseService.write(_path, userDTO.toJson(), userAuth.id);
      _user = User(id: userAuth.id, name: userDTO.getName, surname: userDTO.getSurname, email: userAuth.email);
      return true;
    }
    return false;
  }

  @override
  User? getUser(){
    return _user;
  }
}
