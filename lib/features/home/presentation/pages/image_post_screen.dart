import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../data/model/post_model/attachment.dart';

class ImagePostView extends StatelessWidget {
  const ImagePostView({
    super.key,
    required this.id,
    this.attachment, this.title,
  });

  final int id;
  final Attachment? attachment;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final uniqueTag = '${attachment?.checksum ?? attachment?.resource}_$id';

    if (attachment == null) return const SizedBox.shrink();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title ?? "Post",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: WidgetZoom(
              heroAnimationTag: uniqueTag,
              zoomWidget: Center(
                child: CustomImageView(
                  materialNeeded: true,
                  imagePath: attachment?.resource,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Caption
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
            child: Text(
              attachment?.originalFileName ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
