import 'dart:io';

import 'package:aysar_app/extensions/sized_box_extension.dart';
import 'package:aysar_app/helpers/assets_helper.dart';
import 'package:aysar_app/helpers/image_helper.dart';
import 'package:aysar_app/helpers/picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentSection extends StatefulWidget {
  const AttachmentSection({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,

    this.borderColor = const Color(0xFFD1D1D1),
    this.fillColor = Colors.white,
    this.iconColor = const Color(0xFFB6B6B6),
    this.onFileSelected, // Add callback parameter
  });
  final String labelText;
  final String hintText;
  final String iconData;
  final Color borderColor;
  final Color fillColor;
  final Color iconColor;



  final Function(File?)? onFileSelected; // Declare callback
  @override
  State<AttachmentSection> createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection>
    with ImageHelper, PickerHelper {
  File? attachment;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: widget.borderColor,
          width: 1.0,
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          var file = await pickFile();
          if (file != null) {
            setState(() {
              attachment = file;
            });
          }
          // Call the callback function with the selected file
          if (widget.onFileSelected != null) {
             widget.onFileSelected!(file);
          }
        },
        child: Row(
          children: [
            // Icon on the right side (for Arabic layout)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: appSvgImage(widget.iconData, color: widget.iconColor),
            ),
            appSvgImage(AssetsHelper.line),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label Text
                    Text(
                      widget.labelText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign
                          .right, // Align text to right for Arabic layout
                    ),
                    8.height,
                    // hint Text Field
                    Row(
                      children: [
                        Text(
                          attachment != null ? "تم ارفاق ملف" : widget.hintText,
                          style: TextStyle(
                            color: attachment != null
                                ? Colors.black
                                : Colors.grey.shade300,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign
                              .right, // Align text to right for Arabic layout
                        ),
                        const Spacer(),
                        appSvgImage(AssetsHelper.uploadeattachment,
                            height: 15.h, width: 15.w)
                      ],
                    ),
                    10.height
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
