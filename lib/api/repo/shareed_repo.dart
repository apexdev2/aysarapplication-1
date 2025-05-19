import 'package:aysar_app/api/api_paths.dart';
import 'package:aysar_app/api/api_service.dart';
import 'package:aysar_app/api/network/remote/api_response_handler.dart';
import 'package:aysar_app/models/base_api_responce.dart';
import 'package:aysar_app/models/id_name_model.dart';
import 'package:aysar_app/models/notifcation_model.dart';
import 'package:aysar_app/models/page_details_model.dart';
import 'package:aysar_app/models/pages_model.dart';
import 'package:aysar_app/models/slider_model.dart';
import 'package:aysar_app/models/unRead_notifcation.dart';

class ShareedRepo {
  Future<ApiResponseHandler<SliderModel>> getSliderImages() async {
    return await ApiService.sendRequest<SliderModel>(
      url: ApiEndPoints.sliders,
      fromJson: (json) => SliderModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<PagesModel>> getPages() async {
    return await ApiService.sendRequest<PagesModel>(
      url: ApiEndPoints.pages,
      fromJson: (json) => PagesModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<PageDetailsModel>> showPage(
      {required String type}) async {
    return await ApiService.sendRequest<PageDetailsModel>(
      url: "${ApiEndPoints.pages}/$type",
      fromJson: (json) => PageDetailsModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<PageDetailsModel>> getFAQ() async {
    return await ApiService.sendRequest<PageDetailsModel>(
      url: ApiEndPoints.faqs,
      fromJson: (json) => PageDetailsModel.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<NotifcationData>> getNotification(
      {int page = 1}) async {
    return await ApiService.sendRequest<NotifcationData>(
      url: ApiEndPoints.notifications,
      fromJson: (json) => NotifcationData.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<UnReadNotifcation>> getUnReadNotifcation() async {
    return await ApiService.sendRequest<UnReadNotifcation>(
      url: "${ApiEndPoints.notifications}/unRead",
      fromJson: (json) => UnReadNotifcation.fromJson(json),
      method: RequestMethod.get,
    );
  }

  Future<ApiResponseHandler<BaseApiResponce>> markAsReadNotifcation() async {
    return await ApiService.sendRequest<BaseApiResponce>(
      url: "${ApiEndPoints.notifications}/markAsRead",
      fromJson: (json) => BaseApiResponce.fromJson(json),
      method: RequestMethod.get,
    );
  }
    Future<ApiResponseHandler<IdNameModel>> getIssues(
      {int page = 1}) async {
    return await ApiService.sendRequest<IdNameModel>(
      url: ApiEndPoints.issues,
      fromJson: (json) => IdNameModel.fromJson(json),
      method: RequestMethod.get,
    );
  }
}
