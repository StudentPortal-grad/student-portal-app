import 'package:flutter/material.dart';

import '../theming/colors.dart';

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({super.key, this.items = const [], this.onSelect, this.icon, this.color});

  final List<PopupMenuItem<String>> items;
  final Function(String)? onSelect;
  final Widget? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: icon ?? Icon(Icons.more_vert, color: color ?? ColorsManager.black41),
      color: ColorsManager.backgroundColorLight2,
      onSelected: onSelect,
      itemBuilder: (BuildContext context) => items,
    );
  }
}
