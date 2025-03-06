import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../theming/colors.dart';
import '../theming/text_styles.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.labelText,
    this.labelIcon,
    this.validator,
    this.borderColor,
    this.activeBorderColor,
    this.filledColor,
    this.borderRadius = 8,
    this.contentPadding,
    this.prefixIcon,
    this.suffix,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.errorText,
    this.height,
    this.width,
    this.enabled = true,
    this.focusNode,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?) onChanged;
  final String? hintText, labelText, errorText;
  final Widget? labelIcon, prefixIcon, suffix;
  final Function(T?)? validator;
  final Color? borderColor, activeBorderColor, filledColor;
  final double? borderRadius, height, width;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle, labelStyle, textStyle;
  final bool enabled;
  final FocusNode? focusNode;

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText ?? '',
                style: widget.labelStyle ??
                    Styles.font18w600.copyWith(fontWeight: FontWeight.w700),
              ),
              widget.labelIcon ?? SizedBox.shrink(),
            ],
          ),
          10.heightBox,
        ],
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: DropdownButtonFormField2<T>(
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            value: widget.value,
            items: widget.items,
            onChanged: widget.enabled ? widget.onChanged : null,
            validator: (value) =>
                widget.validator != null ? widget.validator!(value) : null,
            focusNode: widget.focusNode,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xff7E7476),
              ),
              iconSize: 24,
            ),
            hint: Text(
              widget.hintText ?? '',
              style: widget.hintStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: const Color(0xff828894),
                  ),
            ),
            decoration: InputDecoration(
              errorText: widget.errorText,
              contentPadding: widget.contentPadding,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffix,
              isDense: true,
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorsManager.lightGrayColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(
                    color: widget.activeBorderColor ?? ColorsManager.mainColor),
              ),
              fillColor: widget.filledColor,
              filled: widget.filledColor != null,
              hoverColor: ColorsManager.mainColor,
            ),
            style: widget.textStyle ??
                Styles.font16w500.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
