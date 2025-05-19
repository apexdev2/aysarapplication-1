import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/helpers/outapp_helper.dart';
import 'package:aysar_app/modules/compamies/company_getxcontroller.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:aysar_app/widgets/icon_title_builder.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CompanyDetailsScreen extends StatelessWidget
    with ImageHelper, OutAppHelper {
  CompanyDetailsScreen({super.key});
  final CompanyGetxcontroller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.details,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.loadingDetails.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Company Logo
                      Center(
                        child: Container(
                          width: 93.w,
                          height: 93.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: appCachedImage(
                              controller.caompanydetails.value.image ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      30.height,
                      // Company Name
                      Center(
                        child: Text(
                          controller.caompanydetails.value.companyName ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      50.height,
                      Text(
                        "نبذة عن الشركة",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.height,
                      Text(
                        controller.caompanydetails.value.description ?? "",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.height,
                      Text(
                        "بيانات التواصل",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.height,
                      controller.caompanydetails.value.showmobile == true
                          ? IconTitleBuilder(
                              horizontal: 0,
                              icon: AssetsHelper.yellowphone,
                              iconSize: 25,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              title: appLocale.mobile,
                              trailing: Text(
                                controller.caompanydetails.value.mobile ?? "",
                              ),
                            )
                          : empty,
                      8.height,
                      IconTitleBuilder(
                        horizontal: 0,
                        // iconcolor: Colors.amber,
                        icon: AssetsHelper.redemail,
                        iconSize: 25,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        title: appLocale.email,
                        trailing: Text(
                          controller.caompanydetails.value.email ?? "",
                        ),
                      ),
                      48.height,
                      Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              onTap: () => launchThisUrl(
                                  controller.caompanydetails.value.mobile ?? "",
                                  type: LauncherType.whatsapp),
                              height: 50,
                              fontSize: 12,
                              text: appLocale.contactViaWhatsApp,
                              icon: AssetsHelper.whatsapp,
                              iconColor: Colors.white,
                              iconHeight: 18,
                              iconThenText: true,
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: MyButton(
                              onTap: () => launchThisUrl(
                                  controller.caompanydetails.value.url ?? "",
                                  type: LauncherType.link),
                              height: 50,
                              text: "الموقع الرسمي",
                              // text: appLocale.contactViaemail,
                              icon: AssetsHelper.global,
                              iconColor: Colors.white,
                              iconHeight: 20,
                              fontSize: 12,
                              iconThenText: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
