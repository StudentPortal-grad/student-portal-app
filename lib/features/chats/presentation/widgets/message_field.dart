import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

class MessageField extends StatelessWidget {
  const MessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(25.r),
            child: CircleAvatar(
                radius: 25.r,
                backgroundColor: ColorsManager.lightGreyColor.withOpacity(0.2),
                child: Icon(Icons.attach_file))),
        22.widthBox,
        Expanded(
          child: CustomTextField(
            borderColor: Colors.transparent,
            controller: TextEditingController(),
            // controller: cubit.messageController,
            hintText: "Your Message",
            textInputAction: TextInputAction.done,
            onChanged: (p0) {},
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          ),
        ),
        15.widthBox,
        // if(true) CustomImageView(onTap: cubit.sendMessage, imagePath: AppImages.send),
      ],
    );
  }
}
