part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class LoginSuccess extends LoginState {
  final UserEntity userInfo;

  @override
  List<Object> get props => [userInfo];

  const LoginSuccess({
    required this.userInfo,
  });
}
