import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/notifcation/notifcatio_controllere.dart';
import 'package:aysar_app/utils/warnings/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotifcationScreen extends StatelessWidget {
  NotifcationScreen({super.key});
  final NotifcatioGEtxControllere controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.isLoading.value
                ? RefreshIndicator.adaptive(
                    onRefresh: () async {
                      controller.getNotifcationAll();
                    },
                    child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (index == controller.notificationList.length) {
                            // Show loader at the bottom while loading more data
                            return controller.hasNextPage
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(),
                                  )
                                : const SizedBox.shrink();
                          }
                          final notificationItem =
                              controller.notificationList[index];
                          return ListTile(
                            title: Text(
                              notificationItem.title ?? "",
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
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                  color: const Color(0xffD8D8D8)),
                            ),
                            titleAlignment: ListTileTitleAlignment.top,
                            trailing: Text(
                              notificationItem.createdAt ?? "",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xffD8D8D8)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15.h,
                            ),
                        itemCount: controller.notificationList.length),
                  )
                : controller.isLoading.value
                    ? empty
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
