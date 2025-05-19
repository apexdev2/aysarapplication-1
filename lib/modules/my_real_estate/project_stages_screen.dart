import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/my_real_estate/properties_getxcontroller.dart';
import 'package:aysar_app/modules/my_real_estate/status_item.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectStagesScreen extends StatelessWidget with ImageHelper {
  ProjectStagesScreen({super.key});
  final PropertiesGetxcontroller controller = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !controller.isLoadingMore.value &&
            controller.pagination.value.hasNext!) {
          controller.getPropertyStages(isLoadMore: true, id: 5);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "مراحل المشروع",
          style:
              TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            var project = controller.propertystages;
            return Stack(
              children: [
                Column(
                  children: [
                    CustomContainer(
                      padding: EdgeInsets.all(10.w),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            percent: Get.arguments.toDouble() / 100,
                            isRTL: true,

                            addAutomaticKeepAlive: true,
                            animateToInitialPercent: true,
                            animation: true,
                            animationDuration: 1500,
                            barRadius: const Radius.circular(15),
                            center: Text(
                              "${Get.arguments}%",
                              style: const TextStyle(color: Colors.black),
                            ),
                            backgroundColor: const Color(0xffD8D8D8),
                            progressColor: const Color(0xff108CFF),
                          ),
                        ],
                      ),
                    ),
                    20.height,

                    // Status items
                    Expanded(
                      child: CustomContainer(
                        color: Colors.white,
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مراحل المشروع :',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            10.height,
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) =>
                                    StatusItem(item: project[index]),
                                separatorBuilder: (context, index) => 10.height,
                                itemCount: project.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: controller.loadingstages.value,
                  child: PositionedDirectional(
                    top: MediaQuery.sizeOf(context).height / 2 - 50,
                    start: MediaQuery.sizeOf(context).width / 2 - 25,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
