import 'dart:convert';

import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/task/add_task_request.dart';
import 'package:uuid/uuid.dart';

abstract class TaskRepository {
  Future<TaskEntity> addTask(AddTaskRequest param, String userId);

  Future<bool> updateTask(TaskEntity task);

  Future<List<TaskEntity>> fetchListTask(String userId);
  Future<bool> deleteTask(String taskId);
  Future<bool> changeStatus(String taskId);
}

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl();

  @override
  Future<TaskEntity> addTask(AddTaskRequest param, String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    String taskId = const Uuid().v1();
    final task = TaskEntity(
        id: taskId,
        userId: userId,
        title: param.title,
        note: param.note,
        deadline: param.deadline,
        createdAt: DateTime.now().millisecondsSinceEpoch);
    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.task, taskId, jsonEncode(task.toJson()));

    if (!result) {
      throw (ErrorException('Không thể thêm vào DB'));
    } else {
      return task;
    }
  }

  @override
  Future<List<TaskEntity>> fetchListTask(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    final List<String>? taskDBData =
        HiveHelper.instance.getListItem<String>(HiveDB.task);
    if (taskDBData == null) {
      throw (ErrorException('Dữ liệu DB đang null'));
    }

    final taskList =
        taskDBData.map((e) => TaskEntity.fromJson(jsonDecode(e))).toList();

    final userTasks =
        taskList.where((element) => element.userId == userId).toList();
    return userTasks;
  }

  @override
  Future<bool> deleteTask(String taskId) async {
    await Future.delayed(const Duration(seconds: 2));
    return await HiveHelper.instance.deleteItem<String>(HiveDB.task, taskId);
  }

  @override
  Future<bool> changeStatus(String taskId) async {
    await Future.delayed(const Duration(seconds: 2));
    final dbItemData = HiveHelper.instance.getItem<String>(HiveDB.task, taskId);
    var task = TaskEntity.fromJson(jsonDecode(dbItemData!));
    task = task.copyWithNewStatus();
    return await HiveHelper.instance
        .addItem<String>(HiveDB.task, taskId, jsonEncode(task.toJson()));
  }

  @override
  Future<bool> updateTask(TaskEntity task) async {
    await Future.delayed(const Duration(seconds: 2));
    final taskId = task.id;
    return await HiveHelper.instance
        .addItem<String>(HiveDB.task, taskId, jsonEncode(task.toJson()));
  }
}
