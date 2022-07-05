import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/model/request/auth/register_request.dart';
import 'package:uuid/uuid.dart';

abstract class AuthRepository {
  UserEntity autoLogin(String token);
  Future<UserEntity> login(LoginRequest param);
  Future<void> registerAccount(RegisterRequest param);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  UserDAO userDAO;

  AuthRepositoryImpl(this.userDAO);

  @override
  Future<void> registerAccount(RegisterRequest param) async {
    try {
      String userId = const Uuid().v1();
      UserEntity user = UserEntity(
          id: userId,
          email: param.email,
          password: param.password,
          fullName: param.fullName);

      final userList = userDAO.getAllUser();

      int userExistResult =
          userList.indexWhere((element) => element.email == param.email);
      if (userExistResult != -1) {
        throw (ErrorException('Email đã có người sử dụng'));
      }

      await userDAO.addUser(user);
    } on ErrorException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> login(LoginRequest param) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final userList = userDAO.getAllUser();

      final query =
          userList.indexWhere((element) => element.email == param.email);
      if (query == -1) {
        throw (ErrorException('Email không tồn tại'));
      }
      if (userList[query].password != param.password) {
        throw (ErrorException('Mật khẩu sai'));
      }

      return userList[query];
    } on ErrorException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {}

  @override
  UserEntity autoLogin(String token) {
    try {
      return userDAO.getUser(token);
    } on ErrorException catch (_) {
      rethrow;
    }
  }
}
