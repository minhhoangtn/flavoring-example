import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String password;
  final String fullName;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  const UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, password: $password, fullName: $fullName}';
  }

  @override
  List<Object> get props => [id, email, password, fullName];
}
