import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/domain/interfaces/usecase/user_use_case_interface.dart';

abstract class AuthorizationState extends Equatable{
  final bool visiblePassword;
  AuthorizationState(this.visiblePassword);

  @override
  List<Object> get props => [visiblePassword];
}
class StartAuthorizationState extends AuthorizationState{
  StartAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class LoadingAuthorizationState extends AuthorizationState{
  LoadingAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class DoneAuthorizationState extends AuthorizationState{
  DoneAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class FailAuthorizationState extends AuthorizationState{
  FailAuthorizationState(bool visiblePassword) : super(visiblePassword);
}

class AuthorizationCubit extends Cubit<AuthorizationState>{

  final UserUseCaseInterface _userUseCaseInterface;
  AuthorizationCubit(this._userUseCaseInterface) : super(StartAuthorizationState(false));

  Future<void> logIn(String email, String password) async{
    emit(LoadingAuthorizationState(state.visiblePassword));
    User? user = await _userUseCaseInterface.authUser(email, password);
    if(user != null)
      emit(DoneAuthorizationState(state.visiblePassword));
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
    else
      emit(StartAuthorizationState(visiblePassword));
  }
}