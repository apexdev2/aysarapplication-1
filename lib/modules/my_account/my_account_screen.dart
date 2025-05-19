import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/alert_dialogs_helper.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/auth/auth_getxcontroller.dart';
import 'package:aysar_app/modules/my_account/profile/profile_getxcontroller.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:aysar_app/widgets/info_widget.dart';
import 'package:aysar_app/widgets/my_alert_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/my_list_tile.dart';

class MyAccountScreen extends StatelessWidget
    with ImageHelper, AlertDialogsHelper {
  MyAccountScreen({super.key});
  final ProfileGetxcontroller profilecontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.myaccount,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          children: [
            Obx(
              () => InfoWidget(
                email: profilecontroller.userdata.value.email,
                image: profilecontroller.userdata.value.image,
                mobile: profilecontroller.userdata.value.mobile,
                name: profilecontroller.userdata.value.name,
                onTap: () {
                  Get.toNamed(Routes.profileScreen);
                },
              ),
            ),
            25.h.height,
            CustomContainer(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  MyListTile(
                    icon: AssetsHelper.profileicon,
                    leading: appLocale.profile,
                    onTap: () {
                      Get.toNamed(Routes.profileScreen);
                    },
                  ),
                  MyListTile(
                    icon: AssetsHelper.pagesIcon,
                    leading: appLocale.pages,
                    onTap: () {
                      Get.toNamed(Routes.pagesScreen);
                    },
                  ),
                  MyListTile(
                    icon: AssetsHelper.settingIcon,
                    leading: appLocale.theSettings,
                    onTap: () {
                      Get.toNamed(Routes.settingScreen);
                    },
                  ),
                  MyListTile(
                    icon: AssetsHelper.logoutIcon,
                    leading: appLocale.logout,
                    onTap: () => _openConfirmDialog(
                        context,
                        () {},
                        // () => Get.find<AuthGetxcontroller>().logoutUser(),
                        false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openConfirmDialog(
      BuildContext context, Function() filledAction, bool loading) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    return alertDialogTemplate(
      context,
      backgroundColor: Colors.white,
      showClose: false,
      body: StatefulBuilder(
        builder: (context, newState) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 76.h,
                width: 76.w,
                child: appSvgImage(AssetsHelper.logoutIcon),
              ),
            ),
            20.height,
            Text(
              appLocale.confirmLogout,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
            15.height,
            Row(
              children: [
                GetBuilder<AuthGetxcontroller>(
                  builder: (controller) => MyAlertButton(
                    text: appLocale.confirm,
                    filled: false,
                    loading: controller.isLoading,
                    action: () {
                      controller.logoutUser();
                    },
                  ),
                ),
                SizedBox(width: 20.w),
                MyAlertButton(
                  text: appLocale.no,
                  filled: true,
                  action: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
