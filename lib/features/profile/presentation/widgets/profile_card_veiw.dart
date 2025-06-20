import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/features/profile/presentation/widgets/profile_details.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/more_options_buttons.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../manager/follow_unfollow_bloc/follow_bloc.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key, this.onPostsTap, this.user});

  final Function()? onPostsTap;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background image
        Container(
          width: 1.sw,
          height: 416.h,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.r)),
          ),
          child: CustomImageView(
            width: 1.sw,
            height: 160.h,
            imagePath: AssetsApp.backgroundProfile,
            fit: BoxFit.fill,
          ),
        ),

        // app bar
        CustomAppBar(
          backgroundColor: Colors.transparent,
          leadingIconColor: Colors.white,
          action: (user?.id == UserRepository.user?.id)
              ? null
              : MoreOptionsButton(
            color: Colors.white,
            onSelect: (value) {},
            items: [
              user?.isBlocked == true
                  ? PopupMenuItem(
                value: 'UnBlock',
                child: Text('UnBlock'),
              )
                  : PopupMenuItem(
                value: 'Block',
                child: Text('Block'),
              ),
            ],
          ),
        ),

        // profile body
        Positioned(
          top: 118.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CustomImageView(
                placeHolder: AssetsApp.userPlaceHolder,
                imagePath: user?.profilePicture ?? AssetsApp.userPlaceHolder,
                width: 85.r,
                height: 85.r,
                circle: true,
              ),
              10.heightBox,
              (user?.name ?? "Portal Student User").make(
                  style: Styles.font22w700
                      .copyWith(color: ColorsManager.textColor)),
              5.heightBox,
              if (user?.username != null)
                "@${user?.username!}".make(
                    style: Styles.font14w400
                        .copyWith(color: ColorsManager.grayColor)),
              25.heightBox,
              BlocProvider(
                create: (context) => FollowBloc(user?.isFollowed ?? false),
                child: BlocBuilder<FollowBloc, FollowState>(
                  builder: (context, state) {
                    final bloc = context.read<FollowBloc>();
                    return ProfileDetails(
                      user: user,
                      isFollowing: bloc.isFollowing ?? false,
                      onPostTap: onPostsTap,
                      onFollow: () {
                        if (bloc.isFollowing ?? false) {
                          context.read<FollowBloc>().add(UnFollowUserEvent(user?.id ?? ''));
                        } else {
                          context.read<FollowBloc>().add(FollowUserEvent(user?.id ?? ''));
                        }
                      },
                      onFollowersTap: () => AppRouter.router.push(AppRouter.followers),
                      onFollowingTap: () => AppRouter.router.push(AppRouter.followings, extra: {'userId' : user?.id}),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
