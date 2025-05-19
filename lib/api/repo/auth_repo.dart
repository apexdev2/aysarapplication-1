import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/api_service.dart';
import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/models/base_api_responce.dart';
import 'package:aysar_app/models/user_model.dart';

class AuthRepo {
  Future<ApiResponseHandler<BaseApiResponce>> loginUser(
      {required Map<String, dynamic> loginData}) async {
    return await ApiService.sendRequest<BaseApiResponce>(
      url: ApiEndPoints.login,
      fromJson: (json) => BaseApiResponce.fromJson(json),
      body: loginData,
      method: RequestMethod.post,
    );
  }

  Future<ApiResponseHandler<AuthModel>> verifyloginUser(
      {required Map<String, dynamic> body}) async {
    return await ApiService.sendRequest<AuthModel>(
      url: ApiEndPoints.verifyOtp,
      fromJson: (json) => AuthModel.fromJson(json),
      body: body,
      method: RequestMethod.post,
    );
  }

  Future<ApiResponseHandler<BaseApiResponce>> logoutUser() async {
    return await ApiService.sendRequest<BaseApiResponce>(
      url: ApiEndPoints.logout,
      fromJson: (json) => BaseApiResponce.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<User>> getPtofile() async {
    return await ApiService.sendRequest<User>(
      url: ApiEndPoints.myProfile,
      fromJson: (json) => User.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<BaseApiResponce>> updateProfile(
      {required dynamic body}) async {
    return await ApiService.sendRequest<BaseApiResponce>(
      url: ApiEndPoints.profile,
      fromJson: (json) => BaseApiResponce.fromJson(json),
      method: RequestMethod.post,
      body: body,
    );
  }
}
