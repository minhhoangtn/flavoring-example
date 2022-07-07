part of 'home_cubit.dart';

enum ListStatus { loading, success, failure }

extension FilterStatusExtension on FilterStatus {
  List<TaskEntity> apply(List<TaskEntity> tasks) {
    switch (this) {
      case FilterStatus.all:
        return tasks.where((element) => true).toList();
      case FilterStatus.byDone:
        return tasks.where((element) => element.isDone).toList();
      case FilterStatus.byUndone:
        return tasks.where((element) => !element.isDone).toList();
      case FilterStatus.byDueDate:
        return tasks
            .where((element) =>
                element.deadline < DateTime.now().millisecondsSinceEpoch)
            .toList();
    }
  }

  String get name {
    switch (this) {
      case FilterStatus.all:
        return 'tất cả';
      case FilterStatus.byDone:
        return 'đã hoàn thành';
      case FilterStatus.byUndone:
        return 'chưa hoàn thành';
      case FilterStatus.byDueDate:
        return 'đã quá hạn';
    }
  }
}

enum FilterStatus { all, byDone, byUndone, byDueDate }

class HomeState extends Equatable {
  const HomeState.loading() : this._();

  const HomeState.loadingMore(List<TaskEntity> tasks) : this._(tasks: tasks);

  const HomeState.success(List<TaskEntity> tasks)
      : this._(status: ListStatus.success, tasks: tasks);

  const HomeState.filter(List<TaskEntity> tasks, FilterStatus filter)
      : this._(filter: filter, tasks: tasks, status: ListStatus.success);

  const HomeState.failure() : this._(status: ListStatus.failure);

  const HomeState._(
      {this.status = ListStatus.loading,
      this.tasks = const <TaskEntity>[],
      this.filter = FilterStatus.all});

  final ListStatus status;
  final List<TaskEntity> tasks;
  final FilterStatus filter;

  List<TaskEntity> get filteredTasks => filter.apply(tasks);

  int get undoneTaskCount =>
      tasks.where((element) => !element.isDone).toList().length;
  @override
  List<Object> get props => [status, tasks, filter];
}
