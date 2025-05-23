import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/api_service.dart';
import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/models/properties_details_model.dart';
import 'package:aysar_app/models/properties_model.dart';
import 'package:aysar_app/models/properties_stages_model.dart';

class PropertiesRepo {
  Future<ApiResponseHandler<PropertiesModel>> getProperties({int ?page = 1}) async {
    return await ApiService.sendRequest<PropertiesModel>(
      url: ApiEndPoints.properties,
      fromJson: (json) => PropertiesModel.fromJson(json),
      method: RequestMethod.get,
      query: {"page": page},
    );
  }

  Future<ApiResponseHandler<PropertiesDetailsModel>> getPropertiesDetails(
      {required int id}) async {
    return await ApiService.sendRequest<PropertiesDetailsModel>(
      url: "${ApiEndPoints.properties}/$id",
      fromJson: (json) => PropertiesDetailsModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<PropertiesStagesModel>> getPropertyStages(
      {required int id, int? page = 1}) async {
    return await ApiService.sendRequest<PropertiesStagesModel>(
        url: "${ApiEndPoints.properties}/$id/stages",
        fromJson: (json) => PropertiesStagesModel.fromJson(json),
        method: RequestMethod.get,
        query: {"page": page});
  }
}
