part of 'count_down_bloc.dart';

abstract class CountDownEvent extends Equatable {
  const CountDownEvent();

  @override
  List<Object> get props => [];
}

class CountDownStart extends CountDownEvent {
  final int duration;
  const CountDownStart(this.duration);
}
