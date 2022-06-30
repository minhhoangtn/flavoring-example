import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/model/request/auth/register_request.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequest param);

  Future<void> registerAccount(RegisterRequest param);
}
