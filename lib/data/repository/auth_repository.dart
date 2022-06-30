import 'dart:convert';

import 'package:flavoring/data/data_source/local/hive_helper.dart';
import 'package:flavoring/data/data_source/remote/auth_service.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/model/request/auth/register_request.dart';
import 'package:uuid/uuid.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequest param);

  Future<void> registerAccount(RegisterRequest param);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<void> registerAccount(RegisterRequest param) async {
    String userId = const Uuid().v1();
    UserEntity user = UserEntity(
        id: userId,
        email: param.email,
        password: param.password,
        fullName: param.fullName);

    final List<String>? userDBData =
        HiveHelper.instance.getListItem<String>(HiveDB.user);
    if (userDBData == null) {
      throw (ErrorException('Dữ liệu DB đang null'));
    }

    final List<UserEntity> userList =
        userDBData.map((e) => UserEntity.fromJson(jsonDecode(e))).toList();

    int userExistResult =
        userList.indexWhere((element) => element.email == param.email);
    print(userList);
    if (userExistResult != -1) {
      throw (ErrorException('Email đã có người sử dụng'));
    }

    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.user, userId, jsonEncode(user.toJson()));

    if (!result) {
      throw (ErrorException('Không thể thêm vào DB'));
    }
  }

  @override
  Future<UserEntity> login(LoginRequest param) async {
    await Future.delayed(const Duration(seconds: 2));
    final List<String>? userDBData =
        HiveHelper.instance.getListItem<String>(HiveDB.user);

    if (userDBData == null) {
      throw (ErrorException(
          'Dữ liệu DB đang null => Không thể đăng nhập cần dăng kí thêm tk'));
    }
    final List<UserEntity> userList =
        userDBData.map((e) => UserEntity.fromJson(jsonDecode(e))).toList();

    final query =
        userList.indexWhere((element) => element.email == param.email);
    if (query == -1) {
      throw (ErrorException('Email không tồn tại'));
    }
    if (userList[query].password != param.password) {
      throw (ErrorException('Mật khẩu sai'));
    }
    return userList[query];
  }
}
