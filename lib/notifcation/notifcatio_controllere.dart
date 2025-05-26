import 'package:aysar_app/api/repo/shareed_repo.dart';

import 'package:aysar_app/models/notifcation_model.dart';
import 'package:aysar_app/models/pagination_model.dart';
import 'package:aysar_app/models/unRead_notifcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifcatioGEtxControllere extends GetxController {
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotifcationAll();

  }


  var notificationList = <NotifcationData>[].obs;
  var pagination = Pagination().obs;

  int _count = 0;
  int get count => _count;

  getNotifcationAll({
    bool isLoadMore = false,
  }) async {
        if (isLoadMore) {
      if (!pagination.value.hasNext! || isLoadingMore.value) return;
      isLoadingMore.value = true;
    } else {
      currentPage.value = 1;
      notificationList.clear();
      isLoading.value = true;
    }
    updatePage(value: true, isLoading: isLoading);



    var responce = await ShareedRepo().getNotification(page: currentPage.value);
    if (responce.success && responce.dataList != null) {
      notificationList.addAll(responce.dataList!);
      pagination.value = responce.pagination!;
      currentPage.value++; // ✅ تأكد من استخدام .value
    }

    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }

    updatePage(value: false, isLoading: isLoading);

    update();
  }

// Method to load more data
  // Future<void> loadMoreNotifcation() async {
  //   if (hasNextPage) {
  //     currentPage++;
  //     getNotifcationAll(isLoadMore: true);
  //   }
  // }

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
