import 'package:flutter/material.dart';

extension AppTextView on String {
  Widget get text => Text(this);

  Widget make({TextStyle? style}) => Text(this, style: style);
}
