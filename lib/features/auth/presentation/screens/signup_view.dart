import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/utils/app_router.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/signup_bloc/signup_bloc.dart';
import '../manager/signup_bloc/signup_event.dart';
import '../manager/signup_bloc/signup_state.dart';
import '../widgets/academic_data_view.dart';
import '../widgets/complete_profile.dart';
import '../widgets/personal_data_view.dart';
import '../widgets/signup_body.dart';
import '../widgets/verify_email.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is ResendOtpLoading) {
            if (context.read<SignupBloc>().index != 1) {
              context.read<SignupBloc>().pageController.jumpToPage(1);
            }
          }
          if (state is UpdateDataSuccess) {
            CustomToast(context).showSuccessToast(message: 'Welcome!');
            AppRouter.clearAndNavigate(AppRouter.homeView);
          }
          if (state is SignupFailure) {
            CustomToast(context).showErrorToast(message: state.error.message);
          }
          if (state is UpdateDataFailure) {
            CustomToast(context).showErrorToast(message: state.error.message);
          }
        },
        builder: (context, state) {
          final bloc = context.read<SignupBloc>();
          return PopScope(
            canPop: false,
            child: PageView(
              controller: bloc.pageController,
              onPageChanged: (value) => bloc.add(OnPageChanged(index: value)),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SignupBody(),
                VerifyEmailView(),
                PersonalDataView(),
                AcademicDataView(),
                CompleteProfileView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
