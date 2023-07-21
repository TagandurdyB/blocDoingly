// import 'dart:convert';

// import 'package:either_dart/either.dart';
// import 'package:hive/hive.dart';

// import '../../../config/vars/constants.dart';
// import '../../models/response_model.dart';
// import '../../models/task_model.dart';
// import 'package:http/http.dart' as http;

// import 'http_vars.dart';

// abstract class TaskRemoteDataSource {
//   Future<ResponseModel> create(TaskModel task);
//   Future<Either<ResponseModel, List<List<TaskModel>>>> readAll();
//   Future<Either<ResponseModel, List<TaskModel>>> readByList(String listUuid);
//   Future<ResponseModel> update(String uuid, TaskModel task);
//   Future<ResponseModel> delete(String uuid);
// }

// class TaskDataSourceImpl implements TaskRemoteDataSource {
//   final http.Client httpClient;
//   TaskDataSourceImpl(this.httpClient);

//   final myBase = Hive.box(Tags.hiveBase);
//   String? get token => myBase.get(Tags.hiveToken);

//   @override
//   Future<ResponseModel> create(TaskModel task) async {
//     print("Url:=${Uris.tasks}");
//     print("Task:=${task.toJson()}");
//     const where = "TaskDataSourceImpl>create";
//     return HttpFuncs.errCatcher(
//         token,
//         where,
//         httpClient
//             .post(
//           Uris.tasks,
//           headers: Headers.bearer(token!),
//           body: json.encode(task.toJson()),
//         )
//             .then((response) {
//           Map<String, dynamic> res = json.decode(response.body);
//           print("$where response:=$res");
//           return HttpFuncs.statusCodeChecker(
//             ResponseModel(message: "Success", status: true),
//             response.statusCode,
//           ) as ResponseModel;
//         }));
//   }

//   @override
//   Future<Either<ResponseModel, List<List<TaskModel>>>> readAll() async {
//     print("Url:=${Uris.tasks}");
//     const where = "TaskDataSourceImpl>readAll";
//     return HttpFuncs.errCatcher(
//         token,
//         where,
//         httpClient
//             .get(
//           Uris.tasks,
//           headers: Headers.bearer(token!),
//         )
//             .then((response) {
//           List res = json.decode(response.body);
//           print("$where response:=$res");
//           final result = HttpFuncs.statusCodeChecker(
//             TaskModel.fromJsonListAll(res),
//             response.statusCode,
//           );
//           try {
//             return Right<ResponseModel, List<List<TaskModel>>>(result);
//           } catch (e) {
//             return Left<ResponseModel, List<List<TaskModel>>>(result);
//           }
//         }));
//   }

//   @override
//   Future<Either<ResponseModel, List<TaskModel>>> readByList(
//       String listUuid) async {
//     print("Url:=${Uris.taskFromList(listUuid)}");
//     const where = "TaskDataSourceImpl>readByList";
//     return HttpFuncs.errCatcher(
//         token,
//         where,
//         httpClient
//             .get(
//           Uris.taskFromList(listUuid),
//           headers: Headers.bearer(token!),
//         )
//             .then((response) {
//           List res = json.decode(response.body);
//           print("$where response:=$res");
//           final result = HttpFuncs.statusCodeChecker(
//             TaskModel.fromJsonList(res),
//             response.statusCode,
//           );
//           try {
//             return Right<ResponseModel, List<TaskModel>>(result);
//           } catch (e) {
//             return Left<ResponseModel, List<TaskModel>>(result);
//           }
//         }));
//   }

//   @override
//   Future<ResponseModel> update(String uuid, TaskModel obj) async {
//     print("Url:=${Uris.taskChange(uuid)}");
//     const where = "ListDataSourceImpl>update";
//     return HttpFuncs.errCatcher(
//         token,
//         where,
//         httpClient
//             .put(
//           Uris.taskChange(uuid),
//           headers: Headers.bearer(token!),
//           body: json.encode(obj.toJson()),
//         )
//             .then((response) {
//           Map<String, dynamic> res = json.decode(response.body);
//           print("$where response:=$res");
//           return HttpFuncs.statusCodeChecker(
//             ResponseModel.frowJson(res),
//             response.statusCode,
//           ) as ResponseModel;
//         }));
//   }

//   @override
//   Future<ResponseModel> delete(String uuid) async {
//     print("Url:=${Uris.taskChange(uuid)}");
//     const where = "TaskDataSourceImpl>delete";
//     return HttpFuncs.errCatcher(
//       token,
//       where,
//       httpClient
//           .delete(
//         Uris.taskChange(uuid),
//         headers: Headers.bearer(token!),
//       )
//           .then((response) {
//         Map<String, dynamic> res = json.decode(response.body);
//         print("$where response:=$res");
//         return HttpFuncs.statusCodeChecker(
//           ResponseModel.frowJson(res),
//           response.statusCode,
//         ) as ResponseModel;
//       }),
//     );
//   }
// }
