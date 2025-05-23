import 'package:aysar_app/api/network/local/cashe_helper.dart';
import 'package:aysar_app/api/network/remote/dio_helper.dart';
import 'package:aysar_app/app/app_binding.dart';
import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/cache/cache_controller.dart';
// import 'package:aysar_app/firebase_options.dart';
// import 'package:aysar_app/helpers/fb_notifications.dart';
import 'package:aysar_app/helpers/lang_controller.dart';
import 'package:aysar_app/utils/enms.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Shared Preferences
  await CacheController().initSharedPreferences();
  if (CacheController().getter(key: CacheKeys.language) == null) {
    await CacheController().setter(key: CacheKeys.language, value: 'ar');
  }
  await CacheHelper.init();
  await DioHelper.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FbNotifications.initNotifications();
  // FirebaseMessaging.instance.getToken().then(
  //   (value) async {
  //     if (kDebugMode) {
  //       print('Fcm ==> $value');
  //     }
  //     await CacheController()
  //         .setter(value: value ?? '', key: CacheKeys.fcmToken);
  //   },
  // );
  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: allow upside-down
  ]);

  /// App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LanguageGetxController());
    final ThemeData theme = ThemeData();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        title: 'Action Point',
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        getPages: appRoutes,
        supportedLocales: AppLanguages.values
            .map(
              (language) => Locale(language.name),
            )
            .toList(),
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff363535)),
            bodyLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff363535)),
            bodyMedium: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff363535)),
            bodySmall: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: Color(0xff363535)),
            displayLarge: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Color(0xff363535)),
            displayMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xff363535)),
            displaySmall: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff363535)),
            headlineLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xff363535)),
            headlineMedium: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Color(0xff363535)),
            headlineSmall: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xff363535)),
            labelLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff363535)),
            labelMedium: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff363535)),
            labelSmall: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xff363535)),
            titleLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff363535)),
            titleSmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff363535)),
          ),
          fontFamily: "MontserratArabic",
          primaryColor: const Color(0xff05A5FF),
          secondaryHeaderColor: const Color(0XFF0B629C),
          hintColor: const Color(0xffD8D8D8),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          dividerColor: Colors.grey.shade300,
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color(0xff05A5FF),
            secondary: const Color(0XFF0B629C),
          ),
          scaffoldBackgroundColor: const Color(0xffF8F8F8),
          shadowColor: Colors.grey.shade200,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(Get.find<LanguageGetxController>().lang),
        // home: const OtpScreen(),
      ),
    );
  }
}
