import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class FileAttachmentItem extends StatelessWidget {
  final String fileName;
  final VoidCallback onDelete;

  const FileAttachmentItem({
    super.key,
    required this.fileName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF), // Background color
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'File "${fileName.trim().split('/').last}" Attached',
              // 'File "${fileName.split('/').last}" Attached',
              style: Styles.font15w600.copyWith(
                fontSize: 12.sp,
                color: ColorsManager.mainColorDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onDelete,
            child: Icon(
              Icons.delete,
              color: Colors.red,
              size: 20.r,
            ),
          ),
        ],
      ),
    );
  }
}