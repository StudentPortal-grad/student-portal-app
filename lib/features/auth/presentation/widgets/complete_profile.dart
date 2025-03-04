import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/features/auth/presentation/widgets/topic_item_view.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../domain/entities/topics.dart';
import '../manager/signup_bloc/signup_bloc.dart';
import '../manager/signup_bloc/signup_state.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  Set<String> selectedTopics = {};

  void toggleTopicSelection(String topicName) {
    setState(() {
      if (selectedTopics.contains(topicName)) {
        selectedTopics.remove(topicName);
      } else {
        selectedTopics.add(topicName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        final bloc = context.read<SignupBloc>();
        return Scaffold(
          backgroundColor: ColorsManager.mainColorLight,
          appBar: CustomAppBar(
            leadingOnTap: () =>  bloc.previousPage(),
            backgroundColor: Colors.transparent,
            leadingIconColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding:
                EdgeInsetsDirectional.only(top: 65.h, start: 20.w, end: 20.w, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Personalize your experience".make(
                    style: Styles.font22w700.copyWith(color: Colors.white)),
                3.heightBox,
                "You can customize your feed by following topics or people that interest you the most"
                    .make(
                  textAlign: TextAlign.start,
                        style: Styles.font13w400.copyWith(color: Colors.white)),
                20.heightBox,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: List.generate(
                    TopicsData.topics.length,
                    (index) => TopicItemView(
                      onTap: toggleTopicSelection,
                      topicName: TopicsData.topics[index],
                      selected: selectedTopics.contains(TopicsData.topics[index]),
                    ),
                  ),
                ),
                20.heightBox,
                Center(
                  child: CustomAppButton(
                    margin: EdgeInsets.only(top: 20.h),
                    onTap: () {
                      // if(success)
                      AppRouter.clearAndNavigate(AppRouter.homeView);
                    },
                    label: "Next",
                    textStyle: Styles.font16w700
                        .copyWith(color: ColorsManager.whiteColor),
                    width: 260.w,
                    height: 40.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
