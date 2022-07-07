import 'dart:convert';

import 'package:flavoring/core/db_helper/db_helper_barrel.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';

abstract class TaskDAO {
  Future<void> addTask(TaskEntity task);

  Future<void> updateTask(TaskEntity task, String taskId);

  Future<void> deleteTask(String taskId);

  List<TaskEntity> getAllUserTask(String userId);

  TaskEntity getTaskDetail(String taskId);
}

class TaskDAOImpl implements TaskDAO {
  @override
  Future<void> addTask(TaskEntity task) async {
    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.task, task.id, jsonEncode(task.toJson()));
    if (!result) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final result =
        await HiveHelper.instance.deleteItem<String>(HiveDB.task, taskId);
    if (!result) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
  }

  @override
  Future<void> updateTask(TaskEntity task, String taskId) async {
    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.task, taskId, jsonEncode(task.toJson()));
    if (!result) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
  }

  @override
  List<TaskEntity> getAllUserTask(String userId) {
    final dbData = HiveHelper.instance.getListItem<String>(HiveDB.task);
    if (dbData == null) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }

    final allTask =
        dbData.map((e) => TaskEntity.fromJson(jsonDecode(e))).toList();
    return allTask.where((element) => element.userId == userId).toList();
  }

  @override
  TaskEntity getTaskDetail(String taskId) {
    final dbData = HiveHelper.instance.getItem<String>(HiveDB.task, taskId);
    if (dbData == null) {
      throw (ErrorException('Lỗi xảy ra ở HIVE'));
    }
    return TaskEntity.fromJson(jsonDecode(dbData));
  }
}
