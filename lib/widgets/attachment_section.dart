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
    this.onFilesSelected, // updated for multiple files
  });

  final String labelText;
  final String hintText;
  final String iconData;
  final Color borderColor;
  final Color fillColor;
  final Color iconColor;
  final Function(List<File>)? onFilesSelected; // updated callback

  @override
  State<AttachmentSection> createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection>
    with ImageHelper, PickerHelper {
  List<File> attachments = [];

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
          final files = await pickMultipleFiles(
            
          );
          if (files != null && files.isNotEmpty) {
            setState(() {
              attachments = files;
            });

            if (widget.onFilesSelected != null) {
              widget.onFilesSelected!(attachments);
            }
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: appSvgImage(widget.iconData, color: widget.iconColor),
            ),
            appSvgImage(AssetsHelper.line),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    8.height,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            attachments.isNotEmpty
                                ? "تم إرفاق ${attachments.length} ملف/ملفات"
                                : widget.hintText,
                            style: TextStyle(
                              color: attachments.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey.shade300,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        appSvgImage(
                          AssetsHelper.uploadeattachment,
                          height: 15.h,
                          width: 15.w,
                        ),
                      ],
                    ),
                    10.height,
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
