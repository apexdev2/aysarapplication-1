import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/modules/maintenance_requests/maintenance_getx_controller.dart';
import 'package:aysar_app/modules/maintenance_requests/maintenance_support_item.dart';
import 'package:aysar_app/utils/warnings/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../app/app_routs.dart';

class MaintenanceRequestsScreen extends StatelessWidget {
  MaintenanceRequestsScreen({super.key});
  final controller = Get.find<MaintenanceGetxController>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.myRequests,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.requestsList.isEmpty
                ? const NoData()
                : ListView.separated(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 20.h,
                      horizontal: 16.w,
                    ),
                    itemBuilder: (context, index) => MaintenanceSupportItem(
                      data: controller.requestsList[index],
                    ),
                    separatorBuilder: (context, index) => 15.height,
                    itemCount: controller.requestsList.length,
                  ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(Routes.addNewRequestScreen),
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
