import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/dto/user_auth.dart';
import 'package:task_manager/data/dto/user_dto.dart';
import 'package:task_manager/data/services/auth_service.dart';
import 'package:task_manager/data/services/firebase_db_service.dart';
import 'package:task_manager/domain/entities/user.dart';

abstract class TaskRepositoryInterface{
  Future<User?> authUser(String email, String password);
  Future<bool> registrationUser(RegistrationUser registrationUser);
  Future<User?> getUser(String id);
  Future<User?> getCurrentUser();
  Future<void> saveCurrentUser(User user);
  void updateUser(User user);
  void updatePasswordUser(String password);
}

class UserRepository implements TaskRepositoryInterface{
  UserRepository._privateConstructor();
  static final UserRepository _instance = UserRepository._privateConstructor();
  static UserRepository get instance => _instance;

  FirebaseDatabaseService _firebaseDatabaseService = FirebaseDatabaseService.instance;
  final AuthService _authService = AuthService.instance;
  final String _path = 'user';

  Future<User?> authUser(String email, String password) async{
    UserAuth? userAuth = await _authService.signInWithEmailAndPassword(email: email, password: password);
    if(userAuth != null){
      User? user = await getUser(userAuth.id);
      return user;
    }
    return null;
  }

  @override
  Future<User?> getUser(String id) async{
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
      return true;
    }
    return false;
  }

  @override
  Future<void> saveCurrentUser(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toString());
  }

  @override
  Future<User?> getCurrentUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userStr = prefs.getString('user');
    if(userStr != null){
      Map<String, dynamic> userMap = jsonDecode(userStr) as Map<String, dynamic>;
      final User user = User.fromJson(userMap);
      return user;
    }
    return null;
  }
}
