import 'package:flutter/material.dart';
import '../../contestants.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key, required this.value, required this.onTap});

  final bool value;
  final Function(bool value) onTap;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onTap(_value);
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 20.83,
        height: 20.83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: (_value) ? kMainColor : const Color(0xff404040),
        ),
        child: const Icon(
          Icons.check,
          size: 15,
          color: kBackgroundColor,
        ),
      ),
    );
  }
}
