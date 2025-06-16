import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/notifcation/notifcatio_controllere.dart';
import 'package:aysar_app/utils/warnings/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotifcationScreen extends StatelessWidget {
  NotifcationScreen({super.key});
  final NotifcatioGEtxControllere controller = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !controller.isLoadingMore.value &&
            controller.pagination.value.hasNext!) {
          controller.getNotifcationAll(
            isLoadMore: true,
          );
        }
      });
    }
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.theNotifications,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.notificationList.isNotEmpty
                    ? RefreshIndicator.adaptive(
                        onRefresh: () async {
                          controller.getNotifcationAll();
                        },
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: scrollController,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final notificationItem =
                                  controller.notificationList[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      notificationItem.title ?? "",
                                    ),
                                    const Spacer(),
                                    Text(
                                      notificationItem.createdAt ?? "",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color(0xffD8D8D8)),
                                    ),
                                  ],
                                ),
                                titleTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    color: Colors.black),
                                leading: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: const Color(0xffF0F0F0),
                                  child: SvgPicture.asset(
                                    AssetsHelper.notificationsettings,
                                  ),
                                ),
                                minLeadingWidth: 40.w,
                                subtitle: Text(
                                  notificationItem.content ?? "",
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                      color: const Color(0xffD8D8D8)),
                                ),
                                titleAlignment: ListTileTitleAlignment.top,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15.h,
                                ),
                            itemCount: controller.notificationList.length),
                      )
                    : const NoData(),
            Visibility(
              visible: controller.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
