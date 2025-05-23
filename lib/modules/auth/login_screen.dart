// import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/auth/auth_getxcontroller.dart';
import 'package:aysar_app/modules/auth/register_screen.dart';
import 'package:aysar_app/widgets/my_button.dart';
// import 'package:aysar_app/widgets/my_custom_checkbox.dart';
import 'package:aysar_app/widgets/my_mobile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../widgets/countries.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ImageHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AppIntlCountry? selectedIntlCountry;
  // bool _policy = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AssetsHelper.bg2,
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 24.w,
                  top: 136.h,
                  end: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        appLocale.login,
                        style: TextStyle(fontSize: 24.sp, color: Colors.white),
                      ),
                      10.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            appLocale.hello,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                            ),
                          ),
                          5.width,
                          appSvgImage(AssetsHelper.hand)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            28.height,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    appLocale.enter_phone_to_login,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  23.height,
                  MyMobileTextField(
                    labelText: appLocale.mobile,
                    prefixIcon: 'mobile_icon.svg',
                    withIcon: false,
                    countriesEnabled: true,
                    controller: mobileController,
                    bottomPadding: 15,
                    dialCode: selectedIntlCountry?.dialCode,
                    fillColor: Colors.white,
                    hasBorder: false,
                    mobileCallback: (c) =>
                        setState(() => selectedIntlCountry = c),
                  ),
                  // 10.height,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomCheckbox(
                  //       status: _policy,
                  //       callBack: (_) => setState(() => _policy = _),
                  //     ),
                  //     SizedBox(width: 16.w),
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Text(
                  //         appLocale.agreeOn,
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColor,
                  //             fontSize: 10.sp),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  25.height,
                  GetBuilder<AuthGetxcontroller>(
                    builder: (controller) => MyButton(
                      text: appLocale.login,
                      loading: controller.isLoading,
                      onTap: () async {
                        controller.loginUser(
                            dialCode: selectedIntlCountry?.dialCode ?? "966",
                            mobileCountryCode:
                                selectedIntlCountry?.code ?? "sa",
                            mobile: mobileController.text);
                        // Get.toNamed(Routes.otpscreen);
                      },
                    ),
                  ),
                  15.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomCheckbox(
                      //   status: _policy,
                      //   callBack: (_) => setState(() => _policy = _),
                      // ),
                      // SizedBox(width: 16.w),
                      Text(
                        appLocale.doNotHaveAnAccount,
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      ),
                      5.width,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const RegisterScreen());
                        },
                        child: Text(
                          appLocale.createAccount,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
