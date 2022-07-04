part of 'home_cubit.dart';

enum ListStatus { loading, success, failure }

class HomeState extends Equatable {
  const HomeState.loading() : this._();

  const HomeState.loadingMore(List<TaskEntity> tasks) : this._(tasks: tasks);

  const HomeState.success(List<TaskEntity> tasks)
      : this._(status: ListStatus.success, tasks: tasks);

  const HomeState.failure() : this._(status: ListStatus.failure);

  const HomeState._(
      {this.status = ListStatus.loading, this.tasks = const <TaskEntity>[]});

  final ListStatus status;
  final List<TaskEntity> tasks;
  @override
  List<Object> get props => [status, tasks];
}
