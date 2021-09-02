import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';

abstract class ProfileState{
  ProfileState(this.user);
  User user;
}
class StartProfileState extends ProfileState{
  StartProfileState(User user) : super(user);
}

class UploadedProfileState extends ProfileState{
  UploadedProfileState(User user) : super(user);
}

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit._privateConstructor()  : super(StartProfileState(User(id: '', name: '', surname: '', email: '')));
  static final ProfileCubit _instance = ProfileCubit._privateConstructor();
  static ProfileCubit get instance => _instance;
  final UserUseCase _userUseCase = UserUseCase.instance;

  Future<void> initUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? userStr = sharedPreferences.getString('user');
    if(userStr != null){
      Map<String, dynamic> userMap = jsonDecode(userStr) as Map<String, dynamic>;
      final User user = User.fromJson(userMap);
      emit(UploadedProfileState(user));
    }
  }

  void updateNameAndSurname(User user) async{
    _userUseCase.updateUser(user);
    emit(UploadedProfileState(user));
  }

  void updatePassword(String password){
    _userUseCase.updatePasswordUser(password);
    emit(UploadedProfileState(state.user));
  }
}