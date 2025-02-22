import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/file_service.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool isTyping = false;
  bool isEmpty = true;
  bool isEmojiPickerVisible = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = widget.controller;
    _controller.addListener(() {
      setState(() {
        isTyping = _controller.text.isNotEmpty;
        isEmpty = _controller.text.isEmpty;
      });
    });

    // Hide emoji picker when keyboard opens
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isEmojiPickerVisible = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  void _toggleEmojiKeyboard() {
    setState(() {
      isEmojiPickerVisible = !isEmojiPickerVisible;
      if (isEmojiPickerVisible) {
        FocusScope.of(context).unfocus(); // Hide keyboard
      } else {
        _focusNode.requestFocus(); // Show keyboard
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: ColorsManager.backgroundColorLight,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                5.widthBox,
                IconButton(
                  onPressed: _toggleEmojiKeyboard,
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: ColorsManager.gray,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    borderColor: Colors.transparent,
                    focusNode: _focusNode,
                    controller: _controller,
                    hintText: "Type message...",
                    activeBorderColor: Colors.transparent,
                    hintStyle: Styles.font14w400
                        .copyWith(color: ColorsManager.lightGreyColor2),
                    textInputAction: TextInputAction.done,
                    onChanged: (p0) {},
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
                15.widthBox,
                CustomImageView(
                  imagePath: AssetsApp.attachmentIcon,
                  onTap: () async {
                    final file = await FileService.pickFile();
                    print(file?.path ?? 'not selected');
                  },
                ),
                5.widthBox,
                (isEmpty)
                    ? IconButton(
                        onPressed: () {
                          // todo handle recording logic and ui
                        },
                        icon: Icon(Icons.mic_none, color: ColorsManager.gray),
                      )
                    : IconButton(
                        onPressed: () {
                          // todo send message logic
                        },
                        icon: Icon(Icons.send_rounded,
                            color: ColorsManager.mainColor),
                      ),
                5.widthBox,
              ],
            ),
          ),
        ),
        if (isEmojiPickerVisible)
          EmojiPicker(
            onBackspacePressed: () {
              _controller.text =
                  _controller.text.characters.skipLast(1).toString();
            },
            onEmojiSelected: (category, emoji) {
              _controller.text += emoji.emoji;
            },
          ),
      ],
    );
  }
}
