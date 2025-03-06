import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../theming/colors.dart';
import '../theming/text_styles.dart';

class CustomPhoneNumberInput extends StatefulWidget {
  const CustomPhoneNumberInput({
    super.key,
    this.phoneController,
    this.onInputChanged,
    this.labelText,
    this.textColor,
    this.borderColor,
    this.activeBorderColor,
    this.borderRadius = 8,
    this.filledColor,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.height,
    this.width,
    this.contentPadding,
    this.focusNode,
    this.enabled = true,
    this.onTap,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.phoneNumber,
  });

  final TextEditingController? phoneController;
  final Function(PhoneNumber)? onInputChanged;
  final String? labelText, hintText;
  final Color? textColor, borderColor, activeBorderColor, filledColor;
  final double? borderRadius, height, width;
  final TextStyle? hintStyle, labelStyle, textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final bool enabled;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final PhoneNumber? phoneNumber;

  @override
  State<CustomPhoneNumberInput> createState() => _CustomPhoneNumberInputState();
}

class _CustomPhoneNumberInputState extends State<CustomPhoneNumberInput> {
  late PhoneNumber? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _phoneNumber =
        PhoneNumber(dialCode: '20', isoCode: 'EG'); // Default country code
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.labelStyle ?? Styles.font16w500,
          ),
          6.heightBox,
        ],
        Container(
          height: widget.height ?? 50.h,
          width: widget.width,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: widget.filledColor ?? Colors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 8.r),
            border: Border.all(
              color: widget.borderColor ?? ColorsManager.lightGrayColor,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: InternationalPhoneNumberInput(

                  initialValue: _phoneNumber,
                  selectorTextStyle: widget.textStyle ??
                      Styles.font16w500.copyWith(color: widget.textColor),
                  textStyle: widget.textStyle ??
                      Styles.font16w500.copyWith(color: widget.textColor),
                  focusNode: widget.focusNode,
                  textFieldController: widget.phoneController,
                  selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      useEmoji: true,
                      trailingSpace: true,
                      // showFlags: true,
                      useBottomSheetSafeArea: true),
                  onInputChanged: widget.onInputChanged,
                  onInputValidated: (bool value) {
                    debugPrint("Phone number valid: $value");
                  },
                  onFieldSubmitted: widget.onFieldSubmitted,
                  onSaved: (PhoneNumber number) {
                    debugPrint('On Saved: $number');
                  },
                  validator: widget.validator,
                  inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText ?? "Enter phone number",
                    hintStyle: widget.hintStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff828894),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
