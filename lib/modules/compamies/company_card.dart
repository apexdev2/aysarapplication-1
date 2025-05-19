import 'package:aysar_app/app/app_routs.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/models/company_model.dart';
import 'package:aysar_app/modules/compamies/company_getxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CompanyCard extends StatelessWidget with ImageHelper {
  final CompanyModel company;

  const CompanyCard({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Get.find<CompanyGetxcontroller>().getCompaniesDetails(id: company.id!);
        Get.toNamed(Routes.companyDetailsScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        // height: 91.h,
        // margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Company Logo
            Container(
              width: 70.w,
              height: 70.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: appCachedImage(
                    company.image,
                    fit: BoxFit.cover,
                  )),
            ),
            10.width,
            // Company Information (RTL)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Name
                  Text(
                    company.companyName ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.height,
                  // Email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.email,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      8.width,
                      Text(
                        company.email ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  5.height,
                  // Phone Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      8.width,
                      Text(
                        company.mobile ?? "",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),

                      // More Button
                      Text(
                        appLocale.more,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // 4.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
