
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../manager/chats_bloc/chats_bloc.dart';
import '../widgets/user_chat_view.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
        child: BlocProvider(
          create: (context) => ChatsBloc()..add(StartListeningToConversations()),
          child: BlocBuilder<ChatsBloc, ChatsState>(
            builder: (context, state) {
              if (state is ChatsStreamUpdated) {
                return Column(
                  children: [
                    _buildMessagesAppBar(),
                    20.heightBox,
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => UserChatView(
                              user: state.conversations[index].participants?[0]
                                      .userId ??
                                  User(),
                              lastMessage:
                                  state.conversations[index].lastMessage),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: state.conversations.length,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const Center(child: CustomLoadingIndicator());
            },
          ),
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
