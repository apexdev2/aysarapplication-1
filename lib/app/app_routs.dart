import 'package:aysar_app/modules/auth/login_screen.dart';
import 'package:aysar_app/modules/auth/otp_screen.dart';
import 'package:aysar_app/modules/bnb/bnb_screen.dart';
import 'package:aysar_app/modules/compamies/companies_screen.dart';
import 'package:aysar_app/modules/compamies/company_details_screen.dart';
import 'package:aysar_app/modules/maintenance_requests/add_new_request_screen.dart';
import 'package:aysar_app/modules/my_account/pages/pages_screen.dart';
import 'package:aysar_app/modules/my_account/profile/profile_screen.dart';
import 'package:aysar_app/modules/my_account/settings/setting_screen.dart';
import 'package:aysar_app/modules/my_real_estate/project_stages_screen.dart';
import 'package:aysar_app/modules/my_real_estate/proparity_details_screen.dart';

import 'package:aysar_app/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/LoginScreen';
  static const String onBordinRoute = '/OnBordingScreen';
  static const String forgetPasswordRoute = '/ForgetPasswordScreen';
  static const String registerRoute = '/RegisterScreen';
  static const String otpscreen = '/OtpScreen';
  static const String termsAndPolicy = '/TermsAndPolicy';
  static const String resetPasswordRoute = '/ResetPasswordScreen';
  static const String todayReservationsScreen = '/TodayReservationsScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String searchResultScreen = '/SearchResultScreen';
  static const String bottomNavScreen = '/BottomNavScreen';
  static const String companiesScreen = '/CompaniesScreen';
  static const String companyDetailsScreen = '/CompanyDetailsScreen';
  static const String proparityDetailsScreen = '/ProparityDetailsScreen';
  static const String projectStagesScreen = '/ProjectStagesScreen';
  // static const String stageDetailsScreen = '/stageDetailsScreen';
  static const String settingScreen = '/SettingScreen';
  static const String pagesScreen = '/PagesScreen';
  static const String addNewRequestScreen = '/AddNewRequestScreen';
}

List<GetPage<dynamic>> appRoutes = [
  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.loginRoute,
    page: () => const LoginScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.otpscreen,
    page: () => const OtpScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.bottomNavScreen,
    page: () => const BottomNavScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.companiesScreen,
    page: () => const CompaniesScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.companyDetailsScreen,
    page: () =>  CompanyDetailsScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.proparityDetailsScreen,
    page: () =>  ProparityDetailsScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.projectStagesScreen,
    page: () =>  ProjectStagesScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  // GetPage(
  //   name: Routes.stageDetailsScreen,
  //   page: () => StageDetailsScreen(),
  //   transitionDuration: const Duration(milliseconds: 200),
  // ),
  GetPage(
    name: Routes.settingScreen,
    page: () => const SettingScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.profileScreen,
    page: () => ProfileScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.pagesScreen,
    page: () => const PagesScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Routes.addNewRequestScreen,
    page: () => const AddNewRequestScreen(),
    transitionDuration: const Duration(milliseconds: 200),
  ),
];
