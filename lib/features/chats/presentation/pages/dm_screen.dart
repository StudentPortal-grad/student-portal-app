import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../widgets/message_field.dart';
import '../widgets/message_view.dart';
import '../../data/model/message.dart' as model;

class DmScreen extends StatelessWidget {
  const DmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        toolbarHeight: kToolbarHeight * 1.2,
        backgroundColor: ColorsManager.backgroundColorLight,
        title: Row(
          children: [
            CustomImageView(
              imagePath: kUserImage,
              width: 48.r,
              height: 48.r,
              circle: true,
            ),
            10.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mina Zarif', style: Styles.font20w600),
                Text('Online', style: Styles.font14w400.copyWith(color: Colors.green)),
              ],
            ),
          ],
        ),
        action: IconButton(onPressed: (){},icon: Icon(Icons.more_vert_rounded,color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (c, i) =>
                  MessageItemView(message: model.Message.dummyData()[i]),
              separatorBuilder: (BuildContext context, int index) =>
                  12.heightBox,
              itemCount: model.Message.dummyData().length,
            ),
          ),
          15.heightBox,
          MessageField(),
          15.heightBox,
        ],
      ),
    );
  }
}
