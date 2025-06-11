import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_item_view.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../data/model/resource.dart';
import '../widgets/resource_comment_bar.dart';

class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({super.key, this.resource});

  final Resource? resource;

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.whiteColor,
        centerTitle: false,
        title: Text('Resource', style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: ResourceItemView(
          resource: widget.resource,
          detailsChildren: [
            ResourceCommentBar(),
            20.heightBox,
            // ...List.generate(2, (index) => PostCommentsView()),
          ],
        ),
      ),
    );
  }
}
