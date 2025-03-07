import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/features/chats/data/model/message.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../widgets/user_chat_view.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
        child: Column(
          children: [
            _buildMessagesAppBar(),
            20.heightBox,
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  shrinkWrap: true,
                  // reverse: true,
                  itemBuilder: (context, index) => UserChatView(
                    pinned: index == 0,
                    user: User(
                        id: (index + 1).toString(), name: 'User $index'),
                    lastMessage: Message(
                        senderId: '1',
                        createdAt: DateTime.parse('12:00'),
                        content: 'Hii',
                        id: '15'),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesAppBar() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Messaging", style: Styles.font20w600),
        Spacer(),
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 17.r,
            backgroundColor: ColorsManager.lightBabyBlue,
            child: CustomImageView(
              imagePath: AssetsApp.searchIcon,
              circle: true,
              fit: BoxFit.none,
              height: 26.r,
              width: 26.r,
            ),
          ),
        ),
        20.widthBox,
        InkWell(
          onTap: () => AppRouter.router.push(AppRouter.createGroup),
          child: Tooltip(
            message: 'Create A Group',
            child: CircleAvatar(
              radius: 17.r,
              backgroundColor: ColorsManager.lightBabyBlue,
              child: Icon(
                Icons.add,
                color: ColorsManager.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
