part of 'count_down_bloc.dart';

abstract class CountDownState extends Equatable {
  final int duration;
  const CountDownState(this.duration);
}

class CountDownInitial extends CountDownState {
  const CountDownInitial(int duration) : super(duration);

  @override
  List<Object?> get props => [];
}

class CountDownInProgress extends CountDownState {
  const CountDownInProgress(int duration) : super(duration);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CountDownPause extends CountDownState {
  const CountDownPause(int duration) : super(duration);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CountDownComplete extends CountDownState {
  const CountDownComplete() : super(0);

  @override
  List<Object?> get props => throw UnimplementedError();
}
