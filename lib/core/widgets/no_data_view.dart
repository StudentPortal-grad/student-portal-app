import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 0.4.sh),
        Center(child: Text(text)),
      ],
    );
  }
}
