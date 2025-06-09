
import 'package:aysar_app/helpers/style_controller.dart';
import 'package:aysar_app/helpers/styles_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MySearchField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final bool filled;

  const MySearchField({
    required this.controller,
    required this.onChanged,
    this.filled = false,
    this.onSubmitted,
    super.key,
  });

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> with StylesHelper {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StyleGetxController>(
      builder: (styleController) {
        return Container(
          height: 40.h,
          decoration: BoxDecoration(
              boxShadow: widget.filled ? [appBoxShadow(context)] : null),
          child: TextField(
            onSubmitted: widget.onSubmitted,
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.withOpacity(0.4),
                size: 20.w,
              ),
              hintText: "search",
              hintStyle: TextStyle(
                color: const Color(0xff5D5D5D).withOpacity(0.2),
                fontSize: 14.sp,
                height: 1.h,
              ),
              enabledBorder: buildOutlineInputBorder(
                  const Color(0xff5D5D5D).withOpacity(0.2)),
              focusedBorder:
                  buildOutlineInputBorder(Theme.of(context).primaryColor),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(
        color: widget.filled ? Colors.transparent : color,
        width: 1.w,
      ),
    );
  }
}
