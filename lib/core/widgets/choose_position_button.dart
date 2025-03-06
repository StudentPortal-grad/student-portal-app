import 'package:flutter/material.dart';

import '../theming/text_styles.dart';
import 'custom_dropdown_button.dart';

class ChoosePositionButton extends StatelessWidget {
  const ChoosePositionButton({super.key, this.value, this.onChange});

  final String? value;
  final Function(String)? onChange;
  static List<String> options = [
    'Student',
    'Faculty',
    'Admin',
    // 'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
      validator: (p0) {
        if (p0 == null || p0.isEmpty) {
          return 'Please select a position';
        }
        return null;
      },
      hintText: 'Select Position',
      labelText: 'Position',
      labelStyle: Styles.font14w500,
      value: value,
      items: List.generate(
        options.length,
        (index) => DropdownMenuItem(
          value: options[index].toLowerCase(),
          child: Text(options[index]),
        ),
      ),
      onChanged: (p0) {
        if (onChange != null) {
          onChange!(p0 ?? '');
        }
      },
    );
  }
}
