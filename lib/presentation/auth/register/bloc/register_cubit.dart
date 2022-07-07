import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/auth/register_request.dart';
import 'package:flavoring/data/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  AuthRepository authRepository;
  RegisterCubit(this.authRepository) : super(RegisterInitial());

  void performRegister(String email, String password, String fullName) async {
    final param =
        RegisterRequest(email: email, password: password, fullName: fullName);
    emit(RegisterLoading());
    try {
      await authRepository.registerAccount(param);
      emit(RegisterSuccess());
    } on ErrorException catch (e) {
      emit(RegisterFailure(e.errorMessage));
    }
  }
}
