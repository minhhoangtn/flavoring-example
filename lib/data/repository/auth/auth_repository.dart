import 'package:flavoring/data/data_source/remote/auth_service.dart';
import 'package:flavoring/data/repository/auth/auth_repository_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;

  AuthRepositoryImpl(this.authService);
}
