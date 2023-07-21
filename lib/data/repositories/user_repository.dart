import 'dart:convert';

import 'package:hive/hive.dart';

import '../../config/tags.dart';
import '../data_providers/remote/http_vars.dart';
import '../data_providers/remote/user_remote_datasource.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserRemoteDataSource _userApi = UserRemoteDataSource();
  // UserRepository({required this.userApi});

  Future<ResponseModel> signUp(UserModel user) async {
    //  Map<String, dynamic> body = json.decode(response.body);
    final response = await _userApi.signUp(user);
    final Map body = json.decode(response.body);
    print("UserRepository>signUp response: $body");
    final result = HttpFuncs.statusCodeChecker(
      body["token"],
      response.statusCode,
    );
    if (result is String) {
      final myBase = Hive.box(Tags.hiveBase);
      myBase.put(Tags.hiveToken, result);
      myBase.put(Tags.hiveIsLogin, true);
      return ResponseModel(status: true, message: "Success!");
    } else {
      return result;
    }
  }

  Future<ResponseModel> login(UserModel user) async {
    //  Map<String, dynamic> body = json.decode(response.body);
    final response = await _userApi.login(user);
    final Map body = json.decode(response.body);
    print("UserRepository>login response: $body");
    final result = HttpFuncs.statusCodeChecker(
      body["token"],
      response.statusCode,
    );
    if (result is String) {
      final myBase = Hive.box(Tags.hiveBase);
      myBase.put(Tags.hiveToken, result);
      myBase.put(Tags.hiveIsLogin, true);
      return ResponseModel(status: true, message: "Success!");
    } else {
      return result;
    }
  }

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
}
