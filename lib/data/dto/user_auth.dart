import 'package:firebase_auth/firebase_auth.dart';

class UserAuth{
  final String id;
  final String email;

  UserAuth(this.id, this.email);

  static UserAuth? fromUserAuth(User? user){
    if(user != null)
      return UserAuth(user.uid, user.email!);
    else
      return null;
  }
}