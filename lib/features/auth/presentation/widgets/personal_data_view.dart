import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/features/auth/presentation/manager/signup_bloc/signup_bloc.dart';

import '../../../../core/helpers/date_picker_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_phone_number_input.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/signup_bloc/signup_event.dart';
import '../manager/signup_bloc/signup_state.dart';
import 'choose_gender_button.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        final bloc = context.read<SignupBloc>();
        return Form(
          key: bloc.personalFormKey,
          child: Column(
            children: [
              CustomAppBar(
                  title: "Personal Data".make(style: Styles.font20w600),
                  showLeading: false),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Column(
                    spacing: 20.h,
                    children: [
                      CustomImageView(
                        width: 100.w,
                        height: 100.h,
                        circle: true,
                        onTap: ()  => bloc.add(OnProfileImagePicked()),
                        imagePath: bloc.profileImage ?? AssetsApp.pickImage,
                      ),
                      ChooseGenderButton(value: bloc.gender,onChange: (p0) => bloc.gender = p0,),
                      CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')), // Prevent spaces
                        ],
                        prefixIcon: Center(child: Text('@', style: Styles.font14w500)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.contains(' ')) {
                            return 'Username cannot contain spaces';
                          }
                        },
                        textInputType: TextInputType.name,
                        hintText: "User Name",
                        labelText: 'User Name',
                        labelStyle: Styles.font14w500,
                        controller: bloc.userNameController,
                      ),
                      CustomPhoneNumberInput(
                        phoneController: bloc.phoneController,
                        labelText: 'Phone Number',
                        labelStyle: Styles.font14w500,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        onInputChanged: (PhoneNumber number) => bloc.phoneNumber = number,
                      ),
                      CustomTextField(
                        textInputType: TextInputType.none,
                        hintText: "Date of Birth",
                        labelText: 'Date of Birth',
                        labelStyle: Styles.font14w500,
                        showCursor: false,
                        controller: bloc.dateOfBirthController,
                        suffix: Icon(Icons.calendar_month_rounded),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birthDate';
                          }
                        },
                        onTap: () async {
                          DateTime? birthData = await DatePickerHelper.pickDate(context, initialDate: DateTime(2003));
                          if (birthData != null) {
                            bloc.dateOfBirth = birthData.toIso8601String();
                            bloc.dateOfBirthController.text =
                                DateFormat('dd/MM/yyyy').format(birthData);
                          }
                        },
                      ),
                      CustomAppButton(
                        margin: EdgeInsets.only(top: 20.h),
                        onTap: () {
                          if(!bloc.personalFormKey.currentState!.validate()) return;
                          bloc.nextPage();
                        },
                        label: "Next",
                        textStyle: Styles.font16w700
                            .copyWith(color: ColorsManager.whiteColor),
                        width: 260.w,
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
