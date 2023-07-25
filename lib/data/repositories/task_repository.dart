import 'dart:convert';

import 'package:either_dart/either.dart';

import '../../config/services/tost_service.dart';
import '../data_providers/remote/http_vars.dart';
import '../data_providers/remote/task_remote_datasource.dart';
import '../models/response_model.dart';
import '../models/task_model.dart';

class TaskRepository {
  final TaskRemoteDataSource _taskApi = TaskRemoteDataSource();

  Future<Either<ResponseModel, TaskModel>> create(TaskModel task) async {
    final response = await _taskApi.create(task );
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("TaskRepository>create response: ${response.body}");
    if (result is ResponseModel) {
      print("TaskRepository>create retult: ${result.message}");
      return Left(result);
    } else if (result is String) {
      return Right(TaskModel.fromJson(result));
    }
    return result;
  }

  Future<List<TaskModel>> read(String listUuid) async {
    final response = await _taskApi.read(listUuid);
    final result =
        HttpFuncs.statusCodeChecker(response.body, response.statusCode);
    print("TaskRepository>read response: ${response.body}");
    if (result is ResponseModel) {
      print("TaskRepository>read retult: ${result.message}");
      TostService.message(result.message, result.status);
    } else if (result is String) {
      final List body = json.decode(result);
      print("TaskRepository>read retult: $body");
      return TaskModel.fromList(body);
    }
    return [];
  }

  Future<List<List<TaskModel>>> readAll() async {
    final response = await _taskApi.readAll();
    final result =
        HttpFuncs.statusCodeChecker(response.body, response.statusCode);
    print("TaskRepository>readAll response: ${response.body}");
    if (result is ResponseModel) {
      print("TaskRepository>readAll retult: ${result.message}");
      TostService.message(result.message, result.status);
    } else if (result is String) {
      final List body = json.decode(result);
      print("TaskRepository>readAll retult: $body");
      return TaskModel.fromListAll(body);
    }
    return [];
  }

  Future<ResponseModel> delete(String uuid) async {
    final response = await _taskApi.delete(uuid);
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("TaskRepository>delete response: ${response.body}");
    if (result is ResponseModel) {
      print("TaskRepository>delete retult: ${result.message}");
      return result;
    } else if (result is String) {
      return ResponseModel(status: true, message: "Success");
    }
    return result;
  }

  Future<ResponseModel> update(TaskModel list) async {
    final response = await _taskApi.update(list);
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("TaskRepository>update response: ${response.body}");
    if (result is ResponseModel) {
      print("TaskRepository>update retult: ${result.message}");
      return result;
    } else if (result is String) {
      return ResponseModel(status: true, message: "Success");
    }
    return result;
  }

  // Future<ResponseModel> delete(TaskModel task) async {
  //   final response = await _taskApi.delete(task.uuid);
  //   final result = HttpFuncs.statusCodeChecker(
  //     response.body,
  //     response.statusCode,
  //   );
  //   print("TaskRepository>delete response: ${response.body}");
  //   if (result is ResponseModel) {
  //     print("TaskRepository>delete retult: ${result.message}");
  //     return result;
  //   } else if (result is String) {
  //     return ResponseModel(status: true, message: "Success");
  //   }
  //   return result;
  // }

  // Future<ResponseModel> update(TaskModel task) async {
  //   final response = await _taskApi.update(task.uuid, task.name);
  //   final result = HttpFuncs.statusCodeChecker(
  //     response.body,
  //     response.statusCode,
  //   );
  //   print("TaskRepository>update response: ${response.body}");
  //   if (result is ResponseModel) {
  //     print("TaskRepository>update retult: ${result.message}");
  //     return result;
  //   } else if (result is String) {
  //     return ResponseModel(status: true, message: "Success");
  //   }
  //   return result;
  // }
}
