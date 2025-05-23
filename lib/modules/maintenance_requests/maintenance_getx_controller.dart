import 'dart:io';

import 'package:aysar_app/api/repo/maintenance_request_repo.dart';
import 'package:aysar_app/helpers/data_checker.dart';
import 'package:aysar_app/models/id_name_model.dart';
import 'package:aysar_app/models/maintenance_request_model.dart';
import 'package:aysar_app/models/pagination_model.dart';
import 'package:aysar_app/models/properties_model.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:aysar_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart' as dio;

class MaintenanceGetxController extends GetxController with DataCheckerHelper {
  AppLocalizations appLocale = AppLocalizations.of(Get.context!)!;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    noteController = TextEditingController();
    // titleController = TextEditingController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Trigger load more when reaching the bottom of the list

        if (!isLoading.value && hasNextPage) {
          loadMoreTickets();
        }
      }
    });
    getMaintenanceRequest();
    super.onInit();
  }

  @override
  void onClose() {
    noteController.dispose();
    // titleController.dispose();
    attachments = null;
    super.onClose();
  }

  late TextEditingController noteController;
  // late TextEditingController titleController;
  PropertiesModel? selectedRealstate;

  IdNameModel? selectedProblem;
  List<File>? attachments;
  RxBool isLoadingMore = false.obs;

  final ScrollController scrollController = ScrollController();
  var pagination = Pagination().obs;

  bool looadingMessage = false;
  RxInt currentPage = 1.obs;

  bool hasNextPage = true; // Track if there's more data to load
  RxList<MaintenanceRequestModel> requestsList =
      <MaintenanceRequestModel>[].obs;

  getMaintenanceRequest({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (!pagination.value.hasNext! || isLoadingMore.value) return;
      isLoadingMore.value = true;
    } else {
      currentPage.value = 1;
      requestsList.clear();
      isLoading.value = true;
    }
    updatePage(value: true, isLoading: isLoading);

    var responce = await MaintenanceRequestRepo().getMaintenanceRequest(
   page: currentPage.value,
    );

     if (responce.success && responce.dataList != null) {
      requestsList.addAll(responce.dataList!);
      // pagination.value = responce.pagination!;
      currentPage.value++; // ✅ تأكد من استخدام .value
    }
  if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }

    updatePage(value: false, isLoading: isLoading);
  }

  // Method to load more data
  Future<void> loadMoreTickets() async {
    if (hasNextPage) {
      currentPage++;
      getMaintenanceRequest(isLoadMore: true);
    }
  }

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = value;
    });
  }

  Future<bool> storeMaintenanceRequest() async {
    updatePage(value: true, isLoading: isLoading);

    dio.FormData? formData;

    // إعداد المرفقات المتعددة بالشكل المطلوب attachments[0], attachments[1], ...
    if (attachments != null && attachments!.isNotEmpty) {
      final Map<String, dynamic> formMap = {
        "property_id": selectedRealstate?.id ?? 1,
        "issue_description": noteController.text,
        "issue_id": selectedProblem?.id ?? 1,
      };

      for (int i = 0; i < attachments!.length; i++) {
        final file = attachments![i];
        formMap['attachments[$i]'] =
            await dio.MultipartFile.fromFile(file.path);
      }

      formData = dio.FormData.fromMap(formMap);
    }

    // body عادي في حال لا يوجد مرفقات
    final body = {
      "property_id": selectedRealstate?.id ?? 1,
      "issue_description": noteController.text,
      "issue_id": selectedProblem?.id ?? 1,
    };

    final storeTicketResponse = await MaintenanceRequestRepo()
        .storteMaintenanceRequest(body: formData ?? body);

    if (storeTicketResponse.success != false) {
      getMaintenanceRequest();
      Utils.getSnakBar(
        type: TosterTypes.sucsses,
        message: storeTicketResponse.message,
      );
    } else {
      Utils.getSnakBar(
        type: TosterTypes.failed,
        message: storeTicketResponse.message,
      );
    }

    updatePage(value: false, isLoading: isLoading);
    return storeTicketResponse.success;
  }

  updateAttachments({required List<File> selectedFiles}) {
    attachments = selectedFiles;
    update();
  }

  updateSelectedProblem({required IdNameModel problem}) {
    selectedProblem = problem;
    update();
  }

  updateSelectedRealstate({required PropertiesModel my_real_estate}) {
    selectedRealstate = my_real_estate;
    update();
  }

  bool get checkData =>
      checkObject(
        object: selectedRealstate,
        message: "قم باختيار العقار",
      ) &&
      checkObject(
        object: selectedProblem,
        message: "قم باختيار قسم المشكلة",
      ) &&
      checkObject(
        object: attachments,
        message: "قم بتحميل المرفقات",
      ) &&
      checkText(
        text: noteController.text,
        errorMessage: appLocale.enterYourNotesEx,
      );
}
