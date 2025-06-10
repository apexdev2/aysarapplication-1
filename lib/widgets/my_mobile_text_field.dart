import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/helpers/lang_controller.dart';
import 'package:aysar_app/helpers/style_controller.dart';
import 'package:aysar_app/widgets/countries.dart';
import 'package:aysar_app/widgets/my_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef MobileCallback = Function(AppIntlCountry _);

class MyMobileTextField extends StatefulWidget {
  final TextEditingController controller;
  final MobileCallback mobileCallback;
  final String? dialCode;
  final bool countriesEnabled;
  final double bottomPadding;
  final Function(String)? onSubmitted;
  final List<String>? allowedCountries;
  final Color? fillColor;
  final bool withIcon;
  final double horPadding;
  final bool hasBorder;
  final double height;
  final String? hintText;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final String? labelText;
  final bool? enabled;
  final bool? isBlack;

  final Color? textcolor;
  const MyMobileTextField({
    required this.controller,
    required this.mobileCallback,
    this.dialCode,
    this.prefixIconColor,
    this.countriesEnabled = false,
    this.bottomPadding = 0,
    this.onSubmitted,
    this.allowedCountries,
    this.fillColor,
    this.withIcon = false,
    this.horPadding = 0,
    this.hasBorder = true,
    this.height = 45,
    this.hintText,
    this.prefixIcon,
    this.labelText = "",
    super.key,
    this.enabled = true,
    this.textcolor,
    this.isBlack = true,
  });

  @override
  State<MyMobileTextField> createState() => _MyMobileTextFieldState();
}

class _MyMobileTextFieldState extends State<MyMobileTextField>
    with ImageHelper {
  late TextEditingController searchEditingController;

  late AppIntlCountry selectedCountry = allowedCountries
      .firstWhere((element) => element.dialCode == (widget.dialCode ?? '966'));

  List<AppIntlCountry> searchedCountries = [];

  List<AppIntlCountry> get countries => allowedCountries;

  List<AppIntlCountry> get allowedCountries {
    if (widget.allowedCountries == null) return intlCountriesList;

    List<AppIntlCountry> list = [];

    for (var ic in intlCountriesList) {
      for (var ac in widget.allowedCountries!) {
        if (ac == ic.dialCode) {
          int index =
              list.indexWhere((element) => element.dialCode == ic.dialCode);
          if (index == -1) {
            list.add(ic);
          }
        }
      }
    }
    return list;
  }

  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    searchEditingController = TextEditingController();
    focusNode = FocusNode()
      ..addListener(() => setState(() => isFocused = focusNode.hasFocus));
    // Future.delayed(const Duration(milliseconds: 500),
    //     () => widget.mobileCallback(selectedCountry));
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  late FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StyleGetxController>(
      builder: (styleController) {
        return Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              border: Border.all(color: const Color(0xFFD1D1D1), width: 1)),
          height: 60.h,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: widget.prefixIcon != null
                    ? appSvgImage('assets/icons/${widget.prefixIcon}',
                        color: isFocused
                            ? Theme.of(context).primaryColor
                            : widget.prefixIconColor)
                    : null,
              ),
              appSvgImage(AssetsHelper.line),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 3.h),
                  // padding: EdgeInsets.only(
                  //   bottom: widget.bottomPadding.h,
                  //   right: widget.horPadding.w,
                  //   left: widget.horPadding.w,
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          widget.labelText ?? "",
                          style: const TextStyle(
                            color: Color(0xff818181),
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      GetBuilder<LanguageGetxController>(
                        builder: (lang) => Expanded(
                          child: TextField(
                            enabled: widget.enabled ?? true,
                            focusNode: focusNode,
                            controller: widget.controller,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.grey,
                            style: _textStyle(styleController,
                                black: widget.isBlack!),
                            decoration:
                                _buildInputDecoration(styleController, lang),
                            textDirection: TextDirection.ltr,
                            onSubmitted: widget.onSubmitted,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'(^\d*\.?\d{0,2})'))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(
      StyleGetxController style, LanguageGetxController lang) {
    return InputDecoration(
      hintText: widget.hintText ?? '123 456 789',
      filled: widget.fillColor != null,
      fillColor: widget.fillColor,
      hintTextDirection: TextDirection.ltr,
      hintStyle: _textStyle(style, black: false).copyWith(fontSize: 13.sp),
      contentPadding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
      prefixIcon: _buildPrefixIcon(style, lang),
      suffixIcon: _buildSuffixIcon(style, lang),
      enabledBorder: _buildOutlineInputBorder(false),
      focusedBorder: _buildOutlineInputBorder(true),
    );
  }

  Widget? _buildPrefixIcon(
      StyleGetxController style, LanguageGetxController lang) {
    return lang.lang == 'en'
        ? Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w, end: 10.w),
            child: InkWell(
              onTap: () => showCountries(style, lang),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    '+${selectedCountry.dialCode}',
                    style: _textStyle(style, black: widget.isBlack!),
                  ),
                  8.width,
                  _flagImage(selectedCountry.code),
                ],
              ),
            ),
          )
        : _icon();
  }

  Widget? _buildSuffixIcon(
      StyleGetxController style, LanguageGetxController lang) {
    return lang.lang == 'ar'
        ? Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w, start: 5.w),
            child: InkWell(
              onTap: () => showCountries(style, lang),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "| ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  // Icon(
                  //   Icons.keyboard_arrow_down,
                  //   color: _textStyle(style, black: true).color,
                  //   size: 16.h,
                  // ),
                  1.width,
                  Text(
                    '${selectedCountry.dialCode}+',
                    style: _textStyle(style, black: widget.isBlack!),
                  ),
                  8.width,
                  _flagImage(selectedCountry.code),
                ],
              ),
            ),
          )
        : _icon();
  }

  Widget? _icon() {
    return widget.withIcon
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: appSvgImage(
              'assets/icons/mobile_icon.svg',
              color: isFocused
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor,
            ),
          )
        : null;
  }

  OutlineInputBorder _buildOutlineInputBorder(bool active) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: widget.hasBorder
          ? BorderSide(
              color: active
                  ? Theme.of(context).primaryColor
                  : const Color(0xff5D5D5D).withOpacity(0.2),
              width: 1.w,
            )
          : BorderSide.none,
    );
  }

  void showCountries(StyleGetxController style, LanguageGetxController lang) {
    if (widget.countriesEnabled) {
      setState(() => searchEditingController.clear());
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: StatefulBuilder(
              builder: (context, myState) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 18.h, width: 18.w),
                          Container(
                            width: 75.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 18.h,
                            ),
                          ),
                        ],
                      ),
                      15.height,
                      MySearchField(
                        controller: searchEditingController,
                        onChanged: (searchText) {
                          setState(() {
                            searchedCountries.clear();
                            for (int i = 0; i < countries.length; i++) {
                              if (countries[i]
                                      .name
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()) ||
                                  countries[i]
                                      .nameAr
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()) ||
                                  countries[i]
                                      .dialCode
                                      .contains(searchText.toLowerCase())) {
                                searchedCountries.add(countries[i]);
                              }
                            }
                            if (searchEditingController.text.isEmpty) {
                              searchedCountries.clear();
                            }
                          });
                          updated(myState);
                        },
                      ),
                      15.height,
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: searchedCountries.isNotEmpty ||
                                  searchEditingController.text.isNotEmpty
                              ? searchedCountries
                                  .map(
                                    (country_) => countryDetails(
                                        country_, myState, style, lang),
                                  )
                                  .toList()
                              : countries
                                  .map(
                                    (country_) => countryDetails(
                                        country_, myState, style, lang),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }

  Widget countryDetails(AppIntlCountry country, StateSetter myState,
      StyleGetxController style, LanguageGetxController lang) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: InkWell(
        onTap: () {
          setState(() => selectedCountry = country);
          updated(myState);
          Navigator.pop(context);
          widget.mobileCallback(selectedCountry);
        },
        child: Row(
          children: [
            _flagImage(country.code, width: 32),
            7.width,
            Expanded(
              child: Text(
                '+${country.dialCode}     ${lang.lang == 'ar' ? country.nameAr : country.name}',
                style: _textStyle(style, black: widget.isBlack!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(
    StyleGetxController style, {
    double fontSize = 14,
    bool black = false,
  }) {
    return TextStyle(
      color: black ? Colors.black : Colors.grey.shade400,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.normal,
    );
  }

  Widget _flagImage(String code, {double width = 30}) => Image.asset(
        'assets/flags/${code.toLowerCase()}.png',
        package: 'intl_phone_field',
        width: width.w,
      );

  Future<void> updated(StateSetter updateState) async => updateState(() {});
}
