import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/core/core.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final TaskRepository repository;
  TaskDetailCubit(this.repository) : super(const TaskDetailState());

  void init(TaskEntity task) {
    emit(state.copyWith(initialState: task, newState: task));
  }

  Future<bool> updateTask() async {
    return await repository.updateTask(state.newState!);
  }

  bool checkIfStatusChange() {
    if (state.initialState == state.newState) {
      return false;
    }
    return true;
  }

  void changeTitle(String title) {
    final newState = state.newState!.copyWith(title: title);
    emit(state.copyWith(newState: newState));
  }

  void changeNote(String note) {
    final newState = state.newState!.copyWith(note: note);
    emit(state.copyWith(newState: newState));
  }

  void changeDeadline(String deadline) {
    final newState = state.newState!
        .copyWith(deadline: deadline.toDateTime().millisecondsSinceEpoch);
    emit(state.copyWith(newState: newState));
  }

  void changeIsDoneStatus(String taskId) async {
    final newState = state.newState!.copyWithNewStatus();
    emit(state.copyWith(newState: newState));
  }
}
