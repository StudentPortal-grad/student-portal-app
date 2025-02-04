import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../contestants.dart';

class ChooseGenderButton extends StatelessWidget {
  const ChooseGenderButton({
    super.key,
    required this.onChanged,
    required this.value,
    this.suffixIcon,
    this.prefixIcon,
  });

  final Function(String? value) onChanged;
  final String? value;
  final Widget? suffixIcon, prefixIcon;

  @override
  Widget build(BuildContext context) {
    log(value?? 'value is null');
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      isDense: true,
      value: value,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        filled: true,
        fillColor: const Color(0xff2C2C2E),
        hintText: "Choose Gender",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff9E9E9E),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      items: [
        'male',
        'female',
      ]
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Icon shown only in the dropdown menu
                  Icon(
                    item == 'male' ? Icons.male : Icons.female,
                    color: kMainColor,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) => onChanged(value!),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 5),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xff7E7476),
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: const Color(0xff2b2b2e),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        useSafeArea: true,
      ),
    );
  }
}
