import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_dropdown_button.dart';


class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key, this.value, this.onChange});

  final String? value;
  final Function(String)? onChange;
  static List<String> categories = [
    'Mobile Development',
    'Backed Development',
    'Data Science',
    'Web Development',
    'UI/UX Design',
    'Software Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
      hintText: 'Select Category',
      value: value,
      items: List.generate(
        categories.length,
        (index) => DropdownMenuItem(
          value: categories[index].toLowerCase(),
          child: Text(categories[index]),
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
