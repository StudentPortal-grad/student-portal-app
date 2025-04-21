import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../search/presentation/screens/not_found_search_view.dart';
import '../../../search/presentation/widgets/searched_people.dart';

class SearchPeerScreen extends StatefulWidget {
  const SearchPeerScreen({super.key});

  @override
  State<SearchPeerScreen> createState() => _SearchPeerScreenState();
}

class _SearchPeerScreenState extends State<SearchPeerScreen> {
  late final TextEditingController _controller;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColor,
        title: Text(
          'Search',
          style: Styles.font20w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
              controller: _controller,
              prefixIcon: CustomImageView(
                imagePath: AssetsApp.search2Icon,
                fit: BoxFit.none,
              ),
              hintText: 'Search...',
              onFieldSubmitted: (p0) {
                setState(() {
                  isEmpty = p0.isEmpty;
                });
              },
            ),
            20.heightBox,
            !isEmpty
                ? Expanded(child: NotFoundView())
                : Expanded(child: SearchedPeople()),
          ],
        ),
      ),
    );
  }
}
