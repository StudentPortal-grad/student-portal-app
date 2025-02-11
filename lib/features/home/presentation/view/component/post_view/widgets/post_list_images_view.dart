import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/helpers/extensions.dart';
import '../../../../../../../core/widgets/custom_image_view.dart';
import '../image_post_screen.dart';

class PostListImagesView extends StatefulWidget {
  const PostListImagesView({super.key});

  @override
  State<PostListImagesView> createState() => _PostListImagesViewState();
}

class _PostListImagesViewState extends State<PostListImagesView> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // if(false){  if list's length == 1
    //   return PostImageView(id: 1);
    // }
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
            itemCount: 5,
            itemBuilder: (context, index) => PostImageView(id: index),
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
          child: Text('$currentIndex/5', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image$id',
      child: CustomImageView(
        materialNeeded: true,
        onTap: () => push(ImagePostView(id: id)),
        imagePath:
            'https://www.news10.com/wp-content/uploads/sites/64/2024/11/674205c2471ac7.00644903.jpeg?w=960&h=540&crop=1',
        height: 200.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
