import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import '../../../../core/errors/view/error_screen.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../manager/chats_bloc/chats_bloc.dart';
import '../widgets/user_chat_view.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
        child: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            if (state is ChatsLoading) {
              return const Center(child: LoadingScreen(useMainColors: true));
            }
            if (state is ChatsError) {
              return ErrorScreen(
                failure: Failure(message: state.message),
                onRetry: () async => BlocProvider.of<ChatsBloc>(context).add(StartListeningToConversations()),
              );
            }
            if (state is ChatsStreamUpdated) {
              if (state.conversations.isEmpty) {
                return const Center(child: Text("No Conversations"));
              }
              return Column(
                children: [
                  _buildMessagesAppBar(),
                  20.heightBox,
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => UserChatView(conversation: state.conversations[index]),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.conversations.length,
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
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
          onTap: () => AppRouter.router.push(AppRouter.searchPeer),
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
