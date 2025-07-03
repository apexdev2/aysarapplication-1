import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentSection extends StatefulWidget {
  const AttachmentSection({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,
    this.borderColor = const Color(0xFFD1D1D1),
    this.fillColor = Colors.white,
    this.iconColor = const Color(0xFFB6B6B6),
    this.onFilesSelected,
  });

  final String labelText;
  final String hintText;
  final String iconData;
  final Color borderColor;
  final Color fillColor;
  final Color iconColor;
  final Function(List<File>)? onFilesSelected;

  @override
  State<AttachmentSection> createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection> {
  List<File> attachments = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> showAttachmentBottomSheet() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("التقاط صورة بالكاميرا"),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    attachments = [File(pickedFile.path)];
                  });
                  widget.onFilesSelected?.call(attachments);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("اختيار من المعرض"),
              onTap: () async {
                Navigator.pop(context);
                final pickedFiles = await _picker.pickMultiImage();
                if (pickedFiles.isNotEmpty) {
                  setState(() {
                    attachments = pickedFiles.map((x) => File(x.path)).toList();
                  });
                  widget.onFilesSelected?.call(attachments);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: widget.borderColor, width: 1.0),
      ),
      child: GestureDetector(
        onTap: showAttachmentBottomSheet,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(Icons.attach_file,
                  color: widget.iconColor), // استبدال appSvgImage مؤقتًا
            ),
            const VerticalDivider(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                    const SizedBox(height: 8),
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
                          ),
                        ),
                        const Icon(Icons.upload_file, size: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
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
