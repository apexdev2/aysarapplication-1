import 'dart:io';
import 'package:aysar_app/api/network/local/cashe_helper.dart';
import 'package:aysar_app/utils/enms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

mixin PickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    try {
      var result = await _picker.pickImage(source: ImageSource.gallery);
      if (result == null) return null;
      return File(result.path);
    } catch (e) {
      return null;
    }
  }

  Future<List<File>> pickImages() async {
    try {
      return (await _picker.pickMultiImage()).map((e) => File(e.path)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<DateTime?> pickFullDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime.now(),
      currentDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) => _theme(context, child),
    );

    return result ?? initialDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context,
      {TimeOfDay? initialDate}) async {
    var result = await showTimePicker(
      context: context,
      initialTime: initialDate ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) => _theme(context, child),
    );

    return result ?? initialDate;
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result != null ? File(result.files.single.path!) : null;
  }

  Future<List<File>?> pickMultipleFiles() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: true,
  type: FileType.image, 
  );
  if (result != null && result.files.isNotEmpty) {
    return result.files.map((f) => File(f.path!)).toList();
  }
  return null;
}

}

Future<DateTimeRange?> pickDateRange(
  BuildContext context, {
  DateTimeRange? initialRange,
}) async {
  return await showDateRangePicker(
    saveText: "حفظ",
    switchToInputEntryModeIcon: const Icon(
      Icons.edit,
      size: 0,
      color: Colors.transparent,
    ),
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    initialDateRange: initialRange,
    locale: Locale(CacheHelper.getData(key: CacheKeys.language.name) ?? "ar"),
    builder: (BuildContext context, Widget? child) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 1.5,
                maxWidth: MediaQuery.of(context).size.width,
                minWidth: MediaQuery.of(context).size.width),
            child: _theme(context, child),
          ),
        ),
      );

      // return _theme(context, child);
    },
  );
}

MediaQuery _theme(BuildContext context, Widget? child) {
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
    child: Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          bodyLarge: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          bodyMedium: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
          bodySmall: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
          displayLarge: TextStyle(
              fontSize: 34, fontWeight: FontWeight.w900, color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
          displaySmall: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          headlineLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black),
          headlineMedium: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w500, color: Colors.black),
          headlineSmall: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
          labelLarge: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          labelMedium: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          labelSmall: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        colorScheme: ColorScheme.light(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
          secondary: Colors.grey.shade400,
        ),
        textButtonTheme: const TextButtonThemeData(

            // style: TextButton.styleFrom(backgroundColor: Colors.white),
            ),
      ),
      child: child!,
    ),
  );
}
