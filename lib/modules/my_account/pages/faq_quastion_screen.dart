import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/shareed/shareed_getxcontroller.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class FaqQuastionScreen extends StatelessWidget with ImageHelper {
  FaqQuastionScreen({super.key});
  final ShareedGetxcontroller shareedGetxcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.faq,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => shareedGetxcontroller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomContainer(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ExpansionTile(
                                iconColor: const Color(0xffB8B8B8),
                                collapsedIconColor: const Color(0xffB8B8B8),
                                collapsedBackgroundColor:
                                    const Color(0xffF9F9F9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                childrenPadding: const EdgeInsets.all(10),
                                textColor: Colors.black,
                                tilePadding: EdgeInsetsDirectional.only(
                                  start: 20.w,
                                  end: 20.w,
                                ),
                                backgroundColor: const Color(0xffF9F9F9),
                                title: Text(
                                  shareedGetxcontroller.faqs[index].title ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      shareedGetxcontroller
                                              .faqs[index].content ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color(0xffB8B8B8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => 10.height,
                          itemCount: shareedGetxcontroller.faqs.length),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
