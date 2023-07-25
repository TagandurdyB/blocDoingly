import 'package:either_dart/either.dart';

import '/data/models/response_model.dart';
import '../../../config/errors/error_messages.dart';

class Uris {
//Domain========================================================================

  static String ip = "119.235.112.154";
  static String port = "3003";
  static String domain = "$ip:$port";
  static String api = "http://$domain";
//List=========================================================================
  static Uri lists = Uri.parse("$api/api/v1/lists");
  static Uri listChange(String uuid) => Uri.parse("$api/api/v1/lists/$uuid");
  //Task=========================================================================
  static Uri taskFromList(String listUuid) =>
      Uri.parse("$api/api/v1/lists/$listUuid/tasks");
  static Uri tasks = Uri.parse("$api/api/v1/tasks");
  static Uri taskChange(String uuid) => Uri.parse("$api/api/v1/tasks/$uuid");
  //User=========================================================================
  static Uri register = Uri.parse("$api/api/v1/users/register");
  static Uri login = Uri.parse("$api/api/v1/users/login");
}

class Headers {
  static Map<String, String> contentJson = {
    'Content-Type': 'application/json',
  };
  static Map<String, String> multipart = {
    'Content-Type': 'multipart/form-data',
    "Accept": 'application/json',
  };

  static Map<String, String> bearer(String token) => {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      };
}

class HttpFuncs {
  static errCatcher(String? token, String location, dynamic obj) {
    if (token != null) {
      try {
        return obj;
      } catch (err) {
        throw "$location ERROR : $err";
      }
    }
    throw "$location I need Token";
  }

  static tokenChecker(String? token, String location, dynamic obj) {
    if (token != null) {
      return obj;
    }
    throw "$location I need Token";
  }

  static tryerChecker(String location, dynamic obj) {
    try {
      return obj;
    } catch (err) {
      throw "$location ERROR : $err";
    }
  }

  static statusCodeChecker(dynamic obj, int code, {bool isEith = false}) {
    String message = "Null";
    if (code == 200) {
      if (!isEith) {
        return obj;
      }
    } else if (code == 400) {
      message = ErrorsMessages.api400;
    } else if (code == 401) {
      message = ErrorsMessages.api401;
    } else if (code == 500) {
      message = ErrorsMessages.api500;
    } else if (code == 404) {
      message = ErrorsMessages.api404;
    } else if (code == 409) {
      message = ErrorsMessages.api409;
    } else {
      message = ErrorsMessages.apiUnexpected;
    }
    if (isEith) {
      try {
        return Right(obj);
      } catch (e) {
        return Left(ResponseModel(status: false, message: message));
      }
    } else {
      return ResponseModel(status: false, message: message);
    }
  }
}
