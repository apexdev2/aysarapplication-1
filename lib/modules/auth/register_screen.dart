import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/data_checker.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/auth/auth_getxcontroller.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:aysar_app/widgets/my_custom_checkbox.dart';
import 'package:aysar_app/widgets/my_mobile_text_field.dart';
import 'package:aysar_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../widgets/countries.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with ImageHelper, DataCheckerHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  TextEditingController mobileController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AppIntlCountry? selectedIntlCountry;
  bool _policy = false;
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
                  height: MediaQuery.sizeOf(context).height / 2 - 80,
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
                        appLocale.createTheAccount,
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
            20.height,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    appLocale.createAccount,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  23.height,
                  MyTextField(
                    textcolor: Colors.grey.shade400,
                    hasBorder: false,
                    controller: nameController,
                    bottomPadding: 15,
                    hint: appLocale.fullName,
                    prefixIcon: 'person.svg',
                    labelText: appLocale.theName,
                  ),
                  15.height,
                  MyTextField(
                    textcolor: Colors.grey.shade400,
                    hasBorder: false,
                    controller: emailController,
                    bottomPadding: 15,
                    hint: "Email@gmail.com",
                    prefixIcon: 'email_icon.svg',
                    labelText: appLocale.email,
                    hintTextDirection: TextDirection.ltr,
                  ),
                  15.height,
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
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomCheckbox(
                        status: _policy,
                        callBack: (_) => setState(() => _policy = _),
                      ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          appLocale.agreeOn,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                  25.height,
                  GetBuilder<AuthGetxcontroller>(
                    builder: (controller) => MyButton(
                      text: appLocale.login,
                      loading: controller.isLoading,
                      onTap: () async {
                        if (checkData) {}
                        controller.registerUser(
                          dialCode: selectedIntlCountry?.dialCode ?? "966",
                          mobileCountryCode: selectedIntlCountry?.code ?? "sa",
                          mobile: mobileController.text,
                          email: emailController.text,
                          name: nameController.text,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get checkData =>
      checkText(
        text: nameController.text,
        errorMessage: appLocale.enterNameEx,
      ) &&
      checkText(
          text: emailController.text,
          errorMessage: appLocale.enterEmailEx,
          email: true) &&
      checkText(
        text: mobileController.text,
        errorMessage: appLocale.enterMobileEx,
      ) &&
      checkBool(message: "يجب الموافقة على الشروط والاحكام", item: _policy);
}
