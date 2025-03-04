import 'package:flutter/material.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';

class ChooseGenderButton extends StatelessWidget {
  const ChooseGenderButton({
    super.key,
    this.value,
    this.onChange,
  });

  final String? value;
  final Function(String)? onChange;
  static List<String> options = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
      hintText: 'Select Gender',
      labelText: 'Gender',
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
