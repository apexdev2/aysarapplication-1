import 'package:aysar_app/api/repo/company_repo.dart';
import 'package:aysar_app/models/company_model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CompanyGetxcontroller extends GetxController {
  @override
  onInit() {
    getCompanies();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  RxBool loadingDetails = false.obs;
  var caompanydetails = CompanyModel().obs;

  RxList<CompanyModel> companies = <CompanyModel>[].obs;

  getCompanies() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await CompanyRepo().getCompanies();

    if (responce.success && responce.dataList != null) {
      companies.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  getCompaniesDetails({required int id}) async {
    updatePage(value: true, isLoading: loadingDetails);

    var responce = await CompanyRepo().getCompaniesDetails(id: id);

    if (responce.success && responce.data != null) {
      caompanydetails.value = responce.data!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: loadingDetails);
  }

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = value;
      update();
    });
  }
}
