import 'package:dio/dio.dart';
import 'package:empire_app_ui/constants/app_keys.dart';
import 'package:empire_app_ui/constants/endpoints.dart';
import 'package:empire_app_ui/services/dio_client.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

class ApiService {
  ApiService._();
  static final ApiService _apiService = ApiService._();
  static ApiService get instance => _apiService;

  RestClientApi get restClient => RestClientApi(dioClient(AppKeys.baseUrl));
}

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class RestClientApi {
  factory RestClientApi(Dio dio, {String baseUrl}) = _RestClientApi;

  @POST(Endpoints.login)
  Future<dynamic> login(@Body() Map<String, dynamic> body);

  @POST(Endpoints.signup)
  Future<dynamic> signup(@Body() Map<String, dynamic> body);
}
