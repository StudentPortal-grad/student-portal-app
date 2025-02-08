import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.iconData,
    this.showSuffixIcon = false,
    this.onSuffixIconTap,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.elevation,
    this.hintStyle,
    this.onChanged,
    this.borderColor,
    this.prefixIcon,
    this.activeBorderColor,
    this.borderRadius = 8,
    this.contentPadding,
    this.suffix,
    this.filledColor,
    this.errorText,
    this.labelText,
    this.labelStyle,
    this.enabled = true,
    this.textStyle,
    this.onTap,
    this.showCursor = true,
    this.height,
    this.width,
    this.maxLines,
    this.expanded = false,
  });

  final TextEditingController controller;
  final Function()? onSuffixIconTap, onTap;
  final Function(dynamic value)? validator, onChanged;
  final String? hintText, labelText;
  final IconData? iconData;
  final bool showSuffixIcon, showCursor;
  final TextInputType textInputType;
  final bool obscureText, enabled, expanded;
  final double? elevation, borderRadius, height, width;
  final TextStyle? hintStyle, labelStyle, textStyle;
  final Color? filledColor, borderColor, activeBorderColor;
  final Widget? prefixIcon, suffix;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;
  final int? maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText ?? '',
            style: TextStyle(
              color: Color(0xff414651),
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 6.h),
        ],
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            scrollPadding: EdgeInsets.zero,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            maxLines: widget.maxLines ?? (_obscureText ? 1 : null),
            expands: widget.expanded,
            obscureText: _obscureText,
            obscuringCharacter: '*',
            controller: widget.controller,
            showCursor: widget.showCursor,
            style: widget.textStyle,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: widget.textInputType,
            enabled: widget.enabled,
            validator: (value) => widget.validator!(value),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              errorText: widget.errorText,
              contentPadding: widget.contentPadding,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.textInputType == TextInputType.visiblePassword
                  ? IconButton(
                      icon: Icon(
                        (_obscureText)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xffA4A7AE),
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : widget.suffix,
              isDense: true,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent  ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.activeBorderColor ?? ColorsManager.mainColor),
              ),
              prefix: const SizedBox(width: 8),

              fillColor: widget.filledColor,
              filled: widget.filledColor != null,
              hoverColor: Theme.of(context).primaryColor,
              hintText: widget.hintText,
              // labelText: widget.labelText,
              // labelStyle: widget.labelStyle ??
              //     TextStyle(
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w400,
              //       color: const Color(0xff828894),
              //     ),
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
    );
  }
}
