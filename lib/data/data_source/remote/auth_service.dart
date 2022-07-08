import 'package:dio/dio.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET('/login')
  Future<UserEntity> login(@Body() LoginRequest param);
}
