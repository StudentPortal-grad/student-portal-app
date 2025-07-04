import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/features/chats/data/dto/message_dto.dart';
import 'package:student_portal/features/chats/presentation/manager/conversation_bloc/conversation_bloc.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../data/model/message.dart';
import '../widgets/message_field.dart';
import '../widgets/message_view.dart';

class DmScreen extends StatelessWidget {
  const DmScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        toolbarHeight: kToolbarHeight * 1.2,
        backgroundColor: ColorsManager.backgroundColorLight,
        title: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            final bloc = context.read<ConversationBloc>();
            return Row(
              children: [
                CustomImageView(
                  imagePath: bloc.conversation?.groupImage?.isNotEmpty ?? false
                      ? bloc.conversation?.groupImage!
                      : bloc.conversation?.getOtherParticipant?.userId?.profilePicture ?? '',
                  placeHolder: kUserPlaceHolder,
                  width: 48.r,
                  height: 48.r,
                  circle: true,
                ),
                10.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (bloc.conversation?.name?.isNotEmpty ?? false
                              ? bloc.conversation?.name!
                              : bloc.conversation?.getOtherParticipant?.userId?.name) ??
                          '',
                      style: Styles.font20w600,
                    ),
                    // Text('Online', style: Styles.font14w400.copyWith(color: Colors.green)),
                  ],
                ),
              ],
            );
          },
        ),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_rounded, color: Colors.black),
        ),
      ),
      body: BlocConsumer<ConversationBloc, ConversationState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = context.read<ConversationBloc>();

          if (state is ConversationLoading) {
            return ShimmerDmScreen();
          }

          if (state is ConversationFailed) {
            return ErrorScreen(failure: Failure(message: state.message));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => MessageItemView(message: bloc.chats[index],type: bloc.conversation?.type),
                  separatorBuilder: (BuildContext context, int index) =>
                  12.heightBox,
                  itemCount: bloc.chats.length,
                ),
              ),
              15.heightBox,
              MessageField(
                onSendTap: (value) {
                  final me = UserRepository.user;
                  final Message message = Message(
                    content: value,
                    createdAt: DateTime.now(),
                    uploading: true,
                    conversationId: bloc.conversation?.id,
                    sender: Sender(
                      id: me?.id ?? '',
                      name: me?.name ?? '',
                      profilePicture: me?.profilePicture ?? '',
                    ),
                  );
                  bloc.add(
                    SendMessageEvent(
                        message: message,
                        messageDto: MessageDto(conversationId: bloc.conversation?.id, content: value),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}


class ShimmerDmScreen extends StatelessWidget {
  const ShimmerDmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) => _buildShimmerItem(index.isEven),
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: 7,
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
  Widget _buildShimmerItem(bool self){
    return Align(
      alignment: self ? Alignment.centerRight : Alignment.centerLeft,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 220.w,
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: self
                ? BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            )
                : BorderRadius.only(
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10.h,
                width: 150.w,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              Container(
                height: 10.h,
                width: 100.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
