import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Utils {

  static const IconData exclamationmark = IconData(
    0xf655,
  );

  static void getSnakBar(
      {DioException? e,
      String? message,
      Color? color,
      required TosterTypes? type}) {
    Get.showSnackbar(
      GetSnackBar(
          padding: EdgeInsets.zero,
          borderRadius: 16.r,
          // message: message,
          margin: const EdgeInsets.all(16),
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          backgroundColor: type == TosterTypes.failed
              ? const Color(0xffF63E50)
              : type == TosterTypes.sucsses
                  ? const Color(0xff03A65A)
                  : type == TosterTypes.warning
                      ? const Color(0xffF9943B)
                      : const Color(0xffF63E50),
          messageText: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                top: 12.h,
                end: 0,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.only(bottom: 10.h, end: 16.w),
                    child: SizedBox(
                      height: 35.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12.r,
                            backgroundColor: type == TosterTypes.failed
                                ? const Color(0xff99004D)
                                : type == TosterTypes.sucsses
                                    ? const Color(0xff2FCE8E)
                                    : type == TosterTypes.warning
                                        ? const Color(0xffB15500)
                                        : const Color(0xff99004D),
                            child: Center(
                              child: Icon(
                                size: 18,
                                type == TosterTypes.failed
                                    ? Icons.close
                                    : type == TosterTypes.sucsses
                                        ? Icons.check
                                        : type == TosterTypes.warning
                                            ? Icons.error_outline_outlined
                                            : Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: Text(
                              message ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
               
                ],
              ),
            ),
          )),
    );
  }

  static Future<dynamic> openAlertDialog({
    required BuildContext context,
    required String assetPath,
    required String description,
    required Function() yesOnTap,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 350.w, // Adjust the width as needed
            height: 250.h, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SvgPicture.asset(
                  assetPath,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5.h),
                // If you want to include a title, uncomment the lines below
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: yesOnTap,
                          child: Text(
                            "Yes".tr,
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          )),
                      TextButton(
                        child: Text("No".tr,
                            style: const TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
