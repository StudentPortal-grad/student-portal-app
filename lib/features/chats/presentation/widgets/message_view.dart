import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/get_color_from_id.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../home/data/model/post_model/attachment.dart' show Attachment;
import '../../../home/presentation/pages/image_post_screen.dart';
import '../../../resource/presentation/widgets/pdf_post_view.dart';
import '../../data/model/message.dart' as model;

class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key, required this.message, this.type});

  final String? type;
  final model.Message message;

  @override
  Widget build(BuildContext context) {
    final self = message.sender?.id == UserRepository.user?.id;
    return Column(
      crossAxisAlignment: self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!self && type == 'GroupDM')
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              message.sender?.name ?? '',
              style: Styles.font15w500.copyWith(
                color: getColorFromId(message.sender?.id ?? ''),
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: self ? ColorsManager.lightBabyBlue : ColorsManager.lightBlue,
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
              // if (message.reply != null) ...[_buildReply(userName: 'You', reply: message.reply!), 8.heightBox],
              if (message.attachments?.isNotEmpty ?? false)
                _buildAttachedView()
                else
                AppText(
                  text: message.content ?? '',
                  style: Styles.font16w500.copyWith(fontWeight: FontWeight.w400),
                ),
            ],
          ),
        ),
        6.heightBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: (message.formattedTime()),
              style: Styles.font12w400.copyWith(color: Color(0xff9E9F9F)),
            ),
            if (message.uploading && self) ...[
              6.widthBox,
              SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  color: ColorsManager.mainColor,
                  strokeWidth: 2,
                ),
              ),
          ],
        ],
        )
      ],
    );
  }

// ignore: unused_element
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
                  text: reply.content ?? '',
                  style: Styles.font16w500.copyWith(fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAttachedView() {
    return Column(children: [
      SizedBox(
        width: 0.6.sw,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if(message.attachments?[index].type == 'file') {
              return PdfPostView(
                title: '${message.attachments?[index].fileName}',
                url: message.attachments?[index].url ?? '',
                size: message.attachments?[index].fileSize,
              );
            }
            return CustomImageView(
              height: 150.h,
              imagePath: message.attachments?[index].url ?? '',
              onTap: () {
                push(
                  ImagePostView(
                    id: 0,
                    title: '',
                    attachment: Attachment(
                      resource: message.attachments?[index].url ?? '',
                      type: 'image',
                    ),
                  ),
                );
              },
            );
          },
          itemCount: message.attachments?.length ?? 0,
        ),
      ),
      if (message.content?.isNotEmpty ?? false) ...[
        10.heightBox,
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: AppText(
            text: message.content ?? '',
            style: Styles.font16w500
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ]
    ]);
  }
}
