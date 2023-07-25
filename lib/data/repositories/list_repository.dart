import 'dart:convert';

import '../../config/services/tost_service.dart';
import '../models/list_model.dart';
import '../models/response_model.dart';
import 'package:either_dart/either.dart';

import '../data_providers/remote/http_vars.dart';
import '../data_providers/remote/list_remote_datasource.dart';

class ListRepository {
  final ListRemoteDataSource _listApi = ListRemoteDataSource();

  Future<Either<ResponseModel, ListModel>> create(String name) async {
    final response = await _listApi.create(name);
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("ListRepository>create response: ${response.body}");
    if (result is ResponseModel) {
      print("ListRepository>create retult: ${result.message}");
      return Left(result);
    } else if (result is String) {
      return Right(ListModel.fromJson(result));
    }
    return result;
  }

  Future<List<ListModel>> read() async {
    final response = await _listApi.read();
    final result =
        HttpFuncs.statusCodeChecker(response.body, response.statusCode);
    print("ListRepository>read response: ${response.body}");
    if (result is ResponseModel) {
      print("ListRepository>read retult: ${result.message}");
      TostService.message(result.message, result.status);
    } else if (result is String) {
      final List body = json.decode(result);
      print("ListRepository>read retult: $body");
      return ListModel.fromList(body);
    }
    return [];
  }

  Future<ResponseModel> delete(String uuid) async {
    final response = await _listApi.delete(uuid);
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("ListRepository>delete response: ${response.body}");
    if (result is ResponseModel) {
      print("ListRepository>delete retult: ${result.message}");
      return result;
    } else if (result is String) {
      return ResponseModel(status: true, message: "Success");
    }
    return result;
  }

  Future<ResponseModel> update(ListModel list) async {
    final response = await _listApi.update(list.uuid, list.name);
    final result = HttpFuncs.statusCodeChecker(
      response.body,
      response.statusCode,
    );
    print("ListRepository>update response: ${response.body}");
    if (result is ResponseModel) {
      print("ListRepository>update retult: ${result.message}");
      return result;
    } else if (result is String) {
      return ResponseModel(status: true, message: "Success");
    }
    return result;
  }
}
