import 'dart:io';

import 'package:aysar_app/api/repo/maintenance_request_repo.dart';
import 'package:aysar_app/helpers/data_checker.dart';
import 'package:aysar_app/models/base_api_responce.dart';
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
    attachment = null;
    super.onClose();
  }

  late TextEditingController noteController;
  // late TextEditingController titleController;

  File? attachment;

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

  BaseApiResponce? storeTicketResponce;
  storteMaintenanceRequest(
      // ignore: non_constant_identifier_names
      {
    required String? issue_description,
    required int? issue_id,
    required int? property_id,
  }) async {
    updatePage(value: true, isLoading: isLoading);
    dio.MultipartFile? attachmentToSend;
    if (attachment != null) {
      attachmentToSend = await dio.MultipartFile.fromFile(
        attachment!.path,
      );
    } else {
      attachmentToSend = null;
    }

    dio.FormData formData = dio.FormData.fromMap(
      {
        "property_id": property_id,
        'attachments': attachmentToSend,
        'issue_description': noteController.text,
        'issue_id': issue_id,
      },
    );

    var body = {
          "property_id": property_id,
          'issue_description': noteController.text,
          'issue_id': issue_id,
        },
        storeTicketResponce = await MaintenanceRequestRepo()
            .storteMaintenanceRequest(
                body: attachmentToSend == null ? body : formData);
    if (storeTicketResponce.success != false) {
      getMaintenanceRequest();
      Utils.getSnakBar(
          type: TosterTypes.sucsses, message: storeTicketResponce.message);
    } else {
      Utils.getSnakBar(
          type: TosterTypes.failed, message: storeTicketResponce.message);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  updateAttachments({required File selectedFile}) {
    attachment = selectedFile;
    update();
  }

  bool get checkData => checkText(
        text: noteController.text,
        errorMessage: appLocale.enterYourNotesEx,
      );
}
