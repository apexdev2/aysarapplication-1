import 'dart:developer';
import 'dart:ui';
import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/network/local/cashe_helper.dart';
import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/cache/cache_controller.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late String initialLocale;
  static final Dio dio = Dio(); // Singleton Dio instance

  /// Initializes Dio with base configurations
  static Future<void> init() async {
    initialLocale = await _getDeviceLanguageCode();
    _initializeDio();
  }

  /// Configures Dio with base options and interceptors
  static void _initializeDio() async {
    String token =
        await CacheHelper.getSecureData(key: CacheKeys.userToken.name) ?? "";
    dio.options = BaseOptions(
      baseUrl: ApiEndPoints.apiFullUrl,
      //RemoteConfigService.getBaseUrl(),// Get URL from Firebase
      followRedirects: false,
      receiveDataWhenStatusError: true,
      validateStatus: (status) => status! < 500, // Accept responses <500
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language':
            CacheHelper.getData(key: CacheKeys.language.name) ?? "ar",
        // ignore: unnecessary_null_comparison
        'Authorization': token != null || token != "" ? "Bearer $token" : "",
        'X-Client-FCM-Token':
            CacheController().getter(key: CacheKeys.fcmToken)?.toString() ?? '',
      },
    );

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await _updateHeaders(); // Ensure headers are updated before every request
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            log("Unauthorized! Redirecting to login...");
            _handleUnauthorized();
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            log("Unauthorized Error! Redirecting to login...");
            _handleUnauthorized();
          }
          return handler.next(e);
        },
      ),
    );

    // Enable logging in debug mode
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  /// Updates headers dynamically before every request
  static Future<void> _updateHeaders() async {
    String? token =
        await CacheHelper.getSecureData(key: CacheKeys.userToken.name);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language':
          CacheHelper.getData(key: CacheKeys.language.name) ?? "ar",
      'Authorization': token != null ? "Bearer $token" : "",
      'X-Client-FCM-Token':
          CacheController().getter(key: CacheKeys.fcmToken)?.toString() ?? '',
    };
    log("Updated Headers: ${dio.options.headers}");
  }

  /// Manually updates headers (e.g., when language changes)
  static void updateHeadersManually() async {
    await _updateHeaders();
    log("Headers manually updated.");
  }

  /// Handles unauthorized responses (401)
  static void _handleUnauthorized() {
    CacheHelper.clearCache(key: CacheKeys.userToken.name);
    getx.Get.offAllNamed(Routes.loginRoute);
    log("Redirecting to login page...");
  }

  /// Retrieves the device's default language
  static Future<String> _getDeviceLanguageCode() async {
    final platformDispatcher = PlatformDispatcher.instance;
    return platformDispatcher.locale.languageCode;
  }

  // ====================== API REQUEST METHODS ======================

  /// Sends a GET request
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      await _updateHeaders(); // Ensure headers are up to date
      final response = await dio.get(
        url,
        queryParameters: query,
      );
      // log("GET Request [$url] - Response: ${response.data}");
      return response;
    } catch (e) {
      log("GET Error [$url]: $e");
      rethrow;
    }
  }

  /// Sends a POST request
  static Future<Response> postData({
    required String url,
    dynamic data,
    bool withFiles = false,
  }) async {
    try {
      await _updateHeaders(); // Ensure headers are up to date
      dio.options.headers['Content-Type'] =
          withFiles ? "multipart/form-data" : "application/json";

      final response = await dio.post(url, data: data);
      // log("POST Request [$url] - Response: ${response.data}");
      return response;
    } catch (e) {
      log("POST Error [$url]: $e");
      rethrow;
    }
  }

  /// Sends a PUT request
  static Future<Response> putData({
    required String url,
    dynamic data,
  }) async {
    try {
      await _updateHeaders(); // Ensure headers are up to date
      final response = await dio.put(url, data: data);
      // log("PUT Request [$url] - Response: ${response.data}");
      return response;
    } catch (e) {
      log("PUT Error [$url]: $e");
      rethrow;
    }
  }

  /// Sends a DELETE request
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      await _updateHeaders(); // Ensure headers are up to date
      final response = await dio.delete(url, queryParameters: query);
      // log("DELETE Request [$url] - Response: ${response.data}");
      return response;
    } catch (e) {
      log("DELETE Error [$url]: $e");
      rethrow;
    }
  }
}
