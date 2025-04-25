
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:light_quiz/core/helper/di.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  static const String baseUrl = 'https://api.theknight.tech';

  Future<Response> getWithToken(String endPoint) async {
    final token = await getToken();

    final response = await _dio.get(
      "$baseUrl$endPoint",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response;
  }

  Future<Response> postWithToken(String endPoint, dynamic data) async {
    final token = await getToken();
    final response = await _dio.post(
      "$baseUrl$endPoint",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response;
  }

  Future<Response> post(String endPoint, Map<String, dynamic> data) async {
    final response = await _dio.post("$baseUrl$endPoint", data: data);
    return response;
  }

  Future<Response> get(String endPoint) async {
    final response = await _dio.get("$baseUrl/$endPoint");
    return response;
  }

  Future<String?> getToken() async {
    return await getIt.get<FlutterSecureStorage>().read(key: "token");
  }
}
