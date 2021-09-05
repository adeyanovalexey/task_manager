import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entities/full_task.dart';

class TaskWidgetCubitState{}
class TaskWidgetCubit extends Cubit<TaskWidgetCubitState>{
  FullTask fullTask;
  TaskWidgetCubit(this.fullTask) : super(TaskWidgetCubitState());
}