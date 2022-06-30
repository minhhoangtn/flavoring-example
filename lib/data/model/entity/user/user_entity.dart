import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final String id;
  final String email;
  final String password;
  final String fullName;
  final List<TaskEntity> taskList;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  const UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    this.taskList = const [],
  });

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, password: $password, fullName: $fullName, taskList: $taskList}';
  }
}

@JsonSerializable()
class TaskEntity {
  final String name;

  const TaskEntity({
    required this.name,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  @override
  String toString() {
    return 'TaskEntity{name: $name}';
  }
}
