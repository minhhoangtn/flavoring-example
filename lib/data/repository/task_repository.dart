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
  TaskDAO taskDAO;
  TaskRepositoryImpl(this.taskDAO);

  @override
  Future<TaskEntity> addTask(AddTaskRequest param, String userId) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      String taskId = const Uuid().v1();
      final task = TaskEntity(
          id: taskId,
          userId: userId,
          title: param.title,
          note: param.note,
          deadline: param.deadline,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      await taskDAO.addTask(task);

      return task;
    } on ErrorException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<TaskEntity>> fetchListTask(String userId) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final userTasks = taskDAO.getAllUserTask(userId);
      return userTasks;
    } on ErrorException catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTask(String taskId) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await taskDAO.deleteTask(taskId);
      return true;
    } on ErrorException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateTask(TaskEntity task) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final taskId = task.id;
      await taskDAO.updateTask(task, taskId);
      return true;
    } on ErrorException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> changeStatus(String taskId) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      var task = taskDAO.getTaskDetail(taskId);
      task = task.copyWithNewStatus();

      await taskDAO.updateTask(task, taskId);

      return true;
    } on ErrorException catch (e) {
      return false;
    }
  }
}
