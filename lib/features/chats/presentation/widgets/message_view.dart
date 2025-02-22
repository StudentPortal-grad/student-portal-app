import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/model/message.dart' as model;

class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key, required this.message});

  final model.Message message;

  @override
  Widget build(BuildContext context) {
    final self = message.from == '0'; //UserRepository.user?.id
    return Column(
      crossAxisAlignment:
          self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: ColorsManager.lightBabyBlue,
            borderRadius: self
                ? BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.reply != null) ...[_buildReply(userName: 'You', reply: message.reply!), 8.heightBox],
              if (message.files?.isNotEmpty ?? false) ...[
                CustomImageView(imagePath: message.files?[0].url),
                if (message.message?.isNotEmpty ?? false) ...[
                  10.heightBox,
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: AppText(
                      text: message.message ?? '',
                      style: Styles.font16w500
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ]
              ] else
                AppText(
                  text: message.message ?? '',
                  style:
                      Styles.font16w500.copyWith(fontWeight: FontWeight.w400),
                ),
            ],
          ),
        ),
        6.heightBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: message.createdAt ?? '',
              style: Styles.font12w400.copyWith(color: Color(0xff9E9F9F)),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildReply({String? userName, required model.Message reply}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 2,
            color: ColorsManager.mainColor,
          ),
          10.widthBox,
          Column(
            children: [
              Text(
                userName ?? '',
                style: Styles.font15w500,
              ),
              AppText(
                  text: reply.message ?? '',
                  style:
                      Styles.font16w500.copyWith(fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }
}
