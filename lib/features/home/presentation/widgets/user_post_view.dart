import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/resource/data/model/resource.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/more_options_buttons.dart';

class UserPostView extends StatelessWidget {
  const UserPostView({super.key, this.uploader, this.createFromAgo, this.onSelect});

  final Uploader? uploader;
  final String? createFromAgo;
  final Function(String?)? onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.router.push(
          AppRouter.profile,
          extra: {'userId': uploader?.id},
        );
      },
      child: Row(
        children: [
          CustomImageView(
            imagePath: uploader?.profilePicture ?? '',
            placeHolder: kUserPlaceHolder,
            circle: true,
            height: 38.r,
            width: 38.r,
          ),
          8.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(uploader?.name ?? '', style: Styles.font14w700),
              3.heightBox,
              Text(createFromAgo ?? '',
                  style:
                      Styles.font12w400.copyWith(color: ColorsManager.grayColor)),
            ],
          ),
          Spacer(),
          MoreOptionsButton(
            onSelect: onSelect,
            items: [
              if (uploader?.id == UserRepository.user?.id)
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                )
              else
                PopupMenuItem(
                  value: 'report',
                  child: Text('Report'),
                )
            ],
          ),
        ],
      ),
    );
  }
}
