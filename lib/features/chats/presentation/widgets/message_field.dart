import 'dart:developer';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../core/theming/text_styles.dart';
import 'attachment_buttons.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key, this.controller, this.onSendTap});

  final TextEditingController? controller;
  final Function(String)? onSendTap;

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool isTyping = false;
  bool isEmpty = true;
  bool isEmojiPickerVisible = false;
  bool isRecording = false;
  DateTime? _recordingStartTime;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {
        isTyping = _controller.text.isNotEmpty;
        isEmpty = _controller.text.trim().isEmpty;
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
                    hintText: isRecording ? "Recording..." : "Type message...",
                    enabled: !isRecording,
                    activeBorderColor: Colors.transparent,
                    hintStyle: Styles.font14w400
                        .copyWith(color: ColorsManager.lightGrayColor2),
                    textInputAction: TextInputAction.done,
                    onChanged: (p0) {},
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
                15.widthBox,
                if (!isRecording) AttachmentButtons(),
                5.widthBox,
                (isEmpty)
                    ? SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          log('Message: ${_controller.text}');
                          widget.onSendTap?.call(_controller.text);
                          _controller.clear();
                          setState(() {
                            isTyping = false;
                            isEmpty = true;
                          });
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
// ignore: unused_element
  Widget _buildAudionButton() {
    return GestureDetector(
      onLongPressStart: (_) async {
        setState(() {
          isRecording = true;
          _recordingStartTime = DateTime.now();
        });

        // await _audioService.startRecording(); // Start Recording
      },
      onLongPressEnd: (_) async {
        if (isRecording) {
          final now = DateTime.now();
          final duration = now.difference(_recordingStartTime!);

          if (duration.inSeconds < 1) {
            // await _audioService.cancelRecording(); // Cancel if too short
            log("Recording canceled (too short)");
          } else {
            // final audioPath = await _audioService.stopRecording();
            // if (audioPath != null) {
            //   log('Audio recorded at: $audioPath');
            //   TODO: Handle sending/storing the audio file
            // }
          }

          setState(() {
            isRecording = false;
            _recordingStartTime = null;
          });
        }
      },
      onLongPressMoveUpdate: (details) {
        // TODO: Add visual feedback for cancel gesture
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          isRecording ? Icons.mic : Icons.mic_none,
          color: isRecording ? ColorsManager.mainColor : ColorsManager.gray,
        ),
      ),
    );
  }
}
