import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginInitial());

  void performLogin(String email, String password) async {
    final param = LoginRequest(email: email, password: password);
    emit(LoginLoading());
    try {
      final result = await authRepository.login(param);
      emit(LoginSuccess(userInfo: result));
    } on ErrorException catch (e) {
      emit(LoginFailure(errorMessage: e.errorMessage));
    }
  }
}
