import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_dialog.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/custom_toast.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/home/presentation/manager/create_post_bloc/create_post_bloc.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/circular_percent_widget.dart';
import '../../data/dto/post_dto.dart';
import '../widgets/file_attachment_item.dart';
import '../widgets/search_for_tags.dart';
import '../../../../core/widgets/upload_button.dart';
import '../../../../core/widgets/warning_dialog_body.dart';

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

  noChanges({int? imagesLen, int? tagsLen}) {
    return titleController.text.isEmpty &&
        contentController.text.isEmpty &&
        (imagesLen == null || imagesLen == 0) &&
        (tagsLen == null || tagsLen == 0);
  }

  back({int? imagesLen, int? tagsLen}) {
    noChanges(imagesLen: imagesLen, tagsLen: imagesLen)
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
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostLoading) {
          showUploadDialog(context, bloc: context.read<CreatePostBloc>());
        }
        if (state is CreatePostFailed) {
          pop();
          CustomToast(context).showErrorToast(message: state.message);
        }
        if (state is CreatePostLoaded) {
          pop();
          pop();
          CustomToast(context).showSuccessToast(message: state.message);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop == false) back();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: Text(
              'New Post',
              style: Styles.font20w600,
            ),
            leadingOnTap: () {
              final bloc = context.read<CreatePostBloc>();
              return back(
                tagsLen: bloc.tags.length,
                imagesLen: bloc.paths.length,
              );
            },
            action: CustomImageView(
              onTap: () {
                final bloc = context.read<CreatePostBloc>();
                if(titleController.text.isEmpty && contentController.text.isEmpty){
                  CustomToast(context).showErrorToast(message: 'Please enter title and content');
                  return;
                }
                bloc.add(
                  CreatePostRequested(
                    PostDto(
                      title: titleController.text,
                      content: contentController.text,
                      images: bloc.paths,
                      tags: bloc.tags,
                    ),
                  ),
                );
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
                BlocBuilder<CreatePostBloc, CreatePostState>(
                  buildWhen: (previous, current) => current is ChooseTagsState,
                  builder: (context, state) {
                    final bloc = context.read<CreatePostBloc>();
                    return SearchForTags(
                      tags: bloc.tags.toSet(),
                      onChange: (Set<String> selectedTags) =>
                          bloc.add(AddingPostTags(selectedTags)),
                    );
                  },
                ),
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
                  onTap: () async =>
                      context.read<CreatePostBloc>().add(UploadingPostImages()),
                ),
                Center(
                  child: BlocBuilder<CreatePostBloc, CreatePostState>(
                    buildWhen: (previous, current) =>
                        current is RemoveImagesState ||
                        current is UploadedImagesState,
                    builder: (context, state) {
                      final bloc = context.read<CreatePostBloc>();
                      return Wrap(
                        spacing: 5.w,
                        runSpacing: 5.h,
                        children: List.generate(
                          bloc.paths.length,
                          (index) {
                            final String filePath = bloc.paths.toList()[index];
                            return FileAttachmentItem(
                              fileName: filePath,
                              onDelete: () =>
                                  bloc.add(RemovePostImages(filePath)),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                0.05.sh.heightBox,
              ],
            ),
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

  void showUploadDialog(BuildContext context, {required CreatePostBloc bloc}) {
    AppDialogs.showDialog(
      context,
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<CreatePostBloc, CreatePostState>(
          buildWhen: (previous, current) {
            return current is CreatePostUploading ||
                current is CreatePostLoading;
          },
          builder: (context, state) {
            double percent = 0;
            String label = "Preparing to Upload...";
            Widget content = const LoadingScreen(
              baseColor: ColorsManager.mainColor,
              highlightColor: ColorsManager.mainColorLight,
            );
            if (state is CreatePostUploading) {
              percent = state.percent.toDouble().clamp(0.0, 1.0);
              label = "Uploading... ${(percent * 100).toStringAsFixed(0)}%";
              content = CircularPercentWidget(percent: state.percent.toDouble());
            }
            return Column(
              children: [
                20.heightBox,
                content,
                18.heightBox,
                Text(label, style: Styles.font16w700),
                25.heightBox,
              ],
            );
          },
        ),
      ),
    );
  }
}
