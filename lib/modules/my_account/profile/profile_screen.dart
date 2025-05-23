import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/helpers/picker_helper.dart';
import 'package:aysar_app/modules/my_account/profile/profile_getxcontroller.dart';

import 'package:aysar_app/widgets/custom_container.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:aysar_app/widgets/my_mobile_text_field.dart';
import 'package:aysar_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget with ImageHelper, PickerHelper {
  ProfileScreen({super.key});
  final ProfileGetxcontroller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          appLocale.profile,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
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
            : Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    GetBuilder<ProfileGetxcontroller>(
                      builder: (controller) => Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: controller.profileImage == null
                                    ? appCachedImage(
                                        alignment: Alignment.center,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        controller.userdata.value.image ?? "")
                                    : Image.file(controller.profileImage!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 5,
                            start: MediaQuery.sizeOf(context).width / 2,
                            child: GestureDetector(
                              onTap: () async {
                                var file = await pickImage();
                                if (file != null) {
                                  controller.updateProfileImage(image: file);
                                  // setState(() => profileImage = file);
                                }
                              },
                              child: CircleAvatar(
                                radius: 15.r,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: appSvgImage(AssetsHelper.editIcon),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    30.height,
                    CustomContainer(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          MyTextField(
                            textcolor: Colors.grey.shade400,
                            hasBorder: false,
                            controller: controller.namecontroller,
                            bottomPadding: 15,
                            hint: appLocale.fullName,
                            prefixIcon: 'person.svg',
                            labelText: appLocale.theName,
                          ),
                          15.height,
                          MyTextField(
                            textcolor: Colors.grey.shade400,
                            hasBorder: false,
                            controller: controller.emailcontroller,
                            bottomPadding: 15,
                            hint: "Email@gmail.com",
                            prefixIcon: 'email_icon.svg',
                            labelText: appLocale.email,
                            hintTextDirection: TextDirection.ltr,
                          ),
                          15.height,
                          MyMobileTextField(
                              isBlack: false,
                              labelText: appLocale.mobile,
                              prefixIcon: 'mobile_icon.svg',
                              withIcon: false,
                              countriesEnabled: false,
                              controller: controller.mobileController,
                              bottomPadding: 15,
                              dialCode:
                                  controller.selectedIntlCountry?.dialCode,
                              fillColor: Colors.white,
                              hasBorder: false,
                              mobileCallback: (_) => controller
                                  .updateSelectedIntlCountry(intlCountry: _)
                              // setState(() => controller.selectedIntlCountry = _),
                              ),
                          30.height,
                          MyButton(
                            text: appLocale.save,
                            loading: controller.isLoading.value,
                            onTap: () {
                              controller.updateProfile();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
