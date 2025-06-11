import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../data/model/post_model/attachment.dart';
import '../pages/image_post_screen.dart';

class PostListImagesView extends StatefulWidget {
  const PostListImagesView({super.key, this.attachments = const []});

  final List<Attachment> attachments;

  @override
  State<PostListImagesView> createState() => _PostListImagesViewState();
}

class _PostListImagesViewState extends State<PostListImagesView> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.attachments.isEmpty) return const SizedBox.shrink();
    if (widget.attachments.length == 1) {
      return GestureDetector(
        onTap: () {
          if (widget.attachments[0].type == 'image') {
            push(
              ImagePostView(
                id: 0,
                attachment: widget.attachments[0],
              ),
            );
          }
        },
        child: PostImageView(index: 0, attachment: widget.attachments[0]),
      );
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200.h,
            minHeight: 100.h,
          ),
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value + 1;
              });
            },
            scrollDirection: Axis.horizontal,
            itemCount: widget.attachments.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (widget.attachments[index].type == 'image') {
                  push(
                    ImagePostView(
                      id: index,
                      attachment: widget.attachments[index],
                    ),
                  );
                }
              },
              child: PostImageView(
                index: index,
                attachment: widget.attachments[index],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 8.h,
            right: 8.w,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(13.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          child: Text('$currentIndex/${widget.attachments.length}',
              style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView(
      {super.key, required this.attachment, required this.index});

  final Attachment attachment;
  final int index;

  @override
  Widget build(BuildContext context) {
    final uniqueTag = '${attachment.checksum ?? attachment.resource}_$index';

    return Hero(
      tag: uniqueTag,
      child: CustomImageView(
        materialNeeded: true,
        imagePath: attachment.resource,
        height: 200.h,
        width: 1.sw,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
