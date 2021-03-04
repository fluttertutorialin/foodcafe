import 'package:get/get.dart';

enum Method {
  GET,
  POST,
  DELETE,
  PUT,
}

const MethodValues = {
  Method.GET: 'get',
  Method.POST: 'post',
  Method.DELETE: 'delete',
  Method.PUT: 'put',
};

typedef HttpSuccessCallback<T> = void Function(T data);
typedef HttpFailureCallback = void Function(ErrorEntity data);

class HttpHelper extends GetConnect {
  Future requestToServer<T>(String baseUrl,
      {String path = '',
      String encode = 'utf-8',
      Map<String, String> headers,
      String contentType = 'application/json',
      dynamic body,
      Map<String, dynamic> query,
      Method method = Method.GET,
      HttpSuccessCallback<T> success,
      HttpFailureCallback error}) async {
    try {
      final response = await request(baseUrl, MethodValues[method],
          body: body, contentType: contentType, headers: headers, query: query);
      if (response.status.hasError) {
        return error(ErrorEntity(
            code: response.statusCode, message: response.statusText));
      } else {
        return success(response.body);
      }
    } on NoSuchMethodError {
      return error(ErrorEntity(message: 'Method call invalid!'));
    } on ArgumentError{
      return error(ErrorEntity(message: 'No host specified in URI!'));
    }
  }
}

class ErrorEntity {
  int code;
  String message;

  ErrorEntity({this.code, this.message});
}
