import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_down_event.dart';
part 'count_down_state.dart';

class CountDownBloc extends Bloc<CountDownEvent, CountDownState> {
  CountDownBloc() : super(const CountDownInitial(0)) {
    on<CountDownEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
