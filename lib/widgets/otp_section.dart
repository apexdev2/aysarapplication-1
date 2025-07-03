import 'dart:async';
import 'package:aysar_app/const/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpSection extends StatefulWidget {
  final TextEditingController controller;
  final Function(String _)? onSubmitted;

  const OtpSection({
    required this.controller,
    this.onSubmitted,
    super.key,
  });

  @override
  State<OtpSection> createState() => _OtpSectionState();
}

class _OtpSectionState extends State<OtpSection> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  final Color color = const Color(0xffF3F3F3);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        errorTextMargin: EdgeInsets.zero,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        pastedTextStyle: const TextStyle(
          color: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 1.w,
          borderRadius: BorderRadius.circular(10.r),
          activeColor: successColor,
          activeFillColor: color,
          selectedColor: Theme.of(context).primaryColor,
          selectedFillColor: color,
          inactiveColor: const Color(0xffDDDDE2),
          inactiveFillColor: color,
          fieldHeight: 60.h,
          fieldWidth: 65.w,
          fieldOuterPadding: EdgeInsets.zero,
        ),
        cursorColor: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          height: 1.2.h,
        ),
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        onCompleted: widget.onSubmitted,
        onChanged: (code) {},
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
