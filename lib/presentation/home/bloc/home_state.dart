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
    }
  }
}

enum FilterStatus { all, byDone, byUndone }

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
