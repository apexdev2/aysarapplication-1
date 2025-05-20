import 'dart:io';

import 'package:aysar_app/api/repo/maintenance_request_repo.dart';
import 'package:aysar_app/helpers/data_checker.dart';
import 'package:aysar_app/models/maintenance_request_model.dart';
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

  List<File>? attachments;

  final ScrollController scrollController = ScrollController();

  bool looadingMessage = false;
  int currentPage = 1; // Track current page
  bool hasNextPage = true; // Track if there's more data to load
  RxList<MaintenanceRequestModel> requestsList =
      <MaintenanceRequestModel>[].obs;

  getMaintenanceRequest({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore && !hasNextPage)
      return; // No need to load more if there are no more pages
    if (!isLoadMore) {
      // Reset page and list if not loading more
      currentPage = 1;
      requestsList.clear();
    }
    updatePage(value: true, isLoading: isLoading);

    var res = await MaintenanceRequestRepo().getMaintenanceRequest();

    // Check if we have more pages
    // hasNextPage = res.pagination!.hasNextPage!;

    // Append new data to the existing list
    if (res.dataList?.isNotEmpty ?? false) {
      requestsList.addAll(res.dataList!);
      print('Loaded items: ${requestsList.length}');
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

Future<void> storeMaintenanceRequest({
  required String? issue_description,
  required int? issue_id,
  required int? property_id,
}) async {
  updatePage(value: true, isLoading: isLoading);

  dio.FormData? formData;

  // إعداد المرفقات المتعددة بالشكل المطلوب attachments[0], attachments[1], ...
  if (attachments != null && attachments!.isNotEmpty) {
    final Map<String, dynamic> formMap = {
      "property_id": property_id,
      "issue_description": issue_description ?? noteController.text,
      "issue_id": issue_id,
    };

    for (int i = 0; i < attachments!.length; i++) {
      final file = attachments![i];
      formMap['attachments[$i]'] = await dio.MultipartFile.fromFile(file.path);
    }

    formData = dio.FormData.fromMap(formMap);
  }

  // body عادي في حال لا يوجد مرفقات
  final body = {
    "property_id": property_id,
    "issue_description": issue_description ?? noteController.text,
    "issue_id": issue_id,
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
}

  updateAttachments({required List<File>  selectedFiles}) {
    attachments = selectedFiles;
    update();
  }

  bool get checkData => checkText(
        text: noteController.text,
        errorMessage: appLocale.enterYourNotesEx,
      );
}
