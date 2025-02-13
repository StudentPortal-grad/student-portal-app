import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_dialog.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../core/helpers/extensions.dart';
import '../widgets/warning_dialog_body.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  noChanges() {
    return titleController.text.isEmpty && contentController.text.isEmpty;
  }

  back() {
    noChanges()
        ? AppRouter.router.pop()
        : AppDialogs.showDialog(
            context,
            alignment: AlignmentDirectional.bottomCenter,
            body: WarningDialogBody(
              iconWidget: WarningDialogBody.warmingIcon,
              onTap: () {
                pop();
                AppRouter.router.pop();
              },
              buttonTitle: 'Discard',
              mainButton: ColorsManager.mainColor,
              title: 'Unsaved changes',
              subTitle: 'Do you want to save or discard changes?',
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => back(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Text(
            'New Post',
            style: Styles.font20w600,
          ),
          leadingOnTap: () => back(),
          action: CustomImageView(
            onTap: () {
              // saving logic
              AppRouter.router.pop();
            },
            imagePath: AssetsApp.checkIcon,
            fit: BoxFit.fitWidth,
            width: 26.r,
            height: 26.r,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            spacing: 30.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: titleController,
                labelText: 'Title',
                hintText: 'Title',
              ),
              CustomTextField(
                controller: contentController,
                prefixIcon: CustomImageView(
                  imagePath: AssetsApp.search2Icon,
                  fit: BoxFit.none,
                ),
                hintText: 'Search for tags',
              ),
              CustomTextField(
                  controller: TextEditingController(),
                  labelText: 'Content',
                  hintText: 'Write the content here',
                  textInputType: TextInputType.multiline,
                  maxLines: 5),
            ],
          ),
        ),
      ),
    );
  }
}

/*
add these into post or resource
  Bold → *word*
  Italic → _word_
  Underline → ~word~
  Strikethrough → -word-
  Hashtag → #word
  Code Block → `word`
*/
