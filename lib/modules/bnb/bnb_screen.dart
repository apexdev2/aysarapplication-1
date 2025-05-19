import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aysar_app/modules/bnb/bnb_controller.dart';
import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/modules/home/home_screen.dart';
import 'package:aysar_app/modules/maintenance_requests/maintenance_requests_screen.dart';
import 'package:aysar_app/modules/my_account/my_account_screen.dart';
import 'package:aysar_app/modules/my_real_estate/my_properties_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  // Define icons for the bottom navigation

  // List of screens to navigate to
  final List<Widget> _screens = [
    const HomeScreen(),
    MaintenanceRequestsScreen(),
    MrPropertiesScreen(),
    MyAccountScreen(),
  ];
  final svgIconPaths = <String>[
    AssetsHelper.nav1,
    AssetsHelper.nav2,
    AssetsHelper.nav3,
    AssetsHelper.nav4,
  ];

  List<String> titles = <String>[];
  @override
  void initState() {
    // Get.find<ProfileGetxController>().getMyProfile();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize titles here
    titles = [
      appLocale.home,
      appLocale.orders,
      appLocale.properties,
      appLocale.myaccount,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BnbController>(
      builder: (controller) => Scaffold(
        body: _screens[controller.currentIndex], // Display the current screen

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: AnimatedBottomNavigationBar.builder(
            gapWidth: 10.w,
            height: 74.h,
            itemCount: svgIconPaths.length, // Number of items
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Theme.of(context).primaryColor : null;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svgIconPaths[index],
                      color:
                          color, // Change color based on whether it's active or not
                      height: 24.h, // Adjust size as needed
                      width: 24.w,
                    ),
                    3.height,
                    Text(
                      titles[index],
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : const Color(0xffD8D8D8)),
                    )
                  ],
                ),
              );
            },
            activeIndex: controller.currentIndex,
            backgroundColor: Colors.white,
            onTap: (index) => setState(
                () => controller.currentIndex = index), // Switch screen
          ),
        ),
      ),
    );
  }
}
