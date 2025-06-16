import 'package:aysar_app/api/network/local/cashe_helper.dart';
import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/fb_notifications.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with ImageHelper, FbNotifications {
  @override
  void initState() {
    super.initState();
    initNotificationLogic();
    goNext();
  }

  Future<void> initNotificationLogic() async {
    debugPrint("****** init Notification Logic ******");
    await callNotifications();
  }

  goNext() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        var userToken =
            await CacheHelper.getSecureData(key: CacheKeys.userToken.name);
        debugPrint("userToken=========================$userToken");
        if (userToken == null) {
          Get.offNamed(Routes.loginRoute);
        } else {
          debugPrint('we are her5555555555555 ');
          Get.offNamed(Routes.bottomNavScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetsHelper.splashBg),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(0.7),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.w),
              child: Image.asset(
                AssetsHelper.aysarlogo,
                height: 122.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
