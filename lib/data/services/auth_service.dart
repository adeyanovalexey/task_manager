import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/data/dto/user_auth.dart';
import 'package:task_manager/task_manager.dart';

class AuthService{
  AuthService._privateConstructor(){
    _fAuth.app = TaskManager.instance.app!;
  }
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;

  final FirebaseAuth _fAuth =  FirebaseAuth.instance;
  User? _user;

  Future<UserAuth?> signInWithEmailAndPassword({required String email, required String password}) async{
    try{
      UserCredential userCredential = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      UserAuth? _userAuth = UserAuth.fromUserAuth(_user);
      return _userAuth;
    }
    catch(e){
      return null;
    }
  }

  Future<UserAuth?> registerWithEmailAndPassword({required String email, required String password}) async{
    try{
      UserCredential userCredential = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      UserAuth? userAuth = UserAuth.fromUserAuth(userCredential.user);
      return userAuth;
    }
    catch(e){
      return null;
    }
  }

  UserAuth? getUserAuth(){
    UserAuth? userAuth = UserAuth.fromUserAuth(_user);
    return userAuth;
  }

  Future<void> updatePassword({required String password}) async{
    if(_user != null)
      await _user!.updatePassword(password);
  }

}