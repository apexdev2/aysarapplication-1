import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/modules/shareed/shareed_getxcontroller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeImageSlider extends StatefulWidget {
  const HomeImageSlider({super.key});

  @override
  _HomeImageSliderState createState() => _HomeImageSliderState();
}

class _HomeImageSliderState extends State<HomeImageSlider> with ImageHelper {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  ShareedGetxcontroller shareedGetxcontroller = Get.find();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 160.h,
            autoPlay: false,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: shareedGetxcontroller.sliderImages
              .map(
                (item) => buildImageSliderItem(item.image ?? "", context),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0.h,
          left: 0,
          right: 0,
          child: buildIndicator(),
        ),
      ],
    );
  }

  Widget buildImageSliderItem(String image, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 160.h,
      child: appCachedImage(image, fit: BoxFit.cover),
    );
  }

  // Build the circle indicator
  Widget buildIndicator() {
    final itemCount = shareedGetxcontroller.sliderImages.length;

    if (itemCount == 0) {
      return const SizedBox(); // أو return Container();
    }
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: _current,
        count: shareedGetxcontroller.sliderImages.length,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: Theme.of(context).primaryColor,
          dotColor: Colors.grey.shade300,
        ),
        onDotClicked: (index) {
          _carouselController.animateToPage(index);
        },
      ),
    );
  }
}
