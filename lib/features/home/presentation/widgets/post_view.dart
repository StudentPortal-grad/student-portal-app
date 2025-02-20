import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/text_parser.dart';
import 'package:student_portal/features/home/presentation/widgets/category_tag_view.dart';
import 'package:student_portal/features/home/presentation/widgets/pdf_post_view.dart';
import 'package:student_portal/features/home/presentation/widgets/post_list_images_view.dart';
import 'package:student_portal/features/home/presentation/widgets/react_bar.dart';
import 'package:student_portal/features/home/presentation/widgets/user_post_view.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.id, this.detailsChildren});

  final int id;
  final List<Widget>? detailsChildren;
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 7,
            blurStyle: BlurStyle.outer,
          ),
        ],
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
          TextParser(
            onHashTagTap: (p0) {
              print('HASH TAG');
              print(p0);
            },
            onMentionTap: (p0) {
              print('on Mention');
              print(p0);
            },
            text:
                'The world of @AI research is vast and exciting, and there are many different types of #AI research methods to choose from. Here are some of the most popular methods:',
            style: Styles.font12w400
                .copyWith(color: ColorsManager.grayColor, height: 1.9),
          ),
          30.heightBox,

          (id == 0) ? PostListImagesView() : PdfPostView(),

          17.heightBox,
          // react bar
          ReactBar(),
          if (detailsChildren != null) ...[
            17.heightBox,
            ...detailsChildren!,
          ]
        ],
      ),
    );
  }
}
