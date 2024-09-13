import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:shared_preferences/shared_preferences.dart'; // For SharedPreferences
import 'dart:io';
import 'dart:convert'; // For JSON encoding

import 'package:yeni_okul/service/apiUrls.dart';

import '../util/SharedPrefHelper.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();

  static final APIService instance = APIService._singleton();
  static const TIME_OUT = 30 * 1000;

  String get baseUrl {
    if (kDebugMode) {
      return mainUrl;
    }

    return mainUrl;
  }



  Future<Dio> _createDio() async {
    final token = await getToken(); // Fetch token from SharedPreferences

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: TIME_OUT),
        receiveTimeout: const Duration(milliseconds: TIME_OUT),
        contentType: Headers.jsonContentType,
        headers: _buildHeaders(token),
        validateStatus: (status) {
          // Allow status codes 200–299 and 302
          return (status! < 300 || status == 302);
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request details
        print('Request: ${options.method} ${options.uri}');
        print('Request Headers: ${options.headers}');
        print('Request Params: ${options.queryParameters}');
        if (options.data != null) {
          print('Request Body: ${_prettyPrintJson(options.data)}');
        }
        return handler.next(options); // Continue
      },
      onResponse: (response, handler) {
        // Log response details
        print('Response: ${response.statusCode} ${response.requestOptions.uri}');
        print('Response Headers: ${response.headers}');
        print('Response Body: ${_prettyPrintJson(response.data)}');
        return handler.next(response); // Continue
      },
      onError: (DioError e, handler) {
        // Log error details
        print('Error: ${e.message}');
        if (e.response != null) {
          print('Error Response: ${e.response!.statusCode} ${e.response!.requestOptions.uri}');
          print('Error Response Headers: ${e.response!.headers}');
          print('Error Response Body: ${_prettyPrintJson(e.response!.data)}');
        }
        return handler.next(e); // Continue
      },
    ));

    return dio;
  }

  Future<Response> request(
      String endpoint,
      DioMethod method, {
        Map<String, dynamic>? param,
        String? contentType = 'application/json',
        dynamic formData,
      }) async {
    try {
      final dio = await _createDio();

      // Determine the content type for the request
      if (contentType == Headers.formUrlEncodedContentType) {
        // Encode the parameters as form data
        final formData = FormData.fromMap(param ?? {});
        switch (method) {
          case DioMethod.post:
            return dio.post(
              endpoint,
              data: formData,
              options: Options(contentType: contentType),
            );
          case DioMethod.put:
            return dio.put(
              endpoint,
              data: formData,
              options: Options(contentType: contentType),
            );
          default:
            throw Exception('Unsupported method for form data');
        }
      } else {
        switch (method) {
          case DioMethod.post:
            return dio.post(
              endpoint,
              data: param ?? formData,
            );
          case DioMethod.get:
            return dio.get(
              endpoint,
              queryParameters: param,
            );
          case DioMethod.put:
            return dio.put(
              endpoint,
              data: param ?? formData,
            );
          case DioMethod.delete:
            return dio.delete(
              endpoint,
              data: param ?? formData,
            );
          default:
            return dio.post(
              endpoint,
              data: param ?? formData,
            );
        }
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Helper method to build headers
  Map<String, dynamic> _buildHeaders(String? token) {
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: Headers.jsonContentType,
    };

    if (token != null && token.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    return headers;
  }

  // Helper method to pretty print JSON
  String _prettyPrintJson(dynamic json) {
    try {
      if (json is String) {
        return json;
      }
      return JsonEncoder.withIndent('  ').convert(json);
    } catch (e) {
      return json.toString();
    }
  }
}
