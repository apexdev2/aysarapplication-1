import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/compamies/company_getxcontroller.dart';
import 'package:aysar_app/modules/maintenance_requests/add_new_request_screen.dart';
import 'package:aysar_app/modules/my_real_estate/properties_getxcontroller.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:aysar_app/widgets/icon_title_builder.dart';
import 'package:aysar_app/widgets/info_widget.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProparityDetailsScreen extends StatelessWidget with ImageHelper {
  ProparityDetailsScreen({super.key});
  final PropertiesGetxcontroller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.details,
          style:
              TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => controller.loadingDetails.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 335.h,
                        child: Column(
                          children: [
                            Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                ),
                                child: appCachedImage(
                                  controller.propertiesdetails.value.image ??
                                      "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Row of Smaller Images
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.all(16),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.propertiesdetails.value
                                        .propertyImages?.length ??
                                    0,
                                separatorBuilder: (context, index) => 10.width,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: appCachedImage(
                                      fit: BoxFit.cover,
                                      height: 90.h,
                                      width: 90.w,
                                      controller.propertiesdetails.value
                                              .propertyImages?[index].url ??
                                          "",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.height,
                      CustomContainer(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        borderRadius: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              controller.propertiesdetails.value.name ?? "",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff363535),
                              ),
                            ),
                            25.height,
                            Text(
                              appLocale.addressDetails,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                            10.height,
                            Text(
                              controller.propertiesdetails.value.address ?? "",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            10.height,
                            Text(
                              "مطور العقار ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                            15.height,
                            InfoWidget(
                              image: controller
                                      .propertiesdetails.value.company?.image ??
                                  "",
                              mobile: controller.propertiesdetails.value.company
                                      ?.mobile ??
                                  "",
                              name: controller.propertiesdetails.value.company
                                      ?.companyName ??
                                  "",
                              onTap: () {
                                Get.find<CompanyGetxcontroller>()
                                    .getCompaniesDetails(
                                        id: controller.propertiesdetails.value
                                            .company!.id!);
                                Get.toNamed(Routes.companyDetailsScreen);
                              },
                              email: controller
                                      .propertiesdetails.value.company?.email ??
                                  "",
                            ),
                            15.height,
                            Text(
                              "وصف العقار",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                            Text(
                              controller.propertiesdetails.value.description ??
                                  "",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            10.height,
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                              endIndent: 10,
                              indent: 10,
                            ),
                            15.height,
                            Text(
                              "مميزات العقار",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: "المساحة",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                "${controller.propertiesdetails.value.area ?? ""} متر",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: "غرف نوم ماستر",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller.propertiesdetails.value
                                        .masterBedrooms ??
                                    "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: "غرف نوم",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller.propertiesdetails.value.bedrooms ??
                                    "",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: "الصالات",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller
                                        .propertiesdetails.value.livingRooms ??
                                    "",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: "دورات المياه",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller.propertiesdetails.value.bathrooms ??
                                    "",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: " الغرف",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller.propertiesdetails.value.totalRooms ??
                                    "",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            IconTitleBuilder(
                              title: " غرف السائق",
                              horizontal: 0,
                              titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                              trailing: Text(
                                controller
                                        .propertiesdetails.value.driverRooms ??
                                    "",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            10.height,
                            controller.propertiesdetails.value.specifications !=
                                    null
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var item = controller.propertiesdetails
                                          .value.specifications?[index];
                                      return IconTitleBuilder(
                                        title: item?.name ?? "",
                                        horizontal: 0,
                                        titleColor: Colors.grey,
                                        fontSize: 12.sp,
                                        bottom: 10.h,
                                        trailing: Text(
                                          item?.description ?? "",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.grey.shade300,
                                          height: 20.h,
                                        ),
                                    itemCount: controller.propertiesdetails
                                            .value.specifications?.length ??
                                        0)
                                : empty,
                            48.height,
                            Row(
                              children: [
                                Expanded(
                                  child: MyButton(
                                    onTap: () {
                                      controller.getPropertyStages(
                                          id: controller
                                              .propertiesdetails.value.id!);
                                      Get.toNamed(Routes.projectStagesScreen,
                                          arguments: {
                                            "id": controller
                                                .propertiesdetails.value.id,
                                            "percentage": controller
                                                .propertiesdetails
                                                .value
                                                .completionPercentage!
                                          },);
                                    },
                                    height: 50,
                                    fontSize: 12,
                                    text: "مراحل المشروع",
                                    iconHeight: 18,
                                  ),
                                ),
                                10.width,
                                Expanded(
                                  child: MyButton(
                                    onTap: () =>
                                        Get.to(const AddNewRequestScreen()),
                                    fillColor: const Color(0xffF8AE7D),
                                    height: 50,
                                    text: "ابلاغ عن مشكللة",
                                    iconHeight: 20,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
