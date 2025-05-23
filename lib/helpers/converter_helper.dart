
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

mixin ConverterHelper {
  String? convertDateTimeToStringTime({
    required DateTime? dateTime,
    String? placeholder,
    String? format,
  }) {
    if (dateTime == null) return placeholder;
    DateFormat dateFormat = DateFormat(format ?? 'yyyy/MM/dd');
    return dateFormat.format(dateTime);
  }

  String? convertDateTimeToStringTimeForfilter({
    required DateTime? dateTime,
    String? placeholder,
    String? format,
  }) {
    if (dateTime == null) return placeholder;
    DateFormat dateFormat = DateFormat(format ?? 'yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  DateTime? convertStringTimeToDateTime({
    required String? time,
    DateTime? placeholder,
    String format = 'yyyy-MM-dd',
  }) {
    if (time == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(time);
  }

  String? convertTimeOfDayToStringTime({
    required TimeOfDay? timeOfDay,
    String? placeholder,
  }) {
    if (timeOfDay == null) return placeholder;
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final min = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  TimeOfDay? convertStringTimeToTimeOfDay({
    required String? time,
    String format = 'HH:mm',
  }) {
    if (time == null) return null;
    return TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );
  }
  /// Formats ISO 8601 date string to a readable format like "dd-MM-yyyy"
  String formatIsoDate(String isoDateString, {String pattern = 'dd-MM-yyyy'}) {
    try {
      final parsedDate = DateTime.parse(isoDateString);
      return DateFormat(pattern).format(parsedDate.toLocal());
    } catch (e) {
      return 'Invalid date';
    }
  }
  String? cutDialFromMobile({
    required String? mobile,
    required String? dial,
  }) {
    try {
      if (mobile == null || dial == null) return null;
      return mobile.replaceFirst(dial, '');
    } catch (e) {
      return null;
    }
  }

  // LatLng? cutLatLngFromLocationUrl(String? url) {
  //   try {
  //     if (url == null) return null;

  //     String key = 'query=';
  //     String _ = url;
  //     int index = _.indexOf(key);
  //     _ = _.substring(index + key.length);

  //     index = _.indexOf('&');
  //     _ = _.substring(0, index);

  //     List<String> list = _.split('%2C');

  //     String lat = list[0];
  //     String lng = list[1];
  //     return LatLng(double.parse(lat), double.parse(lng));
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // int getDayNumberFromDateTime(DateTime dateTime) {
  //   String day =
  //       Jiffy.parseFromDateTime(dateTime).format(pattern: 'EEEE').toLowerCase();

  //   switch (day) {
  //     case 'saturday':
  //       return 7;
  //     case 'sunday':
  //       return 1;
  //     case 'monday':
  //       return 2;
  //     case 'tuesday':
  //       return 3;
  //     case 'wednesday':
  //       return 4;
  //     case 'thursday':
  //       return 5;
  //     case 'friday':
  //       return 6;
  //   }
  //   return -1;
  // }

  String? cutTimeToMinuteSecondOnly(String? time) {
    if (time == null) return null;
    return time.length == 8 ? time.substring(0, 5) : time;
  }

  String? convertDateRangeToStringTime({
    required DateTimeRange? date,
    String? placeholder,
    String format = 'yyyy/MM/dd',
  }) {
    if (date == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    String from = dateFormat.format(date.start);
    String to = dateFormat.format(date.end);
    return '$from - $to';
  }

  String? convertDateRangeToStringTimeforFilter({
    required DateTimeRange? date,
    String? placeholder,
    String format = 'yyyy-MM-dd',
  }) {
    if (date == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    String from = dateFormat.format(date.start);
    String to = dateFormat.format(date.end);
    return '$from / $to';
  }

  String convertToListOfNames(List<dynamic> list, {String? prefix}) {
    try {
      String text = '';
      if (prefix != null) {
        text += '$prefix ';
      }
      for (int i = 0; i < list.length; i++) {
        text += (list[i].name ?? '');
        if (i != (list.length - 1)) {
          text += ' , ';
        }
      }

      return text;
    } catch (e) {
      return '';
    }
  }

  dynamic itemIndexInList(dynamic item, List<dynamic> list) {
    try {
      dynamic ofIndex = list.indexOf(item);
      if (ofIndex == -1) {
        dynamic atIndex = list.indexWhere((element) => element.id == item.id);
        return atIndex;
      } else {
        return ofIndex;
      }
    } catch (e) {
      return -1;
    }
  }
}
