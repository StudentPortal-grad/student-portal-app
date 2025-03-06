import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  static const String urlencodedType = 'application/x-www-form-urlencoded';
  static const String jsonType = 'application/json';
  static const String multiPart = "multipart/form-data";
  static const int unauthorizedCode = 401;
  static const int internalServerErrorCode = 500;
  static const String authorizationParameter = 'Authorization';
  static const String bearer = 'Test_';

  ApiService(this._dio);

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? data,
    FormData? formData,
    String? token,
  }) async {
    _dio.options.headers = {'Authorization': 'Bearer $token'};

    assert(!(data != null && formData != null),
        "Both 'body' and 'formData' should not be provided at the same time.");

    var response = await _dio.post(endpoint,
        data: data ?? formData,
        options: Options(
          contentType: formData != null ? multiPart : jsonType,
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    String? refreshToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      if (refreshToken != null) 'x-refresh-token': refreshToken,
    };
    var response = await _dio.patch(
      endpoint,
      queryParameters: query,
      data: data,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? query,
    String? token,
    String? refreshToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      if (refreshToken != null) 'x-refresh-token': refreshToken,
    };
    var response = await _dio.get(
      endpoint,
      queryParameters: query ?? {},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, dynamic>? query,
    String? token,
    String? refreshToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      if (refreshToken != null) 'x-refresh-token': refreshToken,
    };
    var response = await _dio.delete(
      endpoint,
      queryParameters: query,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    String? refreshToken,
    String? id,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      if (refreshToken != null) 'x-refresh-token': refreshToken,
    };
    var response = await _dio.put(endpoint, data: data, queryParameters: {
      "id": id,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> sendFormData({
    required String endpoint,
    required FormData formData,
    String? refreshToken,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      if (refreshToken != null) 'x-refresh-token': refreshToken,
    };
    var response = await _dio.patch(
      endpoint,
      data: formData,
      queryParameters: params ?? {},
    );
    return response.data;
  }
}
