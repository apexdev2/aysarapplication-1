import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/api_service.dart';
import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/models/company_model.dart';

class CompanyRepo {
  Future<ApiResponseHandler<CompanyModel>> getCompanies() async {
    return await ApiService.sendRequest<CompanyModel>(
      url: ApiEndPoints.companies,
      fromJson: (json) => CompanyModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<CompanyModel>> getCompaniesDetails(
      {required int id}) async {
    return await ApiService.sendRequest<CompanyModel>(
      url: "${ApiEndPoints.companies}/$id",
      fromJson: (json) => CompanyModel.fromJson(json),
      method: RequestMethod.get,
    );
  }
}
