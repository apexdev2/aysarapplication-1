import 'package:aysar_app/const/consts.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/models/maintenance_request_model.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintenanceSupportItem extends StatelessWidget with ImageHelper {
  MaintenanceSupportItem({
    super.key,
    required this.data,
  });
  final MaintenanceRequestModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomContainer(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        // height: 146.h,
        width: double.infinity,
        // color: const Color(0xffDDF2FF),
        borderRadius: 14,
        color: Colors.white,
        boxShadow: BoxShadow(
          color:
              Colors.black.withOpacity(0.1), // Shadow color with transparency
          blurRadius: 4, // Softness of the shadow
          offset: const Offset(0, 1), // Horizontal and vertical offset
        ),
        height: 85.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 56.h,
                  width: 56.w,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFECDB),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Center(
                      child: Image.asset(
                        AssetsHelper.maintenanceIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data.issue?.name ?? "",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          // New Tag
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: HexColor.fromHex(data.status?.color??"#43CB83" ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              data.status?.name ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      5.height,
                      Text(
                        data.issueDescription ?? "",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
