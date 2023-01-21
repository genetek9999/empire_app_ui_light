import 'package:dio/dio.dart';
import 'package:empire_app_ui/constants/app_keys.dart';
import 'package:empire_app_ui/helpers/shared_preferences.dart';
import 'package:logger/logger.dart';

Dio dioClient(String baseUrl) {
  final dio = Dio();

  dio.options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  dio.interceptors.addAll([
    InterceptorsWrapper(
      onRequest: requestInterceptor,
      onResponse: responseInterceptor,
      onError: errorInterceptor,
    ),
  ]);

  return dio;
}

dynamic requestInterceptor(
  RequestOptions request,
  RequestInterceptorHandler handler,
) async {
  String token = await SharedPreferencesHelper.getString(AppKeys.accessToken);

  request.headers.addAll({
    "Content-Type": "application/json",
  });

  if (token != "") {
    request.headers.addAll({
      "Authorization": "Bearer $token",
    });
  }

  Logger().i({
    request.method: request.uri,
    "headers": request.headers,
    "body": request.data,
  });

  return handler.next(request);
}

dynamic responseInterceptor(
  Response response,
  ResponseInterceptorHandler handler,
) async {
  if (response.statusCode == 200) {
    dynamic data = response.data["data"];

    Logger().w({
      response.requestOptions.method: response.requestOptions.uri,
      "data": data,
    });

    return handler.next(
      Response(
        requestOptions: response.requestOptions,
        data: data,
      ),
    );
  }

  return DioError(
    requestOptions: response.requestOptions,
    error: "User is no longer active",
  );
}

dynamic errorInterceptor(DioError error, ErrorInterceptorHandler handler) {
  if (error.response?.statusCode == 401) {
    // this will push a new route and remove all the routes that were present
  }

  Logger().e(error);

  return handler.next(error);
}
