import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_dialog.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/file_service.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../post/presentation/widgets/file_attachment_item.dart';
import '../../../../post/presentation/widgets/search_for_tags.dart';
import '../../../../post/presentation/widgets/upload_button.dart';
import '../../../../post/presentation/widgets/warning_dialog_body.dart';
import '../widgets/select_category.dart';
import '../widgets/select_visibility.dart';

class AddResourcesScreen extends StatefulWidget {
  const AddResourcesScreen({super.key});

  @override
  State<AddResourcesScreen> createState() => _AddResourcesScreenState();
}

class _AddResourcesScreenState extends State<AddResourcesScreen> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  String? category;
  String? visibility;
  List<String> paths = [];

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
    paths.clear();
    super.dispose();
  }

  noChanges() {
    return titleController.text.isEmpty && contentController.text.isEmpty && paths.isEmpty;
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
                pop();
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop == false) back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Text(
            'Upload Resource',
            style: Styles.font20w600,
          ),
          leadingOnTap: () => back(),
          action: CustomImageView(
            onTap: () {
              // TODO: saving logic
              AppRouter.router.pop();
            },
            imagePath: AssetsApp.checkIcon,
            fit: BoxFit.fitWidth,
            width: 26.r,
            height: 26.r,
          ),
        ),
        body: SingleChildScrollView(
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
              SelectVisibility(value: visibility, onChange: (p0) => visibility = p0),
              SelectCategory(value: category, onChange: (p0) => category = p0),
              SearchForTags(),
              CustomTextField(
                labelIcon: InkWell(
                  onTap: () {
                    AppDialogs.showDialog(
                      context,
                      okText: 'Ok, I got it',
                      onOkTap: () {},
                      body: _buildFormattingGuideBody(),
                    );
                  },
                  child: Tooltip(
                    message: 'More Information',
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: ColorsManager.black41,
                    ),
                  ),
                ),
                controller: contentController,
                labelText: 'Content',
                hintText: 'Write the content here',
                textInputType: TextInputType.multiline,
                maxLines: 5,
              ),
              UploadButton(
                onTap: () async {
                  File? file = await FileService.pickFile();
                  if (file?.path != null) {
                    final String path = file!.path.trim();
                    debugPrint("FILE PATH $path");
                    paths.add(path);
                    setState(() {});
                  }
                },
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final String filePath = paths.toList()[index];
                  return FileAttachmentItem(
                    fileName: filePath,
                    onDelete: () {
                      paths.remove(filePath);
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) => 5.heightBox,
                itemCount: paths.length,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattingGuideBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.heightBox,
          Text(
            'Formatting Guide',
            style: Styles.font15w600,
          ),
          Divider(),
          16.heightBox,
          _formatRow('Bold', '*word*'),
          _formatRow('Italic', '_word_'),
          _formatRow('Underline', '~word~'),
          _formatRow('Strikethrough', '-word-'),
          _formatRow('Hashtag', '#word'),
          _formatRow('Code Block', '`word`'),
          8.heightBox,
        ],
      ),
    );
  }

  Widget _formatRow(String title, String example) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Styles.font15w600),
          Text(example, style: Styles.font14w500),
        ],
      ),
    );
  }
}
