import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationWidgetState{home, account}
class NavigationWidgetCubit extends Cubit<NavigationWidgetState>{

  NavigationWidgetCubit._privateConstructor()  : super(NavigationWidgetState.home);
  static final NavigationWidgetCubit _instance = NavigationWidgetCubit._privateConstructor();
  static NavigationWidgetCubit get instance => _instance;

  void changeState(NavigationWidgetState state){
    emit(state);
  }

}