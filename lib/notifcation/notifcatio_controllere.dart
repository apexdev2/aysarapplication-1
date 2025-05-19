import 'package:aysar_app/api/repo/shareed_repo.dart';

import 'package:aysar_app/models/notifcation_model.dart';
import 'package:aysar_app/models/unRead_notifcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifcatioGEtxControllere extends GetxController {
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getNotifcationAll();
    // getUnReadNotifcation();

    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // Trigger load more when reaching the bottom of the list
          if (!isLoading.value && hasNextPage) {
            loadMoreNotifcation();
          }
        }
      },
    );
  }

  final ScrollController scrollController = ScrollController();
  int currentPage = 1; // Track current page
  bool hasNextPage = true; // Track if there's more data to load
  RxList<NotifcationData> notificationList = <NotifcationData>[].obs;

  int _count = 0;
  int get count => _count;

  getNotifcationAll({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore && !hasNextPage)
      return; // No need to load more if there are no more pages
    if (!isLoadMore) {
      // Reset page and list if not loading more
      currentPage = 1;
      notificationList.clear();
    }
    updatePage(value: true, isLoading: isLoading);

    var responce = await ShareedRepo().getNotification(page: currentPage);
    // Check if we have more pages
    // hasNextPage = await responce.pagination!.hasNextPage!;
    // Append new data to the existing list
    notificationList.addAll(responce.dataList!);

    updatePage(value: false, isLoading: isLoading);

    update();
  }

// Method to load more data
  Future<void> loadMoreNotifcation() async {
    if (hasNextPage) {
      currentPage++;
      getNotifcationAll(isLoadMore: true);
    }
  }

  UnReadNotifcation? unReadNotifcation;
  getUnReadNotifcation() async {
    updatePage(value: true, isLoading: isLoading);

    var res = await ShareedRepo().getUnReadNotifcation();
    if (res.success) {
      _count = unReadNotifcation?.count ?? 0;
    }
    updatePage(value: false, isLoading: isLoading);

    update();
  }

  markAsReadNotifcation() async {
    await ShareedRepo().markAsReadNotifcation();
    getUnReadNotifcation();
    update();
  }

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        isLoading.value = value;
      },
    );
  }
}
