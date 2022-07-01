part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class Uninitialized extends AuthState {
  const Uninitialized();

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final UserEntity userInfo;

  const Authenticated({
    required this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object> get props => [];
}
