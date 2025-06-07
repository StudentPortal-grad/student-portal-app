
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_dropdown_button.dart';

class SelectVisibility extends StatelessWidget {
  const SelectVisibility({super.key, this.value, this.onChange});

  final String? value;
  final Function(String)? onChange;
  static List<String> visibilities = ['Public', 'Friends', 'Only Me'];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
      hintText: 'Select visibility',
      value: value,
      items: List.generate(
        visibilities.length,
        (index) => DropdownMenuItem(
          value: visibilities[index].toLowerCase(),
          child: Text(visibilities[index]),
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
