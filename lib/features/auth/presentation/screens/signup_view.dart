import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/loading/view/loading_dialog.dart';
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
          if (state is SignupLoading) {
            LoadingDialog.showLoadingDialog(context);
          } else {
            LoadingDialog.hideLoadingDialog();
          }
          if (state is SignupFailure) {
            CustomToast(context).showErrorToast(message: state.error.error);
          }
        },
        builder: (context, state) {
          final bloc = context.read<SignupBloc>();
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop == false && bloc.index > 0) {
                bloc.previousPage();
              }
            },
            child: PageView(
              controller: bloc.pageController,
              onPageChanged: (value) => bloc.add(OnPageChanged(index: value)),
              // physics: const NeverScrollableScrollPhysics(),
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


