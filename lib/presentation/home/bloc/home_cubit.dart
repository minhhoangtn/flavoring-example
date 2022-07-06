import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/task/add_task_request.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/utils/push_notification.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskRepository repository;

  HomeCubit(this.repository) : super(const HomeState.loading());

  void sortTaskByDate(List<TaskEntity> tasks) {
    tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
  }

  void filterTasks(FilterStatus filter) {
    print('filter');
    emit(HomeState.filter(state.tasks, filter));
  }

  Future<void> fetchList(String userId) async {
    emit(const HomeState.loading());
    try {
      final tasks = await repository.fetchListTask(userId);
      sortTaskByDate(tasks);
      emit(HomeState.success(tasks));
    } on ErrorException catch (_) {
      emit(const HomeState.failure());
    }
  }

  Future<void> addTask(
      String title, String note, DateTime deadline, String userId) async {
    emit(HomeState.loadingMore(state.tasks));
    final param = AddTaskRequest(
        title: title, note: note, deadline: deadline.millisecondsSinceEpoch);
    try {
      final task = await repository.addTask(param, userId);
      final tasks = state.tasks.map((e) => e).toList();
      tasks.add(task);
      sortTaskByDate(tasks);
      emit(HomeState.success(tasks));
    } on ErrorException catch (e) {
      print(e.errorMessage);
    }
  }

  Future<void> deleteTask(String taskId) async {
    final currentTasks = state.tasks.map((e) => e).toList();
    final newTasks = state.tasks.map((e) => e).toList();
    newTasks.removeWhere((element) => element.id == taskId);
    emit(HomeState.success(newTasks));
    final isSuccess = await repository.deleteTask(taskId);
    if (!isSuccess) {
      emit(HomeState.success(currentTasks));
    } else {
      await localNotificationsPlugin.cancel(currentTasks
          .firstWhere((element) => element.id == taskId)
          .id
          .hashCode);
    }
  }

  Future<void> changeTaskStatus(String taskId) async {
    final newTasks = state.tasks.map((e) => e).toList();
    final taskIndex = newTasks.indexWhere((element) => element.id == taskId);
    newTasks[taskIndex] = newTasks[taskIndex].copyWithNewStatus();
    emit(HomeState.success(newTasks));

    await repository.changeStatus(taskId);
  }
}
