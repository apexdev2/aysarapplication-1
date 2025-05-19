// import 'package:aysar_app/api/repo/Properties_repo.dart';
// import 'package:aysar_app/models/Properties_model.dart';

// import 'dart:developer';

import 'package:aysar_app/api/repo/properties_repo.dart';
import 'package:aysar_app/models/pagination_model.dart';
import 'package:aysar_app/models/properties_details_model.dart';
import 'package:aysar_app/models/properties_model.dart';
import 'package:aysar_app/models/properties_stages_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PropertiesGetxcontroller extends GetxController {
  @override
  onInit() {
    getProperties();
    super.onInit();
  }

  var pagination = Pagination().obs;
  RxInt currentPage = 1.obs;

  RxBool isLoadingMore = false.obs;
  RxBool isLoading = false.obs;
  RxBool loadingDetails = false.obs;
  RxBool loadingstages = false.obs;

  var propertiesdetails = PropertiesDetailsModel().obs;

  var properties = <PropertiesModel>[].obs;
  var propertystages = <PropertiesStagesModel>[].obs;

  getProperties() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await PropertiesRepo().getProperties();

    if (responce.success && responce.dataList != null) {
      properties.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  getpropertiesDetails({required int id}) async {
    updatePage(value: true, isLoading: loadingDetails);

    var responce = await PropertiesRepo().getPropertiesDetails(id: id);

    if (responce.success && responce.data != null) {
      propertiesdetails.value = responce.data!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: loadingDetails);
  }

getPropertyStages({
  required int id,
  bool isLoadMore = false,
}) async {
  if (isLoadMore) {
    if (!pagination.value.hasNext! || isLoadingMore.value) return;
    isLoadingMore.value = true;
  } else {
    currentPage.value = 1;
    propertystages.clear();
    isLoading.value = true;
  }

  updatePage(value: true, isLoading: loadingstages);

  var responce = await PropertiesRepo().getPropertyStages(
    id: id,
    page: currentPage.value,
  );

  if (responce.success && responce.dataList != null) {
    propertystages.addAll(responce.dataList!);
    pagination.value = responce.pagination!;
    currentPage.value++; // ✅ تأكد من استخدام .value
  }

  if (isLoadMore) {
    isLoadingMore.value = false;
  } else {
    isLoading.value = false;
  }

  updatePage(value: false, isLoading: loadingstages);
}

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = value;
      update();
    });
  }
}
