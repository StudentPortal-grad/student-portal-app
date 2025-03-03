import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/file_service.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../../../groups/presentation/screens/choose_member_screen.dart';
import '../../../groups/presentation/widgets/member_item_view.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  String? communityImage;
  List<User> members = [
    User(id: '', fullname: 'test'),
  ];

  @override
  void dispose() {
    _groupNameController.dispose();
    members.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: CustomAppBar(
        title: Text('New Community', style: Styles.font20w600),
        action: Icon(Icons.check, color: Colors.black),
        actionOnTap: _handleCreateGroup,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomImageView(
                width: 100.w,
                height: 100.h,
                circle: true,
                onTap: () async {
                  communityImage = (await FileService.pickImage())?.path;
                  setState(() {});
                },
                imagePath: communityImage ?? AssetsApp.pickImage,
              ),
              40.heightBox,
              CustomTextField(
                controller: _groupNameController,
                prefixIcon: Icon(Icons.people, color: ColorsManager.gray2),
                hintText: 'Enter Community name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter community name';
                  }
                  return null;
                },
              ),
              35.heightBox,
              Row(
                // alignment: AlignmentDirectional.centerStart,
                children: [
                  Text(
                    "Members",
                    style:
                        Styles.font20w600.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      members = await push(ChooseMemberScreen(
                        title: 'Choose Members',
                      ));
                    },
                    icon: Icon(
                      Icons.add,
                      color: ColorsManager.mainColor,
                    ),
                  )
                ],
              ),
              15.heightBox,
              SizedBox(
                height: 350.h,
                child: ListView.separated(
                  itemBuilder: (context, index) => MemberItemView(
                    user: User(fullname: "Mina"),
                    onRemoveTap: (id) {
                      debugPrint(id);
                    },
                  ),
                  separatorBuilder: (context, index) => 15.heightBox,
                  itemCount: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCreateGroup() {
    if (_formKey.currentState!.validate()) {
      // Implement Community creation logic
      // This will be connected to your backend service
      debugPrint('Group Name: ${_groupNameController.text}');
    }
  }
}
