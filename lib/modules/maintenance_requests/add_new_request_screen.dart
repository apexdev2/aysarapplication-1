import 'dart:io';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/data_checker.dart';
import 'package:aysar_app/models/id_name_model.dart';
import 'package:aysar_app/models/properties_model.dart';
import 'package:aysar_app/modules/maintenance_requests/maintenance_getx_controller.dart';
import 'package:aysar_app/modules/my_real_estate/properties_getxcontroller.dart';
import 'package:aysar_app/modules/shareed/shareed_getxcontroller.dart';

import 'package:aysar_app/widgets/attachment_section.dart';
import 'package:aysar_app/widgets/custom_container.dart';
import 'package:aysar_app/widgets/my_button.dart';
import 'package:aysar_app/widgets/my_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewRequestScreen extends StatefulWidget {
  const AddNewRequestScreen({super.key});

  @override
  State<AddNewRequestScreen> createState() => _AddNewRequestScreenState();
}

class _AddNewRequestScreenState extends State<AddNewRequestScreen>
    with DataCheckerHelper {
  PropertiesGetxcontroller propertiesGetxcontroller = Get.find();
  ShareedGetxcontroller shareedGetxcontroller = Get.find();

  PropertiesModel? selectedRealstate;

  IdNameModel? selectedProblem;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "طلب صيانة",
          style:
              TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<MaintenanceGetxController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
          child: SingleChildScrollView(
              child: Column(
            children: [
              CustomContainer(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("العقار"),
                    10.height,
                    MyDropDownMenu(
                      fillColor: const Color(0xffF8F8F8),
                      height: 53,
                      radius: 10,
                      hasBorder: true,
                      hint: "اختر العقار",
                      hintColor: Colors.black,
                      item: selectedRealstate,
                      items: propertiesGetxcontroller.properties,

                      //controller.newsCategoryModel?.data ?? [],
                      callBack: (_) {
                        setState(() {
                          selectedRealstate = _;
                        });
                      },
                    ),
                    10.height,
                    const Text("قسم المشكلة"),
                    10.height,
                    MyDropDownMenu(
                      fillColor: const Color(0xffF8F8F8),
                      height: 53,
                      radius: 10,
                      hasBorder: true,
                      hint: "اختر قسم المشكلة",
                      hintColor: Colors.black,
                      item: selectedProblem,
                      items: shareedGetxcontroller.issuesList,
                      //controller.newsCategoryModel?.data ?? [],
                      callBack: (_) {
                        setState(() {
                          selectedProblem = _;
                        });
                      },
                    ),
                    10.height,
                    const Text("الوصف "),
                    10.height,
                    TextField(
                      controller: controller.noteController,
                      minLines: 5,
                      maxLines: 6,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "وصف المشكلة",
                        hintStyle: TextStyle(
                          color: const Color(0xffA4B5B2),
                          fontSize: 11.sp,
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(/*minWidth: 70.w*/),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5)),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: 40.h, maxWidth: 40.w),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5)),
                        ),
                      ),
                    ),
                    15.height,
                    Text(appLocale.theAttachments),
                    10.height,
                   AttachmentSection(
  labelText: appLocale.theAttachments,
  hintText: appLocale.explainRequirements,
  iconData: AssetsHelper.paperclip,
  onFilesSelected: (List<File> selectedFiles) {
    // تحقق من وجود ملفات
    if (selectedFiles.isNotEmpty) {
      for (var file in selectedFiles) {
        debugPrint("Selected file path: ${file.path}");
      }

      // تمرير الملفات إلى الكنترولر
      controller.updateAttachments(selectedFiles: selectedFiles);
    }
  },
),

                    25.height,
                    Obx(
                      () => 
                   MyButton(
                        text: appLocale.send,
                        loading: controller.isLoading.value,
                        onTap: () async {
                          
                          if (controller.checkData) {
                            await controller.storeMaintenanceRequest(
                              issue_description: controller.noteController.text,
                              issue_id: selectedProblem?.id??1,
                              property_id: selectedRealstate?.id??1
                              
                      
                            );
                            // if (res?. != false) {
                            
                            //   controller.noteController.clear();
                            //   controller.attachments = null;
                            // }
                          }
                          Navigator.pop(context);
                      
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
