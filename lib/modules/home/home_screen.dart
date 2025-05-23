import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/bnb/bnb_controller.dart';
import 'package:aysar_app/modules/home/home_image_slider.dart';
import 'package:aysar_app/modules/my_account/profile/profile_getxcontroller.dart';
import 'package:aysar_app/modules/my_real_estate/properties_getxcontroller.dart';
import 'package:aysar_app/notifcation/app_notification_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ImageHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  PropertiesGetxcontroller propertiescontroller = Get.find();
  ProfileGetxcontroller profilecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 175.h,
              child: const HomeImageSlider(),
            ),
            34.height,
            // Blue Card - Real Estate Development Companies
            // GestureDetector(
            //   onTap: () => Get.toNamed(Routes.companiesScreen),
            //   child: Container(
            //     width: double.infinity,
            //     height: 135.h,
            //     padding: EdgeInsetsDirectional.only(
            //       start: 15.w,
            //       end: 5.w,
            //       top: 10.h,
            //       bottom: 10.h,
            //     ),
            //     margin: EdgeInsets.all(16.w),
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           const Color(0xff44C2CA),
            //           const Color(0xff037FFF).withOpacity(0.74),
            //         ],
            //       ),
            //       borderRadius: BorderRadius.circular(15.r),
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "اطلع على شركات\n التطوير العقاري",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 19.sp,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               10.height,
            //               Container(
            //                 padding: EdgeInsets.symmetric(
            //                   horizontal: 15.w,
            //                   vertical: 5.h,
            //                 ),
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(20.r),
            //                 ),
            //                 child: Text(
            //                   'مشاهدة',
            //                   style: TextStyle(
            //                     fontSize: 15.sp,
            //                     color: const Color(0xFF00A7E1),
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           width: 144.w,
            //           child: Image.asset(AssetsHelper.homecard1),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Green Card - Property Count
            GestureDetector(
              onTap: () =>
                  Get.find<BnbController>().changeCurrentIndex(index: 2),
              child: Container(
                width: double.infinity,
                height: 135.h,
                padding: EdgeInsetsDirectional.only(
                  start: 15.w,
                  end: 5.w,
                  top: 10.h,
                  // bottom: 10.h,
                ),
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff44C2CA),
                      const Color(0xff037FFF).withOpacity(0.74),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    20.width,
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            textScaler: const TextScaler.linear(0.8),
                            "${propertiescontroller.properties.length}",
                            style: TextStyle(
                              height: 1.2,
                              color: Colors.white,
                              fontSize: 120.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          width: 90.w,
                          height: 90.h,
                          child: Image.asset(AssetsHelper.homecard2),
                        ),
                        // 5.height,
                        Text(
                          "مجموع عقاراتك",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    10.width
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 102.h),
      child: Container(
        padding: EdgeInsets.only(top: 45.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.1), // Shadow color with transparency
            blurRadius: 4, // Softness of the shadow
            offset: const Offset(0, 1), // Horizontal and vertical offset
          ),
        ]),
        child: _infoWidget(),
      ),
    );
  }

  Widget _infoWidget() {
    return GestureDetector(
      onTap: () {
        // Get.find<ProfileGetxController>().getMyProfile();
        Get.toNamed(Routes.profileScreen);
      },
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 56.h,
              width: 56.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: appCachedImage(profilecontroller.userdata.value.image,
                    fit: BoxFit.cover),
              ),
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      appLocale.welcomeMessage,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    5.width,
                    appSvgImage(AssetsHelper.hand),
                  ],
                ),
                5.height,
                Text(
                  profilecontroller.userdata.value.name ?? "",
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
            const Spacer(),
            const AppNotificationIcon(),
          ],
        ),
      ),
    );
  }
}
