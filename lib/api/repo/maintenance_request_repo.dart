import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/api_service.dart';
import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/models/base_api_responce.dart';

import 'package:aysar_app/models/maintenance_request_model.dart';

class MaintenanceRequestRepo {
  Future<ApiResponseHandler<MaintenanceRequestModel>>
      getMaintenanceRequest({int? page = 1}) async {
    return await ApiService.sendRequest<MaintenanceRequestModel>(
      url: ApiEndPoints.maintenance,
      fromJson: (json) => MaintenanceRequestModel.fromJson(json),
      method: RequestMethod.get,
      query: {"page": page},
    );
  }
    Future<ApiResponseHandler<BaseApiResponce>>
      storteMaintenanceRequest({required dynamic body}) async {
    return await ApiService.sendRequest<BaseApiResponce>(
      url: ApiEndPoints.maintenance,
      fromJson: (json) => BaseApiResponce.fromJson(json),
      body: body,
      method: RequestMethod.post,
    );
  }
}
