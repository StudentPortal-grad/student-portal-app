import 'package:flutter/material.dart';

import '../theming/text_styles.dart';
import 'custom_dropdown_button.dart';

class ChoosePositionButton extends StatelessWidget {
  const ChoosePositionButton({super.key, this.value, this.onChange});

  final String? value;
  final Function(String)? onChange;
  static List<String> options = [
    'students',
    'professors',
    'graduates',
    'other'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
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
