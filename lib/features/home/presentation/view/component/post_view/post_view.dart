import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/features/home/presentation/view/component/post_view/widgets/category_tag_view.dart';
import 'package:student_portal/features/home/presentation/view/component/post_view/widgets/react_bar.dart';
import 'package:student_portal/features/home/presentation/view/component/post_view/widgets/user_post_view.dart';

import '../../../../../../core/widgets/custom_image_view.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  static List<String> dummyTags = [
    'AI',
    'Researchers',
    'Flutter',
    'Python',
    'Deep Learning',
    'Machine Learning'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserPostView(),
          21.heightBox,
          Wrap(
            spacing: 7.w,
            runSpacing: 7.h,
            children: List.generate(
              dummyTags.length,
              (index) => CategoryTagView(
                title: dummyTags[index],
              ),
            ),
          ),
          20.heightBox,
          Text('Research Methods AI', style: Styles.font14w700),
          10.heightBox,
          Text(
            'The world of AI research is vast and exciting, and there are many different types of AI research methods to choose from. Here are some of the most popular methods:',
            style: Styles.font12w400.copyWith(color: ColorsManager.grayColor),
          ),
          30.heightBox,
          Center(
            child: CustomImageView(
              imagePath:
                  'https://www.news10.com/wp-content/uploads/sites/64/2024/11/674205c2471ac7.00644903.jpeg?w=960&h=540&crop=1',
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
          17.heightBox,
          // react bar
          ReactBar(),
        ],
      ),
    );
  }
}
