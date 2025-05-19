import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/modules/my_account/pages/about_page.dart';
import 'package:aysar_app/modules/my_account/pages/faq_quastion_screen.dart';
import 'package:aysar_app/modules/shareed/shareed_getxcontroller.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:aysar_app/widgets/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PagesScreen extends StatelessWidget {
  const PagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.pages,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ShareedGetxcontroller>(
        builder: (controller) => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomContainer(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => MyListTile(
                        icon: controller.pages[index].icon ?? "",
                        assetIcon: false,
                        leading: controller.pages[index].title ?? "",
                        onTap: () {
                          if (controller.pages[index].type == "faq") {
                            controller.getFAQ();
                            Get.to(() => FaqQuastionScreen());
                          } else {
                            controller.showPage(
                                type: controller.pages[index].type ?? '');
                            Get.to(
                              () => AboutPage(
                                appbarTitle:
                                    controller.pages[index].title ?? "",
                              ),
                            );
                          }
                        },
                        divider: false,
                      ),
                      separatorBuilder: (context, index) => Divider(
                        height: 0,
                        thickness: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      ),
                      itemCount: controller.pages.length,
                    ),
                    10.height,
                    MyListTile(
                      icon: AssetsHelper.aboutIcon,
                      assetIcon: true,
                      leading: appLocale.faq,
                      onTap: () {
                        controller.getFAQ();
                        Get.to(() => FaqQuastionScreen());
                      },
                      divider: false,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
