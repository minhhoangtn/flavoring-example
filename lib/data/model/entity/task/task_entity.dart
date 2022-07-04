import 'package:json_annotation/json_annotation.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  final String id;
  final String userId;
  final String title;
  final String note;
  final int deadline;
  final bool isDone;
  final int createdAt;

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  @override
  String toString() {
    return 'TaskEntity{id: $id, userId: $userId, title: $title, note: $note, deadline: $deadline,createdAt: $createdAt, isDone: $isDone}';
  }

  const TaskEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.note,
    required this.deadline,
    required this.createdAt,
    this.isDone = false,
  });

  TaskEntity copyWithNewStatus() {
    return TaskEntity(
      id: id,
      userId: userId,
      title: title,
      note: note,
      deadline: deadline,
      isDone: !isDone,
      createdAt: createdAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        userId,
        title,
        note,
        deadline,
        isDone,
        createdAt,
      ];

  TaskEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? note,
    int? deadline,
    bool? isDone,
    int? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      note: note ?? this.note,
      deadline: deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
