import 'package:aysar_app/api/network/local/cashe_helper.dart';
import 'package:aysar_app/api/network/remote/dio_helper.dart';
import 'package:aysar_app/api/repo/auth_repo.dart';
import 'package:aysar_app/helpers/snakbar.dart';
import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/models/user_model.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:aysar_app/utils/utils.dart';
import 'package:get/get.dart';

class AuthGetxcontroller extends GetxController with SnackBarHelper {
  bool isLoading = false;

  verifyLoginUser({
    required String code,
    required Map<String, String?> loginbody,
  }) async {
    isLoading = true;
    update();
    var body = loginbody;

    body.addAll(
      {"code": code},
    );
    var responce = await AuthRepo().verifyloginUser(body: body);
    isLoading = false;
    update();

    if (responce.success) {
      Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
      await saveUserData(userModel: responce.data!);
      Get.offAllNamed(Routes.bottomNavScreen);
    } else {
      Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
  }

  loginUser({
    required String? dialCode,
    required String? mobileCountryCode,
    required String? mobile,
  }) async {
    isLoading = true;
    update();
    var responce = await AuthRepo().loginUser(
      loginData: {
        'dial_code': dialCode,
        'mobile_country_code': mobileCountryCode?.toLowerCase(),
        'mobile': mobile,
      },
    );
    isLoading = false;
    update();
    if (responce.success) {
      Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
      Get.toNamed(
        Routes.otpscreen,
        arguments: {
          'dial_code': dialCode,
          'mobile_country_code': mobileCountryCode?.toLowerCase(),
          'mobile': mobile,
        },
      );
    } else {
      Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
  }

  logoutUser() async {
    isLoading = true;
    update();
    var responce = await AuthRepo().logoutUser();
    isLoading = false;
    update();
    if (responce.success) {
      Utils.getSnakBar(type: TosterTypes.sucsses, message: responce.message);
      CacheHelper.clearCache(key: CacheKeys.userToken.name);
      Get.offAllNamed(
        Routes.loginRoute,
      );
    } else {
      Utils.getSnakBar(type: TosterTypes.failed, message: responce.message);
    }
  }

  saveUserData({required AuthModel userModel}) async {
    await CacheHelper.assignSecureData(
        key: CacheKeys.userToken.name, value: userModel.token ?? "");
    DioHelper.updateHeadersManually();
    // CacheHelper.assignData(
    //     key: CacheKeys.name.name, value: userModel.user!.name ?? "");
    // CacheHelper.assignData(
    //     key: CacheKeys.mobile.name, value: userModel.user!.mobile ?? "");
    // CacheHelper.assignData(
    //     key: CacheKeys.profileImage.name,
    //     value: userModel.user!.image ?? "");
    // CacheHelper.assignData(
    //     key: CacheKeys.countryCode.name,
    //     value: userModel.user!.mobileCountryCode ?? "");
    // CacheHelper.assignData(
    //     key: CacheKeys.dialCode.name,
    //     value: userModel.user!.dialCode ?? "");
    update();
  }
}
