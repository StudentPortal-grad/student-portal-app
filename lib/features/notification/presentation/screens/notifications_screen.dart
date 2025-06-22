import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/notification/presentation/manager/notification_bloc/notification_bloc.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../widgets/notification_item_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Notifications'.make(style: Styles.font20w600),
          backgroundColor: ColorsManager.backgroundColor),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return LoadingScreen(useMainColors: true);
          }
          if (state is NotificationFailed) {
            return ErrorScreen(
              failure: Failure(message: state.message),
              onRetry: () => context.read<NotificationBloc>().add(GetNotificationsEvent()),
            );
          }
          if (state is NotificationLoaded) {
            return CustomRefreshIndicator(
              onRefresh: () async => context.read<NotificationBloc>().add(GetNotificationsEvent()),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 30.heightBox,
                    // "TODAY".make(
                    //     style: Styles.font13w400
                    //         .copyWith(color: ColorsManager.mainColor)),
                    // 20.heightBox,
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        itemBuilder: (context, index) => NotificationItemView(notification: state.notifications[index],showAvatar: false),
                        separatorBuilder: (context, index) => 10.heightBox,
                        itemCount: state.notifications.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
