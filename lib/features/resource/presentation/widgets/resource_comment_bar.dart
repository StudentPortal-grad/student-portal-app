import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../home/data/dto/reply_dto.dart';
import '../manager/resource_details_bloc/resource_details_bloc.dart';

class ResourceCommentBar extends StatefulWidget {
  const ResourceCommentBar({super.key, this.initComment});

  final String? initComment;

  @override
  State<ResourceCommentBar> createState() => _ResourceCommentBarState();
}

class _ResourceCommentBarState extends State<ResourceCommentBar> {
  late final TextEditingController commentController;
  bool isEmpty = true;

  @override
  void initState() {
    commentController = TextEditingController(text: widget.initComment ?? '');
    commentController.addListener(() {
      setState(() {
        isEmpty = commentController.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    commentController.removeListener(() {});
    commentController.dispose();
    super.dispose();
  }

  onSuccess() {
    commentController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ResourceDetailsBloc>();

    return BlocListener<ResourceDetailsBloc, ResourceDetailsState>(
      listener: (context, state) {
        if (state is AddCommentSuccessState) {
          onSuccess();
          CustomToast(context).showSuccessToast(message: state.message);
        }
        if (state is AddCommentErrorState) {
          CustomToast(context).showErrorToast(message: state.message);
        }
      },
      child: Row(
        children: [
          CustomImageView(
            imagePath: UserRepository.user?.profilePicture,
            circle: true,
            height: 38.r,
            width: 38.r,
          ),
          8.widthBox,
          Expanded(
            child: CustomTextField(
              height: 38.h,
              controller: commentController,
              suffix: isEmpty
                  ? null
                  : bloc.state is AddCommentLoadingState
                      ? CustomLoadingIndicator()
                      : InkWell(
                          onTap: () {
                            bloc.add(
                              CommentResourceEvent(
                                replyDto: ReplyDto(
                                  id: bloc.resource.id ?? '',
                                  content: commentController.text,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.send_rounded,
                            color: ColorsManager.mainColor,
                            size: 20.sp,
                          ),
                        ),
              hintText: 'Comment',
              expanded: true,
              textInputType: TextInputType.multiline,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            ),
          ),
        ],
      ),
    );
  }
}
