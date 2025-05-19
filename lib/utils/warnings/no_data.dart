import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoData extends StatefulWidget {
  final String? text;
  final String? icon;
  final double? iconHeight;
  final double? fontSize;

  const NoData({
    this.text,
    this.icon,
    this.iconHeight,
    this.fontSize,
    super.key,
  });

  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> with ImageHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appSvgImage(
            'assets/icons/${widget.icon ?? 'defaulticon.svg'}',
            height: (widget.iconHeight ?? 50).h,
            color: Theme.of(context).primaryColor,
          ),
          20.height,
          Text(
            widget.text ?? appLocale.noData,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: (widget.fontSize ?? 18).sp,
            ),
          ),
        ],
      ),
    );
  }
}
