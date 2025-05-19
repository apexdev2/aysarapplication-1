import 'package:aysar_app/api/repo/shareed_repo.dart';
import 'package:aysar_app/models/id_name_model.dart';
import 'package:aysar_app/models/page_details_model.dart';
import 'package:aysar_app/models/pages_model.dart';
import 'package:aysar_app/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareedGetxcontroller extends GetxController {
  @override
  onInit() {
    super.onInit();
    getSliderImages();
    getIssues();
    getPages();
  }

  RxList<SliderModel> sliderImages = <SliderModel>[].obs;
  RxList<PagesModel> pages = <PagesModel>[].obs;
  RxList<IdNameModel> issuesList = <IdNameModel>[].obs;

  RxList<PageDetailsModel> faqs = <PageDetailsModel>[].obs;

  var pageDetails = PageDetailsModel().obs;


  getSliderImages() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().getSliderImages();

    if (responce.success && responce.dataList != null) {
      sliderImages.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  getPages() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().getPages();

    if (responce.success && responce.dataList != null) {
      pages.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  showPage({required String type}) async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().showPage(type: type);

    if (responce.success && responce.data != null) {
      pageDetails.value = responce.data!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  getFAQ() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().getFAQ();

    if (responce.success && responce.dataList != null) {
      faqs.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  getIssues() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().getIssues();

    if (responce.success && responce.dataList != null) {
      issuesList.value = responce.dataList!;
      // Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
    } else {
      // Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  RxBool isLoading = false.obs;

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        isLoading.value = value;
      },
    );
  }
}
