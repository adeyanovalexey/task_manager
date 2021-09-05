import 'package:flutter_bloc/flutter_bloc.dart';
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

class ErrorProfileState extends ProfileState{
  ErrorProfileState() : super(User(id: '', name: '', surname: '', email: ''));
}

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit(this._userUseCase)  : super(StartProfileState(User(id: '', name: '', surname: '', email: '')));

  final UserUseCase _userUseCase;

  Future<void> initUser() async{
    final User? user = await _userUseCase.getCurrentUser();
    if(user != null)
      emit(UploadedProfileState(user));
    else
      emit(ErrorProfileState());
  }

  void updateNameAndSurname(User user) async{
    await _userUseCase.saveCurrentUser(user);
    _userUseCase.updateUser(user);
    emit(UploadedProfileState(user));
  }

  void updatePassword(String password){
    _userUseCase.updatePasswordUser(password);
    emit(UploadedProfileState(state.user));
  }
}