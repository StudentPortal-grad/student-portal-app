import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/theming/colors.dart';

class DatePickerHelper {
  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? initialDate}) async {
    initialDate ??= DateTime(2000, 1, 1);

    if (Platform.isIOS) {
      return await _showCupertinoDatePicker(context, initialDate);
    } else {
      return await _showMaterialDatePicker(context, initialDate);
    }
  }

  // Material (Android) Date Picker
  static Future<DateTime?> _showMaterialDatePicker(
      BuildContext context, DateTime initialDate,
      {Color? mainColor}) async {
    return await showDatePicker(
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: mainColor ?? ColorsManager.mainColor,
          ),
        ),
        child: child!,
      ),
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
  }

  // Cupertino (iOS) Date Picker
  static Future<DateTime?> _showCupertinoDatePicker(
      BuildContext context, DateTime initialDate) async {
    DateTime? selectedDate = initialDate;

    await showModalBottomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: 250.h,
        child: Column(
          children: [
            // Done Button
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10),
              child: TextButton(
                child: Text("Done",
                    style: TextStyle(color: ColorsManager.mainColor)),
                onPressed: () => Navigator.of(context).pop(selectedDate),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                maximumDate: DateTime.now(),
                minimumDate: DateTime(1900, 1, 1),
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
    return selectedDate;
  }
}
