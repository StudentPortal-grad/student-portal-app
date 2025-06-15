import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/chats/data/model/conversation.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_image_view.dart';


class UserChatView extends StatelessWidget {
  const UserChatView({
    super.key,
    required this.conversation,
    this.pinned = false,
  });

  final bool pinned;

  final Conversation conversation;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.router.push(AppRouter.dmScreen, extra: {'conversation': conversation});
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 56.r,
            width: 56.r,
            imagePath: conversation.groupImage?.isNotEmpty ?? false
                ? conversation.groupImage!
                : conversation.participants?[0].userId?.profilePicture ?? '',
            placeHolder: kUserPlaceHolder,
            circle: true,
            fit: BoxFit.cover,
          ),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    conversation.name?.isNotEmpty ?? false
                        ? conversation.name!
                        : conversation.participants?[0].userId?.name ?? '',
                    style: Styles.font18w600.copyWith(fontWeight: FontWeight.w500),
                  ),
                  8.widthBox,
                  if (pinned)
                    Icon(
                      Icons.push_pin,
                      color: ColorsManager.mainColor,
                      size: 20.sp,
                    )
                ],
              ),
              SizedBox(
                width: 0.5.sw,
                child: Text(
                  conversation.lastMessage?.content ?? '',
                  maxLines: 1,
                  style: Styles.font12w400.copyWith(fontSize: 14.sp, color: ColorsManager.lightGrayColor),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                conversation.lastMessage?.formattedTime() ?? '',
                style: Styles.font12w400.copyWith(
                  fontSize: 10.sp,
                  color: ColorsManager.lightGrayColor,
                ),
              ),
              8.heightBox,
              _buildPinnedIcon(),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildPinnedIcon() {
    if (conversation.type == 'GroupDM') {
      return Tooltip(
        message: 'Group Chat',
        child: CircleAvatar(
          radius: 15.r,
          backgroundColor: ColorsManager.whiteColor,
          child: Icon(
            Icons.people_alt_rounded,
            color: ColorsManager.mainColorLight,
            size: 18.r,
          ),
        ),
      );
    }
    // else if (conversation.type == 'CHATBOT')
    //  return Tooltip(
    //     message: 'AI Chat',
    //     child: CircleAvatar(
    //       radius: 15.r,
    //       backgroundColor: ColorsManager.whiteColor,
    //       child: CustomImageView(
    //         // imagePath: AssetsApp.aiIcon,
    //         color: ColorsManager.mainColorLight,
    //       ),
    //     ),
    //   );
    return SizedBox.shrink();
  }
}
