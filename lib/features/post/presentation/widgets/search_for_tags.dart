import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';

class SearchForTags extends StatefulWidget {
  const SearchForTags({super.key});

  @override
  State<SearchForTags> createState() => _SearchForTagsState();
}

class _SearchForTagsState extends State<SearchForTags> {
  final List<String> suggestions = [
    'Flutter',
    'AI',
    'UI',
    'Design',
    'Machine Learning',
    'UX'
  ];
  late TextEditingController _textEditingController;

  Set<String> dummyTags = {};

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return suggestions.where((option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            debugPrint('SelectedOption: $selection');
            setState(() {
              dummyTags.add(selection);
            });
            _textEditingController.clear();
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            _textEditingController = textEditingController; // Assign controller
            return CustomTextField(
              focusNode: focusNode,
              controller: _textEditingController,
              prefixIcon: CustomImageView(
                imagePath: AssetsApp.search2Icon,
                fit: BoxFit.none,
              ),
              hintText: 'Search for tags',
            );
          },
          optionsViewBuilder: _buildOptionItems,
        ),
        15.heightBox,
        Wrap(
          spacing: 7.w,
          runSpacing: 7.h,
          children: List.generate(
            dummyTags.length,
            (index) => CategoryTagView(
              index: index,
              title: dummyTags.toList()[index],
              removeTap: (String p0) {
                setState(() {
                  dummyTags.remove(p0);
                });
              },
              textColor: ColorsManager.mainColorLight,
              backGround: Colors.white,
              borderColor: ColorsManager.mainColorLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionItems(context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey)]),
          margin: EdgeInsetsDirectional.only(end: 50.w),
          constraints: BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return ListTile(
                title: Text(option),
                onTap: () => onSelected(option),
              );
            },
          ),
        ),
      );
}
