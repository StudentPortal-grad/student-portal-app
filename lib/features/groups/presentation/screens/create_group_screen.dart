import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/extensions.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../manager/create_group_bloc/create_group_bloc.dart';
import '../widgets/member_item_view.dart';
import 'choose_member_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late final CreateGroupBloc bloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _groupNameController;

  @override
  void initState() {
    bloc = context.read<CreateGroupBloc>();
    _groupNameController = TextEditingController();
    super.initState();
  }

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
              BlocSelector<CreateGroupBloc, CreateGroupState, String?>(
                selector: (state) => bloc.groupImagePath,
                builder: (context, state) {
                  return Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      CustomImageView(
                        width: 100.r,
                        height: 100.r,
                        circle: true,
                        fit: BoxFit.cover,
                        onTap: () async => bloc.add(UploadGroupImage()),
                        imagePath: bloc.groupImagePath ?? AssetsApp.pickImage,
                      ),
                      if (bloc.groupImagePath != null)
                        IconButton(
                          onPressed: () async => bloc.add(UploadGroupImage(removeImage: true)),
                          icon: Icon(
                            Icons.close,
                            color: ColorsManager.orangeColor,
                            size: 20.r,
                          ),
                        ),
                    ],
                  );
                },
              ),
              40.heightBox,
              CustomTextField(
                controller: _groupNameController,
                prefixIcon: Icon(Icons.people, color: ColorsManager.gray2),
                hintText: 'Enter group name',
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter group name';
                  }
                  return null;
                },
              ),
              35.heightBox,
              Row(
                children: [
                  Text(
                    "Members",
                    style:
                    Styles.font20w600.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      bloc.add(GetUsersSiblings());
                      push(ChooseMemberScreen(bloc: bloc));
                    },
                    icon: Icon(
                      Icons.add,
                      color: ColorsManager.mainColor,
                    ),
                  )
                ],
              ),
              15.heightBox,
              BlocBuilder<CreateGroupBloc, CreateGroupState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 350.h,
                    child: ListView.separated(
                      itemBuilder: (context, index) => MemberItemView(
                            userSibling: bloc.selectedUsers.toList()[index],
                            onRemoveTap: (id) => bloc.add(AddOrRemoveUsers(bloc.selectedUsers.toList()[index],isAdding: false)),
                          ),
                      separatorBuilder: (context, index) => 15.heightBox,
                      itemCount: bloc.selectedUsers.length,
                    ),
                  );
                },
              ),
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
      log('Group Name: ${_groupNameController.text}');
    }
  }
}
