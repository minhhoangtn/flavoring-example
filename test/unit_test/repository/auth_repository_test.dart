import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../model/entity/user/user_entity_test.dart';
import '../model/request/auth/login_request_test.dart';

class MockUserDAO extends Mock implements UserDAO {}

void main() {
  late UserDAO mockUserDAO;
  late AuthRepository mockAuthRepository;
  UserEntity entity = MockUserEntity();

  setUp(() {
    mockUserDAO = MockUserDAO();
    mockAuthRepository = AuthRepositoryImpl(mockUserDAO);
  });

  test('Test login', () async {
    when(() => mockUserDAO.getAllUser()).thenAnswer((_) => [
          const UserEntity(
              id: '1',
              email: 'hoang@mail',
              password: '123456',
              fullName: 'hoang'),
          const UserEntity(
              id: '2', email: 'minh@mail', password: '12345', fullName: 'minh'),
          const UserEntity(
              id: '3', email: 'tu@mail', password: '1234', fullName: 'tu'),
          const UserEntity(
              id: '4', email: 'duc@mail', password: '123', fullName: 'duc')
        ]);

    expect(
        await mockAuthRepository
            .login(const LoginRequest(email: 'hoang@mail', password: '123456')),
        isA<UserEntity>());
  });
  test('Test login Exception', () async {
    when(() => mockUserDAO.getAllUser()).thenAnswer((_) => [
          const UserEntity(
              id: '1',
              email: 'hoang@mail',
              password: '123456',
              fullName: 'hoang'),
          const UserEntity(
              id: '2', email: 'minh@mail', password: '12345', fullName: 'minh'),
          const UserEntity(
              id: '3', email: 'tu@mail', password: '1234', fullName: 'tu'),
          const UserEntity(
              id: '4', email: 'duc@mail', password: '123', fullName: 'duc')
        ]);

    expect(
        () async => mockAuthRepository
            .login(const LoginRequest(email: 'hoangmail', password: '123456')),
        throwsA(isA<ErrorException>()));
  });
}
