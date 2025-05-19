import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/compamies/company_card.dart';
import 'package:aysar_app/modules/compamies/company_getxcontroller.dart';
import 'package:aysar_app/utils/warnings/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompaniesScreen extends StatelessWidget with ImageHelper {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "الشركات",
          // "appLocale.companies",
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CompanyGetxcontroller>(
          builder: (controller) => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.companies.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () => controller.getCompanies(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 20.h,
                          horizontal: 16.w,
                        ),
                        itemBuilder: (context, index) =>
                            CompanyCard(company: controller.companies[index]),
                        separatorBuilder: (context, index) => 15.height,
                        itemCount: controller.companies.length,
                      ),
                    )
                  : const NoData()),
    );
  }
}
