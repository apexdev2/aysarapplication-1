import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/modules/shareed/shareed_getxcontroller.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  AboutPage({
    super.key,
    required this.appbarTitle,
  });
  final String appbarTitle;

  final ShareedGetxcontroller shareedGetxcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appbarTitle,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body:
          // GetBuilder<SplashGetxcontroller>(
          //   builder: (controller) => controller.isLoading
          //       ? const Center(
          //           child: CircularProgressIndicator(),
          //         )
          //       :
          SingleChildScrollView(
        child: Obx(
          () => CustomContainer(
            padding: const EdgeInsets.all(16),
            child: shareedGetxcontroller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HtmlWidget(
                          shareedGetxcontroller.pageDetails.value.content ??
                              ""),
                      20.height,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
