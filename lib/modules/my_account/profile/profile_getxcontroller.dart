import 'dart:io';
import 'package:aysar_app/api/repo/auth_repo.dart';
import 'package:aysar_app/models/user_model.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:aysar_app/utils/utils.dart';
import 'package:aysar_app/widgets/countries.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileGetxcontroller extends GetxController {
  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  RxBool updateLoading = false.obs;

  void updatePage({required bool value, required Rx<bool> isLoading}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        isLoading.value = value;
      },
    );
  }

  var userdata = User().obs;
  AppIntlCountry? selectedIntlCountry;
  File? profileImage;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  getMyProfile() async {
    updatePage(value: true, isLoading: isLoading);

    var responce = await AuthRepo().getPtofile();
    if (responce.success) {
      userdata.value = responce.data!;
      await initializedProfileControlers(responce.data);
    }
    updatePage(value: false, isLoading: isLoading);
  }

  initializedProfileControlers(User? userdata) async {
    emailcontroller = TextEditingController(text: userdata?.email ?? "");
    namecontroller = TextEditingController(text: userdata?.name ?? "");
    mobileController = TextEditingController(text: userdata?.mobile ?? "");
  }

  updateProfileImage({required File? image}) {
    profileImage = image;
    update();
  }

  updateSelectedIntlCountry({required AppIntlCountry? intlCountry}) {
    selectedIntlCountry = intlCountry;
    update();
  }

  updateProfile() async {
    updatePage(value: true, isLoading: updateLoading);

    dio.MultipartFile? profileImageToSend;
    if (profileImage != null) {
      profileImageToSend = await dio.MultipartFile.fromFile(
        profileImage!.path,
      );
    } else {
      profileImageToSend = null;
    }
    dio.FormData formData = dio.FormData.fromMap({
      "name": namecontroller.text,
      "email": emailcontroller.text,
      "mobile": mobileController.text,
      "mobile_country_code": selectedIntlCountry?.code ?? "sa",
      "dial_code": selectedIntlCountry?.dialCode ?? "966",
      if (profileImageToSend != null)
        "image": profileImageToSend, // Add only if exists
    });
    var response = await AuthRepo().updateProfile(body: formData);

    if (response.success) {
      Utils.getSnakBar(type: TosterTypes.sucsses, message: response.message);
      await getMyProfile();
    } else {
      Utils.getSnakBar(type: TosterTypes.failed, message: response.message);
    }
    updatePage(value: false, isLoading: updateLoading);
  }

  // BaseApiResponce? _baseApiResponse;

  // activateNotification({required int activatestatuse}) async {
  //   isLoading = true;
  //   update();
  //   _baseApiResponse = await ShareedRepo()
  //       .activateNotification(activatestatuse: activatestatuse);
  //   if (_baseApiResponse?.status != false) {
  //     getMyProfile();
  //   }
  //   isLoading = false;
  //   update();
  // }
}
