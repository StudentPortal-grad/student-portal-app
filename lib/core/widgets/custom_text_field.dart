import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../theming/colors.dart';
import '../theming/text_styles.dart';

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
    this.labelIcon,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted, this.inputFormatters,
  });

  final TextEditingController controller;
  final Function()? onSuffixIconTap, onTap;
  final String? Function(String)? validator;
  final Function(dynamic value)? onChanged;
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
  final Widget? labelIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText ?? '',
                style: widget.labelStyle ?? Styles.font16w500,
              ),
              widget.labelIcon ?? SizedBox.shrink(),
            ],
          ),
          6.heightBox,
        ],
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            scrollPadding: EdgeInsets.zero,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
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
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(value ?? "");
              }
              return null;
            },
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              errorText: widget.errorText,
              contentPadding: widget.contentPadding,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: BoxConstraints.tight(Size(30.r, 25.r)),
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
               suffixIconConstraints: BoxConstraints.tight(Size(40.r, 25.r)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.borderColor ?? ColorsManager.lightGrayColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0),
                borderSide: BorderSide(color: widget.activeBorderColor ?? ColorsManager.mainColor),
              ),
              fillColor: widget.filledColor,
              filled: widget.filledColor != null,
              hoverColor: Theme.of(context).primaryColor,
              hintText: widget.hintText,
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
