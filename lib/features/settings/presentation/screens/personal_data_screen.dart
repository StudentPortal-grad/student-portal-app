import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_phone_number_input.dart';
import 'package:student_portal/features/auth/presentation/widgets/choose_gender_button.dart';

import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/helpers/date_picker_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../profile/presentation/manager/profile_bloc/profile_bloc.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: 'Personal Data'.make(style: Styles.font20w600),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              CustomToast(context)
                  .showSuccessToast(message: "Profile Updated Successfully");
              AppRouter.router.pop();
            }
            if (state is ProfileFailureState) {
              CustomToast(context).showErrorToast(
                  message: state.failure.message ??
                      "Unknown Error, Please try again later");
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<ProfileBloc>(context);
            return Form(
              key: bloc.personalFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.heightBox,
                    ChooseGenderButton(value: bloc.gender,onChange: (p0) => bloc.gender = p0,),
                    30.heightBox,
                    CustomPhoneNumberInput(
                      phoneController: bloc.phoneController,
                      onInputChanged: (PhoneNumber number) => bloc.phoneNumber = number,
                      labelText: 'Phone Number',
                      labelStyle: Styles.font14w500,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    30.heightBox,
                    CustomTextField(
                      textInputType: TextInputType.none,
                      hintText: "Date of Birth",
                      labelText: 'Date of Birth',
                      labelStyle: Styles.font14w500,
                      showCursor: false,
                      controller: bloc.dateOfBirthController,
                      suffix: Icon(Icons.calendar_month_rounded),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your birthDate';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? birthData = await DatePickerHelper.pickDate(context, initialDate: DateTime(2003));
                        if (birthData != null) {
                          bloc.dateOfBirth = birthData.toIso8601String();
                          bloc.dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(birthData);
                        }
                      },
                    ),
                    30.heightBox,
                    CustomAppButton(
                      loading: state is ProfileLoadingState,
                      onTap: () {
                        if (!bloc.personalFormKey.currentState!.validate()) return;
                        bloc.add(UpdateMyPersonalDataEvent());
                      },
                      label: "Save Changes",
                      textStyle: Styles.font16w700
                          .copyWith(color: ColorsManager.whiteColor),
                      width: 260.w,
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
