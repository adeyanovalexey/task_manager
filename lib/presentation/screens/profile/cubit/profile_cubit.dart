import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';

abstract class ProfileState extends Equatable{
  ProfileState(this.user);
  final User user;
  @override
  List<Object> get props => [user];
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
  ProfileCubit(this._userUseCaseInterface)  : super(StartProfileState(User(id: '', name: '', surname: '', email: '')));

  final UserUseCaseInterface _userUseCaseInterface;

  void initUser() {
    final User? user = _userUseCaseInterface.getUser();
    if(user != null)
      emit(UploadedProfileState(user));
    else
      emit(ErrorProfileState());
  }

  void updateNameAndSurname(User user) async{
    _userUseCaseInterface.updateUser(user);
    emit(UploadedProfileState(user));
  }

  void updatePassword(String password){
    _userUseCaseInterface.updatePasswordUser(password);
    emit(UploadedProfileState(state.user));
  }
}