import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/file_service.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  String? groupImage;

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: CustomAppBar(
        title: Text('New Group', style: Styles.font20w600),
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
                  groupImage = (await FileService.pickImage())?.path;
                  setState(() {});
                },
                imagePath: groupImage ?? AssetsApp.pickImage,
              ),
              40.heightBox,
              CustomTextField(
                controller: _groupNameController,
                prefixIcon: Icon(Icons.people, color: ColorsManager.gray2),
                hintText: 'Enter group name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter group name';
                  }
                  return null;
                },
              ),
              40.heightBox,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Members",
                  style:
                      Styles.font20w600.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              // todo build list of members
            ],
          ),
        ),
      ),
    );
  }

  void _handleCreateGroup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement group creation logic
      // This will be connected to your backend service
      print('Group Name: ${_groupNameController.text}');
    }
  }
}
