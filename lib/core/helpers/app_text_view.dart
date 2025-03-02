import 'package:flutter/material.dart';

extension AppTextView on String {
  Widget get text => Text(this);

  Widget make({TextStyle? style, TextAlign? textAlign}) => Text(this, style: style, textAlign: textAlign ?? TextAlign.center,);
}
