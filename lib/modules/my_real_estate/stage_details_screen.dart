import 'package:aysar_app/const/consts.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/models/properties_stages_model.dart';

import 'package:aysar_app/widgets/icon_title_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:photo_view/photo_view.dart';

class StageDetailsScreen extends StatelessWidget with ImageHelper {
  StageDetailsScreen({super.key, required this.stage});
  final PropertiesStagesModel stage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          stage.name ?? "",
          style:
              TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: HexColor.fromHex(stage.status?.color ?? "")
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w, vertical: 12.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Title and percentage
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  stage.name ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                5.height,
                                Row(
                                  children: [
                                    Text(
                                      " نسبة المرحلة من المشروع : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      " ${stage.ratePercentage} %",
                                      // "stage['percentage']",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Description and status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                stage.status?.name ?? "---",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      10.height,
                      const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                      10.height,
                      IconTitleBuilder(
                        title: "تاريخ البداية",
                        fontWeight: FontWeight.w500,
                        horizontal: 0,
                        // titleColor: Colors.black,
                        fontSize: 12.sp,
                        bottom: 10.h,
                        trailing: Text(
                          stage.startDate ?? "---",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                      10.height,
                      IconTitleBuilder(
                        title: "تاريخ النهاية",
                        fontWeight: FontWeight.w500,
                        horizontal: 0,
                        // titleColor: Colors.grey,
                        fontSize: 12.sp,
                        bottom: 10.h,
                        trailing: Text(
                          stage.endDate ?? "---",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                      10.height,

                      stage.reason != null
                          ? IconTitleBuilder(
                              title: "سبب التأخير",
                              fontWeight: FontWeight.w500,
                              horizontal: 0,
                              // titleColor: Colors.grey,
                              fontSize: 12.sp,
                              bottom: 10.h,
                            )
                          : empty,
                      stage.reason != null
                          ? Text(
                              stage.reason ?? "---",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            )
                          : 10.height,
                      //           Text(
                      //             "نبذة عن الشركة",
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 12.sp,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           10.height,
                      //           Text(
                      //             """
                      // هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة،
                      //  لقد تم توليد هذا النص من مولد النص العربى
                      // """,
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 10.sp,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           10.height,
                      // Row of Images
                      // i need here when tapped image open images in slider in big pop up
                      SizedBox(
                        height: 105.h,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: stage.images?.length ?? 0,
                          separatorBuilder: (context, index) => 10.width,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => _openGallery(
                                context, index, stage.images ?? []),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: appCachedImage(
                                  fit: BoxFit.cover,
                                  height: 90.h,
                                  width: 90.w,
                                  stage.images?[index].url,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(
      BuildContext context, int initialIndex, List<dynamic> imageUrls) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Dismiss",

      barrierDismissible: true,
      barrierColor: Colors.transparent, // <- no dimming overlay
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Material(
          type: MaterialType.transparency, // <- ensures transparency
          child: Stack(
            children: [
              PageView.builder(
                controller: PageController(initialPage: initialIndex),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: PhotoView(
                      backgroundDecoration: const BoxDecoration(
                        color: Colors
                            .transparent, // <- ensures image background is also transparent
                      ),
                      imageProvider: NetworkImage(imageUrls[index].url),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    ),
                  );
                },
              ),
              PositionedDirectional(
                top: 40.h,
                start: 20.w,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 30.w,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 20)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
