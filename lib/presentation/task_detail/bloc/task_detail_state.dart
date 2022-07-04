part of 'task_detail_cubit.dart';

class TaskDetailState extends Equatable {
  final TaskEntity? initialState;
  final TaskEntity? newState;
  @override
  List<Object?> get props => [newState];

  const TaskDetailState({
    this.initialState,
    this.newState,
  });

  TaskDetailState copyWith({
    TaskEntity? initialState,
    TaskEntity? newState,
  }) {
    return TaskDetailState(
      initialState: initialState ?? this.initialState,
      newState: newState ?? this.newState,
    );
  }
}
