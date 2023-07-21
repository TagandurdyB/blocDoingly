import 'dart:async';

import 'package:http/http.dart';

import '../../models/user_model.dart';
import 'package:http/http.dart' as http;

import 'http_vars.dart';

// abstract class UserRemoteDataSource {
//   // Future<Either<ResponseModel, String?>> signUp(UserModel user);
//   Future<Response> signUp(String body);
//   // Future<Either<ResponseModel, String?>> login(UserModel user);
//   Future<Response> login(String body);
// }

class UserRemoteDataSource  {
  // final http.Client httpClient;
  // UserDataSourceImpl(this.httpClient);

  Future<Response> signUp(UserModel user) {
     print("Url:=${Uris.register}");
    return http.post(Uris.register, headers: Headers.contentJson, body: user.toJson());
  }

  Future<Response> login(UserModel user) {
     print("Url:=${Uris.login}");
    return http.post(Uris.login, headers: Headers.contentJson, body: user.toJson());
  }
  // @override
  // Future<Either<ResponseModel, String?>> signUp(UserModel user) async {
  //   print("Url:=${Uris.register}");
  //   const where = "UserDataSourceImpl>signUp";
  //   return await httpClient
  //       .post(
  //     Uris.register,
  //     headers: Headers.contentJson,
  //     body: json.encode(user.toJsonRegister()),
  //   )
  //       .then((response) {
  //     Map<String, dynamic> res = json.decode(response.body);
  //     print("$where response:=$res");
  //     final result = HttpFuncs.tryerChecker(
  //         where,
  //         HttpFuncs.statusCodeChecker(
  //           res["token"],
  //           response.statusCode,
  //           isEith: true,
  //         ));
  //     try {
  //       return Right(result);
  //     } catch (e) {
  //       return Left(result);
  //     }
  //   });
  // }

  // @override
  // Future<Either<ResponseModel, String?>> login(UserModel user) async {
  //   print("Url:=${Uris.login}");
  //   const where = "UserDataSourceImpl>login";
  //   return await httpClient
  //       .post(
  //     Uris.login,
  //     headers: Headers.contentJson,
  //     body: json.encode(user.toJsonLogin()),
  //   )
  //       .then((response) {
  //     Map<String, dynamic> res = json.decode(response.body);
  //     print("$where response:=$res");
  //     final result = HttpFuncs.tryerChecker(
  //         where,
  //         HttpFuncs.statusCodeChecker(
  //           res["token"],
  //           response.statusCode,
  //           isEith: true,
  //         ));
  //     try {
  //       return Right(result);
  //     } catch (e) {
  //       return Left(result);
  //     }
  //   });
  // }
}
