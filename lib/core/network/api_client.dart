
import 'package:desktop_application/core/services/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio;
  final SharedPrefsService _sharedPrefsService;

  ApiService(String baseUrl, this._sharedPrefsService)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    // Add interceptors for request and response handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to headers
          String? token = _sharedPrefsService.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) async {
          // Handle null response data
          if (response.data == []) {
            if (kDebugMode) {
              print("Response data is null. Please check the API.");
            }
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                error: 'Response data is null.',
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: response.requestOptions,
                  statusCode: 204,
                  statusMessage: 'No content received.',
                ),
              ),
            );
          } else {
            handler.next(response); // Continue with the response
          }
        },
        onError: (DioException e, handler) {
          // Handle errors globally
          if (kDebugMode) {
            print("Error occurred: ${e.message}");
          }
          handler.next(e);
        },
      ),
    );
  }

  // Generic GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options ?? Options(),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic POST request
  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await _dio.post(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> postForm(String endpoint,
      {FormData? data, Options? options}) async {
    try {
      final response = await _dio.post(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic PUT request
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic DELETE request
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Error handling
  Response _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) {
          print("Connection Timeout Error: ${error.message}");
        }
        break;
      case DioExceptionType.sendTimeout:
        if (kDebugMode) {
          print("Send Timeout Error: ${error.message}");
        }
        break;
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) {
          print("Receive Timeout Error: ${error.message}");
        }
        break;
      case DioExceptionType.badResponse:
        if (kDebugMode) {
          print("Bad Response Error: ${error.response?.data}");
        }
        return error.response!;
      case DioExceptionType.cancel:
        if (kDebugMode) {
          print("Request Cancelled: ${error.message}");
        }
        break;
      case DioExceptionType.badCertificate:
        if (kDebugMode) {
          print("Bad Certificate Error: ${error.message}");
        }
        break;
      case DioExceptionType.connectionError:
        if (kDebugMode) {
          print("Connection Error: ${error.message}");
        }
        break;
      case DioExceptionType.unknown:
        if (kDebugMode) {
          print("Unknown Error: ${error.message}");
        }
        break;
    }
    return error.response ??
        Response(
          requestOptions: RequestOptions(
            path: error.requestOptions.path,
          ),
          statusCode: 500,
          statusMessage: 'An unknown error occurred.',
        );
  }
}
