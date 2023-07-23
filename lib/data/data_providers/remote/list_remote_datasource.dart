import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';

// import '../../../config/vars/constants.dart';
import '../../../config/tags.dart';

import 'package:http/http.dart' as http;

import 'http_vars.dart';

// abstract class ListRemoteDataSource {
//   Future<ResponseModel> create(String name);
//   Future<Either<ResponseModel, List<ListModel>>> read();
//   Future<ResponseModel> update(String uuid, String name);
//   Future<ResponseModel> delete(String uuid);
// }

class ListRemoteDataSource {
  // final http.Client httpClient;
  // ListDataSourceImpl(this.httpClient);

  final myBase = Hive.box(Tags.hiveBase);
  String? get token => myBase.get(Tags.hiveToken);

  Future<Response> create(String name) {
    print("Url:=${Uris.lists}");
    return HttpFuncs.tokenChecker(
        token,
        "ListRemoteDataSource>create($name):",
        http.post(
          Uris.lists,
          headers: Headers.bearer(token!),
          body: json.encode({"name": name}),
        ));
  }

  Future<Response> read() {
    print("Url:=${Uris.lists}");
    return HttpFuncs.tokenChecker(token, "ListRemoteDataSource>read:",
        http.get(Uris.lists, headers: Headers.bearer(token!)));
  }

  Future<Response> delete(String uuid) {
    print("Url:=${Uris.listChange(uuid)}");
    return HttpFuncs.tokenChecker(
        token,
        "ListRemoteDataSource>delete($uuid):",
        http.delete(
          Uris.listChange(uuid),
          headers: Headers.bearer(token!),
        ));
  }

  Future<Response> update(String uuid, String name) {
    print("Url:=${Uris.listChange(uuid)}");
    return HttpFuncs.tokenChecker(
        token,
        "ListRemoteDataSource>update($uuid):",
        http.put(
          Uris.listChange(uuid),
          headers: Headers.bearer(token!),
          body: json.encode({"name": name}),
        ));
  }

  // @override
  // Future<ResponseModel> create(String name) async {
  //   print("Url:=${Uris.lists}");
  //   const where = "ListDataSourceImpl>create";
  //   return HttpFuncs.tokenChecker(
  //     token,
  //     where,
  //     httpClient
  //         .post(
  //       Uris.lists,
  //       headers: Headers.bearer(token!),
  //       body: json.encode({"name": name}),
  //     )
  //         .then((response) {
  //       Map<String, dynamic> res = json.decode(response.body);
  //       print("$where response:=$res");
  //       return HttpFuncs.tryerChecker(
  //         where,
  //         HttpFuncs.statusCodeChecker(
  //           ResponseModel(message: "Success", status: true),
  //           response.statusCode,
  //         ),
  //       ) as ResponseModel;
  //     }),
  //   );
  // }

  // @override
  // Future<Either<ResponseModel, List<ListModel>>> read() async {
  //   print("Url:=${Uris.lists}");
  //   const where = "ListDataSourceImpl>read";
  //   return HttpFuncs.errCatcher(
  //       token,
  //       where,
  //       httpClient
  //           .get(
  //         Uris.lists,
  //         headers: Headers.bearer(token!),
  //       )
  //           .then((response) {
  //         List res = json.decode(response.body);
  //         print("$where response:=$res");
  //         final result = HttpFuncs.statusCodeChecker(
  //           ListModel.fromJsonList(res),
  //           response.statusCode,
  //         );
  //         try {
  //           return Right<ResponseModel, List<ListModel>>(result);
  //         } catch (e) {
  //           return Left<ResponseModel, List<ListModel>>(result);
  //         }
  //       }));
  // }

  // @override
  // Future<ResponseModel> update(String uuid, String name) async {
  //   print("Url:=${Uris.listChange(uuid)}");
  //   const where = "ListDataSourceImpl>update";
  //   return HttpFuncs.errCatcher(
  //       token,
  //       where,
  //       httpClient
  //           .put(
  //         Uris.listChange(uuid),
  //         headers: Headers.bearer(token!),
  //         body: json.encode({"name": name}),
  //       )
  //           .then((response) {
  //         Map<String, dynamic> res = json.decode(response.body);
  //         print("$where response:=$res");
  //         return HttpFuncs.statusCodeChecker(
  //           ResponseModel.frowJson(res),
  //           response.statusCode,
  //         ) as ResponseModel;
  //       }));
  // }

  // @override
  // Future<ResponseModel> delete(String uuid) async {
  //   print("Url:=${Uris.listChange(uuid)}");
  //   const where = "ListDataSourceImpl>delete";
  //   return HttpFuncs.errCatcher(
  //     token,
  //     where,
  //     httpClient
  //         .delete(
  //       Uris.listChange(uuid),
  //       headers: Headers.bearer(token!),
  //     )
  //         .then((response) {
  //       Map<String, dynamic> res = json.decode(response.body);
  //       print("$where response:=$res");
  //       return HttpFuncs.statusCodeChecker(
  //         ResponseModel.frowJson(res),
  //         response.statusCode,
  //       ) as ResponseModel;
  //     }),
  //   );
  // }
}
