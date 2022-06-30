import 'dart:convert';

import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/model/exception/error_exception.dart';
import 'package:flavoring/data/model/request/task/add_task_request.dart';
import 'package:uuid/uuid.dart';

abstract class TaskRepository {
  Future<void> addTask(AddTaskRequest param);

  Future<List<TaskEntity>> fetchListTask();
}

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl();

  @override
  Future<void> addTask(AddTaskRequest param) async {
    String taskId = const Uuid().v1();
    final task = TaskEntity(
        id: taskId,
        userId: '10',
        title: param.title,
        note: param.note,
        deadline: param.deadline,
        createdAt: 1000);
    final result = await HiveHelper.instance
        .addItem<String>(HiveDB.task, taskId, jsonEncode(task.toJson()));

    if (!result) {
      throw (ErrorException('Không thể thêm vào DB'));
    }
  }

  @override
  Future<List<TaskEntity>> fetchListTask() async {
    final List<String>? taskDBData =
        HiveHelper.instance.getListItem<String>(HiveDB.task);
    if (taskDBData == null) {
      throw (ErrorException('Dữ liệu DB đang null'));
    }

    final taskList =
        taskDBData.map((e) => TaskEntity.fromJson(jsonDecode(e))).toList();
    return taskList;
  }
}
