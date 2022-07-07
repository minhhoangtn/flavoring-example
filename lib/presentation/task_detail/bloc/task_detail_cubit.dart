import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/core/extension/extension_barrel.dart';
import 'package:flavoring/core/notification_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final TaskRepository repository;
  TaskDetailCubit(this.repository) : super(const TaskDetailState());

  void init(TaskEntity task) {
    emit(state.copyWith(initialState: task, newState: task));
  }

  Future<bool> updateTask() async {
    final currentState = state.newState!;
    final isReceiveNotification = currentState.isReceiveNotification;

    bool result = await repository.updateTask(currentState);
    if (result) {
      if (isReceiveNotification) {
        await localNotificationsPlugin.cancel(currentState.id.hashCode);
        final androidChannel = androidLocalChannel;
        await localNotificationsPlugin.zonedSchedule(
            currentState.id.hashCode,
            currentState.title,
            currentState.note,
            tz.TZDateTime.fromMillisecondsSinceEpoch(
                tz.getLocation('Etc/GMT+8'), currentState.deadline),
            NotificationDetails(
                android: AndroidNotificationDetails(
                    androidChannel.id, androidChannel.name,
                    channelDescription: androidChannel.description,
                    importance: Importance.max)),
            payload: currentState.id,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      } else {
        await localNotificationsPlugin.cancel(currentState.id.hashCode);
      }
    }
    return result;
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
