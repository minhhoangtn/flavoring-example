import 'dart:convert';

import 'package:flavoring/core/db_helper/db_helper_barrel.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';

abstract class UserDAO {
  List<UserEntity> getAllUser();
  UserEntity getUser(String userId);
  Future<void> addUser(UserEntity user);
}

class UserDAOImpl implements UserDAO {
  @override
  Future<void> addUser(UserEntity user) async {
    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.user, user.id, jsonEncode(user.toJson()));
    if (!result) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
  }

  @override
  List<UserEntity> getAllUser() {
    final List<String>? dbData =
        HiveHelper.instance.getListItem<String>(HiveDB.user);
    if (dbData == null) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
    return dbData.map((e) => UserEntity.fromJson(jsonDecode(e))).toList();
  }

  @override
  UserEntity getUser(String userId) {
    final dbData = HiveHelper.instance.getItem<String>(HiveDB.user, userId);
    if (dbData == null) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
    return UserEntity.fromJson(jsonDecode(dbData));
  }
}
