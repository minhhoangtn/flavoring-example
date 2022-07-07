part of 'task_detail_cubit.dart';

enum UpdateTaskStatus { initial, loading, success, failure }

class TaskDetailState extends Equatable {
  final TaskEntity? initialState;
  final TaskEntity? newState;
  final UpdateTaskStatus updateStatus;
  final String? errorMessage;
  @override
  List<Object?> get props => [newState, updateStatus, errorMessage];

  const TaskDetailState(
      {this.initialState,
      this.newState,
      this.updateStatus = UpdateTaskStatus.initial,
      this.errorMessage});

  TaskDetailState copyWith({
    TaskEntity? initialState,
    TaskEntity? newState,
    UpdateTaskStatus? updateStatus,
    String? errorMessage,
  }) {
    return TaskDetailState(
      initialState: initialState ?? this.initialState,
      newState: newState ?? this.newState,
      updateStatus: updateStatus ?? this.updateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
