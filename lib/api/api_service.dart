import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/api/network/remote/dio_helper.dart';
import 'package:aysar_app/models/pagination_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  static Future<ApiResponseHandler<T>> sendRequest<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    dynamic query,
    RequestMethod method = RequestMethod.get, // Default is GET
  }) async {
    try {
      Response response;
      switch (method) {
        case RequestMethod.get:
          response = await DioHelper.getData(url: url, query: query);
          break;
        case RequestMethod.post:
          response = await DioHelper.postData(url: url, data: body);
          break;
        case RequestMethod.put:
          response = await DioHelper.putData(
            url: url,
            data: body,
          );
          break;
        case RequestMethod.delete:
          response = await DioHelper.deleteData(url: url, query: query);
          break;
      }
      bool success = response.data['status'] ?? true;
      String message = response.data['message'] ?? "Request successful";

      if (response.statusCode == 200 && success) {
        Pagination? pagination;
        if (response.data.containsKey('pagination') &&
            response.data['pagination'] != null) {
          pagination = Pagination.fromJson(response.data['pagination']);
        }
        if (response.data.containsKey('data')) {
          var responseData = response.data['data'];

          if (responseData == null) {
            return ApiResponseHandler.successWithoutData(message);
          } else if (responseData is List) {
            List<T> parsedList = responseData
                .map((item) => fromJson(item as Map<String, dynamic>))
                .toList();
            return ApiResponseHandler.successList(parsedList, message,
                pagination: pagination);
          } else if (responseData is Map<String, dynamic>) {
            T parsedData = fromJson(responseData);
            return ApiResponseHandler.successSingle(parsedData, message,
                pagination: pagination);
          } else if (responseData is String) {
            return ApiResponseHandler.successString(responseData, message);
          }
        }
        return ApiResponseHandler.successWithoutData(message);
      } else {
        return ApiResponseHandler.failure(
            _handleStatusCode(response.statusCode), message);
      }
    } on DioException catch (e) {
      return ApiResponseHandler.failure(_handleDioError(e), "Network error.");
    }
  }

  /// Handles different status codes
  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad Request: The server could not understand the request.";
      case 401:
        return "Unauthorized: Please log in again.";
      case 403:
        return "Forbidden: You don't have permission to access this resource.";
      case 404:
        return "Not Found: The requested resource was not found.";
      case 405:
        return "Method Not Allowed: The request method is not allowed.";
      case 500:
        return "Internal Server Error: Something went wrong on the server.";
      default:
        return "Unexpected error occurred. Please try again.";
    }
  }

  /// Handles Dio errors
  static String _handleDioError(DioException e) {
    if (e.response != null && e.response!.data != null) {
      try {
        return e.response!.data['message'] ?? "Unknown error occurred";
      } catch (_) {
        return _handleStatusCode(e.response!.statusCode);
      }
    } else {
      return "No internet connection or server unreachable.";
    }
  }

///////////////////////////////////
  static Future<ApiResponseHandler<T>> sendRawRequest<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    dynamic query,
    RequestMethod method = RequestMethod.get,
  }) async {
    try {
      Response response;

      switch (method) {
        case RequestMethod.get:
          response = await DioHelper.getData(url: url, query: query);
          break;
        case RequestMethod.post:
          response = await DioHelper.postData(url: url, data: body);
          break;
        case RequestMethod.put:
          response = await DioHelper.putData(url: url, data: body);
          break;
        case RequestMethod.delete:
          response = await DioHelper.deleteData(url: url, query: query);
          break;
      }

      if (response.statusCode == 200 && response.data != null) {
        T parsedModel = fromJson(response.data as Map<String, dynamic>);
        return ApiResponseHandler.successSingle(parsedModel, "Success");
      } else {
        return ApiResponseHandler.failure(
          _handleStatusCode(response.statusCode),
          "Unexpected API structure",
        );
      }
    } on DioException catch (e) {
      return ApiResponseHandler.failure(_handleDioError(e), "Network error.");
    }
  }
}

/// Enum to represent HTTP request methods
enum RequestMethod { get, post, put, delete }
