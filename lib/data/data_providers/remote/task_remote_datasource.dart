import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

// import '../../../config/vars/constants.dart';
import '../../../config/tags.dart';
import '../../models/task_model.dart';
import 'http_vars.dart';

// abstract class TaskRemoteDataSource {
//   Future<ResponseModel> create(TaskModel task);
//   Future<Either<ResponseModel, List<List<TaskModel>>>> readAll();
//   Future<Either<ResponseModel, List<TaskModel>>> readByList(String listUuid);
//   Future<ResponseModel> update(String uuid, TaskModel task);
//   Future<ResponseModel> delete(String uuid);
// }

class TaskRemoteDataSource {
//   final http.Client httpClient;
//   TaskDataSourceImpl(this.httpClient);

  final myBase = Hive.box(Tags.hiveBase);
  String? get token => myBase.get(Tags.hiveToken);

  Future<Response> create(TaskModel task) {
    print("Url:=${Uris.tasks}");
    return HttpFuncs.tokenChecker(
      token,
      "TaskRemoteDataSource>create($task):",
      http.post(Uris.tasks,
          headers: Headers.bearer(token!), body: task.toJson()),
    );
  }

  Future<Response> read(String listUuid) {
    print("Url:=${Uris.taskFromList(listUuid)}");
    return HttpFuncs.tokenChecker(
        token,
        "TaskRemoteDataSource>read($listUuid):",
        http.get(Uris.taskFromList(listUuid), headers: Headers.bearer(token!)));
  }

  Future<Response> readAll() {
    print("Url:=${Uris.tasks}");
    return HttpFuncs.tokenChecker(
      token,
      "TaskRemoteDataSource>readAll:",
      http.get(Uris.tasks, headers: Headers.bearer(token!)),
    );
  }

  Future<Response> delete(String uuid) {
    print("Url:=${Uris.taskChange(uuid)}");
    return HttpFuncs.tokenChecker(
        token,
        "TaskRemoteDataSource>delete($uuid):",
        http.delete(
          Uris.taskChange(uuid),
          headers: Headers.bearer(token!),
        ));
  }

  Future<Response> update(TaskModel task) {
    print("Url:=${Uris.taskChange(task.uuid)}");
    return HttpFuncs.tokenChecker(
        token,
        "TaskRemoteDataSource>update(${task.uuid}):",
        http.put(
          Uris.taskChange(task.uuid),
          headers: Headers.bearer(token!),
          body: task.toJson(),
        ));
  }
}
