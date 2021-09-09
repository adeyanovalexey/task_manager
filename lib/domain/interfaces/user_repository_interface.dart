import 'package:task_manager/domain/entities/user.dart';

abstract class UserRepositoryInterface{
  Future<User?> authUser(String email, String password);
  Future<bool> registrationUser(RegistrationUser registrationUser);
  Future<User?> getUserById(String id);
  User? getUser();
  void updateUser(User user);
  void updatePasswordUser(String password);
}