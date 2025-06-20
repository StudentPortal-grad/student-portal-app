import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/file_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../data/dto/attachment_dto.dart';
import '../../data/model/attachment.dart';
import '../../data/model/message.dart';
import '../manager/conversation_bloc/conversation_bloc.dart';

class AttachmentButtons extends StatelessWidget {
  const AttachmentButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ConversationBloc>();
    return Row(
      children: [
        CustomImageView(
          imagePath: AssetsApp.attachmentIcon,
          onTap: () async {
            final files = await FileService.pickFiles();
            if (files.isNotEmpty) {
              final paths = files.map((e) => e.path).toList();
              final attachments = files.map((e) => Attachment(url: e.path, type: 'file', fileName: e.path.split('/').last)).toList();
              final me = UserRepository.user;
              final Message message = Message(
                attachments: attachments,
                createdAt: DateTime.now(),
                uploading: true,
                conversationId: bloc.conversation?.id,
                sender: Sender(
                  id: me?.id ?? '',
                  name: me?.name ?? '',
                  profilePicture: me?.profilePicture ?? '',
                ),
              );

              bloc.add(SendAttachedMessageEvent(
                  message: message,
                  attachmentDto: AttachmentDto(
                    conversationId: bloc.conversation?.id ?? '',
                    attachments: paths,
                  )));
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: ColorsManager.gray3, size: 20.r),
          onPressed: () async {
            final files = await FileService.pickImages();
            if (files?.isNotEmpty ?? false) {
              final paths =
                  files?.map((e) => e?.path ?? '').toList() ?? [];
              final attachments = files
                  ?.map((e) => Attachment(url: e?.path ?? ''))
                  .toList();

              final me = UserRepository.user;
              final Message message = Message(
                attachments: attachments,
                createdAt: DateTime.now(),
                uploading: true,
                conversationId: bloc.conversation?.id,
                sender: Sender(
                  id: me?.id ?? '',
                  name: me?.name ?? '',
                  profilePicture: me?.profilePicture ?? '',
                ),
              );

              bloc.add(SendAttachedMessageEvent(
                  message: message,
                  attachmentDto: AttachmentDto(
                    conversationId: bloc.conversation?.id ?? '',
                    attachments: paths,
                  )));
            }
          },
        ),
      ],
    );
  }
}