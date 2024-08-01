import 'package:acegases_hms/Utils/utils.dart';
import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Utils.printInfo(
        "--> ${options.method.toUpperCase()} ${"" + (options.baseUrl) + (options.path)}");
    Utils.printInfo("Headers:");
    options.headers.forEach((k, v) => Utils.printInfo('$k: $v'));
    Utils.printInfo("queryParameters:");
    options.queryParameters.forEach((k, v) => Utils.printInfo('$k: $v'));
    if (options.data != null) {
      Utils.printInfo("Body: ${options.data}");
    }
    Utils.printInfo("--> END ${options.method.toUpperCase()}");

    return handler.next(options);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    Utils.printInfo(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    Utils.printInfo(
        "${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    Utils.printInfo("<-- End error");
    return handler.next(dioError);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Utils.printInfo(
        // ignore: unnecessary_null_comparison
        "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    Utils.printInfo("Headers:");
    response.headers.forEach((k, v) => Utils.printInfo('$k: $v'));
    Utils.printInfo("Response: ${response.data}");
    Utils.printInfo("<-- END HTTP");
    return handler.next(response);
  }
}
