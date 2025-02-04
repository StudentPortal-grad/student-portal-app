import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/auth/presentation/view/login_view/widgets/login_body.dart';
import '../../../../../contestants.dart';
import '../../../../../core/loading/view/loading_dialog.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../mange/login_bloc/login_bloc.dart';
import '../../mange/login_bloc/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoadingState) {
              LoadingDialog.showLoadingDialog(context);
            } else {
              LoadingDialog.hideLoadingDialog();
            }
            if (state is LoadingFailure) {
              CustomToast(context).showErrorToast(message: state.error);
            }
            if (state is LoadingSuccess) {
              CustomToast(context).showSuccessToast(message: 'Login Successfully');
              if (state.response.data?.emailActive == true) {
                AppRouter.router.pushReplacement(AppRouter.homeView);
              } else {
                // AppRouter.router.pushReplacement(AppRouter.otpView);
              }
            }
          },
          builder: (context, state) {
            return PopScope(
              canPop: false,
              child: LoginBody(),
            );
          },
        ),
      ),
    );
  }
}
