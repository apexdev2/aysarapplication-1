import 'dart:async';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/auth/auth_getxcontroller.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:aysar_app/widgets/otp_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with ImageHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late TextEditingController codeController;
  bool canResendCode = false;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 10);

  void get startTimer {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown);
  }

  // AuthGetxcontroller authGetxcontroller = Get.find<AuthGetxcontroller>();
  void get setCountDown {
    setState(() {
      final seconds = myDuration.inSeconds - 1;
      if (seconds < 0) {
        countdownTimer!.cancel();
        canResendCode = true;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    codeController = TextEditingController();
    startTimer;
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    countdownTimer!.cancel();

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
                        appLocale.verificationCode,
                        style: TextStyle(fontSize: 24.sp, color: Colors.white),
                      ),
                      10.height,
                      Text(
                        appLocale.enterCodeSentToMobile,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            28.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    appLocale.enterVerificationCode,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  30.height,
                  OtpSection(
                    controller: codeController,
                    onSubmitted: (c) async {
                      setState(() => codeController.text = c);
                    },
                  ),
                  20.height,
                  !canResendCode
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            6.width,
                            Text(
                              ' ${appLocale.remaining} : ${myDuration.inSeconds} ${"ث"}',
                              // متبقي
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        )
                      : empty,
                  10.height,
                  GestureDetector(
                    onTap: canResendCode
                        ? () async {
                            setState(() => [
                                  canResendCode = false,
                                  myDuration = const Duration(seconds: 90)
                                ]);
                            startTimer;
                          }
                        : null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          color: Theme.of(context).hintColor,
                        ),
                        5.width,
                        Text(
                          appLocale.again,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.height,
                  GetBuilder<AuthGetxcontroller>(
                    builder: (controller) => MyButton(
                      loading: controller.isLoading,
                      text: appLocale.confirm,
                      onTap: () {
                        controller.verifyLoginUser(
                            code: codeController.text,
                            loginbody: Get.arguments);
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
}
