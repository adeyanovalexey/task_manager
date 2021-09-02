import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/use_cases/user_use_case.dart';

abstract class AuthorizationState{
  bool visiblePassword;
  AuthorizationState(this.visiblePassword);
}
class StartAuthorizationState extends AuthorizationState{
  StartAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class DoneAuthorizationState extends AuthorizationState{
  DoneAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class FailAuthorizationState extends AuthorizationState{
  FailAuthorizationState(bool visiblePassword) : super(visiblePassword);
}


class AuthorizationCubit extends Cubit<AuthorizationState>{
  AuthorizationCubit._privateConstructor()  : super(StartAuthorizationState(false));
  static final AuthorizationCubit _instance = AuthorizationCubit._privateConstructor();
  static AuthorizationCubit get instance => _instance;

  final UserUseCase _userUseCase = UserUseCase.instance;

  Future<void> logIn(String email, String password) async{
    User? user = await _userUseCase.authUser(email, password);
    if(user != null){
      emit(DoneAuthorizationState(state.visiblePassword));
      _userUseCase.saveCurrentUser(user);
    }
    else
      emit(FailAuthorizationState(state.visiblePassword));
  }

  void setVisiblePassword(bool visiblePassword){
    if(state is StartAuthorizationState)
      emit(StartAuthorizationState(visiblePassword));
    else if(state is DoneAuthorizationState)
      emit(DoneAuthorizationState(visiblePassword));
    else if(state is FailAuthorizationState)
      emit(FailAuthorizationState(visiblePassword));
  }
}