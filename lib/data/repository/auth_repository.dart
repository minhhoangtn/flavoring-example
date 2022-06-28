import 'package:flavoring/data/data_source/remote/auth_service.dart';
import 'package:flavoring/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;

  AuthRepositoryImpl(this.authService);
}
