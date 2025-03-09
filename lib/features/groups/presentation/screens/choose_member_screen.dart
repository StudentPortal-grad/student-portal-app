import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';
import 'package:student_portal/features/groups/presentation/widgets/member_item_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';

class ChooseMemberScreen extends StatelessWidget {
  const ChooseMemberScreen({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Text(title ?? 'New Group', style: Styles.font20w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.heightBox,
            SizedBox(
              height: 30.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryTagView(
                  index: index,
                  title: 'Mina',
                  removeTap: (p0) {},
                  backGround: ColorsManager.babyBlue,
                  textColor: Color(0xff1849A9),
                  borderColor: Color(0xff84CAFF),
                ),
                shrinkWrap: true,
                separatorBuilder: (context, index) => 10.widthBox,
                itemCount: 5,
              ),
            ),
            20.heightBox,
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: CustomImageView(
                  imagePath: AssetsApp.search2Icon, fit: BoxFit.none),
              hintText: 'Search',
            ),
            20.heightBox,
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => 15.heightBox,
                itemBuilder: (context, index) => MemberItemView(
                  user: User(name: 'Mina'),
                  showRemoveIcon: false,
                  showIsMemberSelected: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
