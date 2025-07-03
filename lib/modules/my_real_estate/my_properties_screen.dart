import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/models/properties_model.dart';
import 'package:aysar_app/modules/my_real_estate/properties_getxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MrPropertiesScreen extends StatelessWidget with ImageHelper {
  MrPropertiesScreen({super.key});
  final PropertiesGetxcontroller controller = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    // ignore: invalid_use_of_protected_member
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !controller.isLoadingMoreproperties.value &&
            controller.paginationProperties.value.hasNext!) {
          controller.getProperties(
            isLoadMore: true,
          );
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.properties,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.getProperties(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            padding: EdgeInsetsDirectional.symmetric(
              vertical: 20.h,
              horizontal: 16.w,
            ),
            itemBuilder: (context, index) =>
                buildItem(property: controller.properties[index]),
            separatorBuilder: (context, index) => 15.height,
            itemCount: controller.properties.length,
          ),
        ),
      ),
    );
  }

  Widget buildItem({required PropertiesModel property}) {
    return GestureDetector(
      onTap: () {
        controller.getpropertiesDetails(id: property.id!);
        Get.toNamed(Routes.proparityDetailsScreen);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Project Image
            Container(
              margin: EdgeInsets.all(12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: appCachedImage(
                  property.image ?? "",
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Project Info
            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Title and New Tag
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Expanded(
                        child: Text(
                          property.name ?? "",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff363535),
                          ),
                        ),
                      ),
                      10.width,
                      // New Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 5.w),
                        decoration: BoxDecoration(
                          color: const Color(0xff39B6D3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          property.type ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  16.height,

                  // Developer
                  GestureDetector(
                    onTap: () {
                      // Get.find<CompanyGetxcontroller>()
                      //     .getCompaniesDetails(id: property.company!.id!);
                      // Get.toNamed(Routes.companyDetailsScreen);
                    },
                    child: Row(
                      children: [
                        Text(
                          'المطور :',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        8.width,
                        Text(
                          property.company?.companyName ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  // Completion Percentage
                  Text(
                    'نسبة إنجاز المشروع :',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),

                  8.height,
                  // Progress Bar
                  LinearPercentIndicator(
                    // width: 140.0,
                    lineHeight: 23.h,
                    percent: property.completionpercentage != null
                        ? property.completionpercentage.toDouble() / 100
                        : 0.0 / 100,
                    isRTL: true,
                    addAutomaticKeepAlive: true,
                    animateToInitialPercent: true,
                    animation: true,
                    animationDuration: 1500,
                    barRadius: const Radius.circular(15),
                    center: Text(
                      "${property.completionpercentage}%",
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: const Color(0xffD8D8D8),
                    progressColor: const Color(0xff108CFF),
                  ),
                  8.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
