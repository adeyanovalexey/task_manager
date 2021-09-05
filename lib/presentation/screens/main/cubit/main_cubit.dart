import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubitState {
  final int tabIndex;

  MainCubitState(this.tabIndex);
}

class MainCubit extends Cubit<MainCubitState>{
  MainCubit(int? index) : super(MainCubitState(index ?? 0));

  void setTabIndex(int index){
    emit(MainCubitState(index));
  }
}