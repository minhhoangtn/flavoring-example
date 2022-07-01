import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/repository/auth_repository.dart';
import 'package:flavoring/utils/session/app_session.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(const Uninitialized()) {
    on<AppStarted>((event, emit) async {
      print('app started');
      final token = AppSession.accessToken;
      if (token == null) {
        print('need login');
        emit(const Unauthenticated());
      } else {
        print('go home');
        emit(const Authenticated(
            userInfo: UserEntity(
                id: 'abc',
                fullName: 'hoang minh',
                email: 'hoang@maik',
                password: 'hoang')));
      }
    });
    on<LoggedIn>((event, emit) async {
      final saveResult = await AppSession.saveAccessToken(event.userInfo.id);
      if (!saveResult) throw ('lỗi rồi');

      emit(Authenticated(userInfo: event.userInfo));
    });
    on<LoggedOut>((event, emit) async {
      final saveResult = await AppSession.removeAccessToken();
      if (!saveResult) throw ('lỗi rồi');
      emit(const Unauthenticated());
    });
  }
}
