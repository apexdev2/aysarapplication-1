import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/notifcation/notifcatio_controllere.dart';
import 'package:aysar_app/notifcation/notifcation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppNotificationIcon extends StatelessWidget with ImageHelper {
  const AppNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotifcatioGEtxControllere>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.getNotifcationAll();
          controller.markAsReadNotifcation();

          Get.to(
            () => NotifcationScreen(),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 35.h,
              width: 35.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: appSvgImage(
                AssetsHelper.notifcationIcon,
                // width: 13.w,
              ),
            ),
            CircleAvatar(
              radius: 8.r,
              backgroundColor: const Color(0xffFF6359),
              child: Center(
                child: Text(
                  "0",
                  // controller.count.toString(),
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
