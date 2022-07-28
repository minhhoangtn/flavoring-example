import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/core/extension/extension_barrel.dart';
import 'package:flavoring/core/utils/utils_barrel.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final TaskRepository repository;
  TaskDetailCubit(this.repository) : super(const TaskDetailState());

  void init(TaskEntity task) {
    emit(state.copyWith(initialState: task, newState: task));
  }

  void updateTask() async {
    emit(state.copyWith(updateStatus: UpdateTaskStatus.loading));
    final currentState = state.newState!;
    final isReceiveNotification = currentState.isReceiveNotification;

    if (isReceiveNotification) {
      await localNotificationsPlugin.cancel(currentState.id.hashCode);

      try {
        await LocalNotificationUtils.scheduleNotification(
            id: currentState.id.hashCode,
            epocTime: currentState.deadline,
            title: currentState.title,
            body: currentState.note,
            payload: jsonEncode(currentState.toJson()));
      } catch (_) {
        emit(state.copyWith(
            newState: currentState.copyWith(
                isReceiveNotification: !currentState.isReceiveNotification),
            updateStatus: UpdateTaskStatus.failure,
            errorMessage: 'Deadline đã quá hạn'));
        return;
      }
    } else {
      await localNotificationsPlugin.cancel(currentState.id.hashCode);
    }

    bool isSuccess = await repository.updateTask(currentState);
    if (!isSuccess) {
      await localNotificationsPlugin.cancel(currentState.id.hashCode);
      emit(state.copyWith(
          updateStatus: UpdateTaskStatus.failure,
          errorMessage: 'Không thể cập nhật'));
      return;
    }

    emit(state.copyWith(updateStatus: UpdateTaskStatus.success));
  }

  bool checkIfStatusChange() {
    if (state.initialState == state.newState) {
      return false;
    }
    return true;
  }

  void changeReceiveNotification() {
    final currentStatus = state.newState!;

    emit(state.copyWith(
        newState: currentStatus.copyWith(
            isReceiveNotification: !currentStatus.isReceiveNotification)));
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

  void changeIsDoneStatus() async {
    final newState = state.newState!.copyWithNewStatus();
    emit(state.copyWith(newState: newState));
  }
}
