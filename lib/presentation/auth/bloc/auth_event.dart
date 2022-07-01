part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final UserEntity userInfo;

  const LoggedIn({
    required this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}

class LoggedOut extends AuthEvent {
  const LoggedOut();

  @override
  List<Object> get props => [];
}
